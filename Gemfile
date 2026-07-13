source "https://rubygems.org"

# Jekyll + the plugins we use. Pinned to a current Jekyll 4 line; the GitHub
# Actions build uses this Gemfile directly (not the github-pages gem), so we
# are free to use Jekyll 4 and modern plugins.
gem "jekyll", "~> 4.3"

group :jekyll_plugins do
  gem "jekyll-seo-tag", "~> 2.8"
  gem "jekyll-sitemap", "~> 1.4"
end

# Windows / JRuby timezone + faster file watching (harmless elsewhere).
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "wdm", "~> 0.1.1", platforms: [:mingw, :mswin, :x64_mingw]
