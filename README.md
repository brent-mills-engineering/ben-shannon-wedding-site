# Ben & Shannon Wedding Site

A simple, informational Jekyll site for Ben and Shannon's wedding, hosted on
GitHub Pages. Static content only (no forms at present): event details, travel
and accommodations, registry, and FAQ, plus links out to external items like
hotel room blocks.

> This is an early scaffold. It will be rebuilt once the design packet is ready.

## Stack

- **Jekyll 4** (hand-authored markup, no theme), see `Gemfile`
- **Ruby 3.3** (`.ruby-version`)
- Plugins: `jekyll-seo-tag`, `jekyll-sitemap`
- **GitHub Actions** build + deploy to GitHub Pages (`.github/workflows/jekyll.yml`)

## Local development

```sh
bundle install
bundle exec jekyll serve --livereload
```

Then open http://127.0.0.1:4000/.

## Deployment

Every push to `main` triggers `.github/workflows/jekyll.yml`, which builds with
Jekyll and deploys to GitHub Pages.

**One-time repo setting:** in **Settings → Pages → Build and deployment**, set
**Source** to **GitHub Actions**. (The default "Deploy from a branch" source
ignores this workflow.)

## Custom domain

No domain is configured yet. When one is ready:

1. Add a `CNAME` file at the repo root containing the bare domain.
2. Configure the domain's DNS to point at GitHub Pages.
3. Set the custom domain under **Settings → Pages**.

The build passes `--baseurl` automatically, so internal links (all using the
`relative_url` filter) work at the current project subpath and will continue to
work once served from a root domain.

## Structure

```
_config.yml            Site config
_data/nav.yml          Top navigation items
_layouts/default.html  Page shell
_includes/             head, header, footer partials
assets/css/main.css    Styles (placeholder, pre-design-packet)
index.md               Home
schedule.md            Schedule / events
travel.md              Travel & accommodations (room blocks)
things-to-do.md        Local recommendations
registry.md            Registry links
faq.md                 Frequently asked questions
```
