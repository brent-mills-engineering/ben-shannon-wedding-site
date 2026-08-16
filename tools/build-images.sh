#!/usr/bin/env bash
#
# Regenerate the responsive photo derivatives served by the site.
#
#   masters      _photos-src/<name>.jpg   (committed, excluded from the Jekyll build)
#   derivatives  assets/img/<name>-<w>.webp and .jpg
#
# Each photo is centre-cropped to the aspect ratio its slot actually renders at,
# then emitted at the widths that slot needs at 1x and 2x. Cropping up front
# matters: the CSS boxes use `object-fit:cover`, so any pixels outside the slot's
# aspect ratio are downloaded and then thrown away. Cropping here also makes the
# srcset `w` descriptors honest, because after the crop the image and its box
# share an aspect ratio and the browser's width maths lines up with what renders.
#
# Widths are never upscaled. If a master is smaller than a requested width, the
# derivative caps at the master's width and the descriptor reports that instead.
#
# Requires ImageMagick 7 (`brew install imagemagick`). Run from the repo root.

set -euo pipefail

SRC="_photos-src"
OUT="assets/img"

command -v magick >/dev/null || { echo "error: ImageMagick 7 (magick) not found" >&2; exit 1; }
[ -d "$SRC" ] || { echo "error: run from the repo root ($SRC not found)" >&2; exit 1; }

# name | aspect (w:h, or "native") | comma-separated widths
#
# Slot widths come from the layout in assets/css/main.css:
#   .tiles--wide  -> 3 cols of 373px in .wrap--page   (things to do)
#   .tiles--two   -> 2 cols of 576px in .wrap--page   (hotels)
#   .split 6fr    -> 545px  /  .split 5fr -> 455px    (arch photos, faq plate)
#   .hero         -> full bleed
# Listing plates render at 16:10, arch niches at 4:5 (inline aspect-ratio).
MANIFEST="
fort-mchenry       16:10  400,800
walters            16:10  400,800
charles-theatre    16:10  400,800
artifact           16:10  400,800
dylans             16:10  400,800
true-chesapeake    16:10  400,800
ekiben             16:10  400,800
little-donnas      16:10  400,800
thames-street      16:10  400,800
ceremony-coffee    16:10  400,800
dutch-courage      16:10  400,800
union-craft        16:10  400,800
courtyard          16:10  576,1152
delta              16:10  576,1152
hotel-revival      16:10  576,1152
hotel-ulysses      16:10  576,1152
couple-walking     16:10  545,1090
st-ignatius        4:5    480,1090
maryland-center    4:5    480,1090
couple-steps       4:5    455,910
couple-light-rail  4:5    455,910
couple-garden      4:5    455,910
couple-arch        native 960,1440,1600
"

# Per-image quality as "<webp> <jpeg>". Defaults to 82/82.
#   couple-arch   sits under an 0.88-opacity scrim, so it tolerates harder
#                 compression than a photo viewed directly.
#   couple-garden is foliage and ironwork, which WebP handles poorly: at q82 it
#                 came out 7% LARGER than the JPEG. q76 puts it 11% ahead.
q_for() {
  case "$1" in
    couple-arch)   echo "72 78" ;;
    couple-garden) echo "76 82" ;;
    *)             echo "82 82" ;;
  esac
}

rm -f "$OUT"/*-[0-9]*.webp "$OUT"/*-[0-9]*.jpg

printf "%-19s %-7s %-11s %s\n" NAME ASPECT SOURCE "DERIVATIVES"

while read -r name aspect ladder; do
  [ -z "${name:-}" ] && continue
  src="$SRC/$name.jpg"
  [ -f "$src" ] || { echo "error: missing master $src" >&2; exit 1; }

  read -r sw sh <<<"$(magick identify -format '%w %h' "$src")"
  read -r qwebp qjpg <<<"$(q_for "$name")"

  # Centre-crop to the slot's aspect ratio, mirroring object-fit:cover with the
  # default 50% 50% object-position, so framing is unchanged from before.
  work="$(mktemp -t bi).png"
  if [ "$aspect" = "native" ]; then
    magick "$src" -auto-orient -strip "$work"
    cw=$sw; ch=$sh
  else
    aw="${aspect%%:*}"; ah="${aspect##*:}"
    # Fit the largest w:h rectangle inside the master.
    if [ $((sw * ah)) -gt $((sh * aw)) ]; then
      ch=$sh; cw=$(( sh * aw / ah ))
    else
      cw=$sw; ch=$(( sw * ah / aw ))
    fi
    magick "$src" -auto-orient -strip -gravity center -crop "${cw}x${ch}+0+0" +repage "$work"
  fi

  emitted=""
  seen=""
  for want in ${ladder//,/ }; do
    w=$want
    [ "$w" -gt "$cw" ] && w=$cw          # never upscale
    case " $seen " in *" $w "*) continue ;; esac
    seen="$seen $w"
    magick "$work" -resize "${w}x" -quality "$qwebp" -define webp:method=6 "$OUT/$name-$w.webp"
    magick "$work" -resize "${w}x" -quality "$qjpg"  -interlace JPEG      "$OUT/$name-$w.jpg"
    emitted="$emitted $w"
  done
  rm -f "$work"

  printf "%-19s %-7s %-11s %s\n" "$name" "$aspect" "${sw}x${sh}" "${emitted# }"
done <<<"$(echo "$MANIFEST" | sed '/^[[:space:]]*$/d')"

echo
echo "derivatives: $(ls "$OUT"/*-[0-9]*.webp "$OUT"/*-[0-9]*.jpg 2>/dev/null | wc -l | tr -d ' ') files, $(du -sh "$OUT" | cut -f1) total"
