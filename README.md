# Productivity Tools, Tips & Tricks

A curated hub of productivity tips, shortcuts, and workflows for developers — Visual Studio, CMD Prompt, Windows, and more — plus a showcase of personal open-source projects and a blog for longer-form notes.

**Live site:** [lokeshgovindu.github.io](https://lokeshgovindu.github.io)

## What's here

- **Windows / CMD Prompt / Visual Studio** — curated tools, extensions, and shortcuts. Every tool and extension has its own dedicated page (e.g. `/windows/powertoys/`), so it can carry its own comment thread instead of one shared thread per category.
- **My Work** — a showcase of personal open-source projects, each with its own page.
- **Blog** — longer-form notes, written and published through the site itself (see below).
- **Search** — press `Ctrl + K` (or `Cmd + K`) anywhere on the site, or visit `/search/`. Fuzzy search across tools, tips, projects, and posts, filterable by category or tag.
- **Light / dark mode** — toggle in the navbar; respects your OS preference by default.
- **Comments** — via [giscus](https://giscus.app) (backed by GitHub Discussions) on tool, extension, and project pages.

## Tech stack

- **[Jekyll](https://jekyllrb.com/)** static site generator, hosted on **GitHub Pages**
- **kramdown** for Markdown, with `jekyll-sitemap` and `jekyll-feed`
- Plain HTML/CSS/vanilla JS — no build step, no frontend framework
- **Bootstrap 5** and **Font Awesome 6**, vendored locally under `assets/vendor/` (not loaded from a CDN)
- **[Fuse.js](https://www.fusejs.io/)** for client-side fuzzy search
- **[giscus](https://giscus.app)** for comments
- **Google Analytics (GA4)** for traffic analytics

## Writing a blog post

There are two ways to publish a post — you don't need a local dev environment for either:

1. **Through the site itself** — go to `/admin/`, sign in with a [fine-grained GitHub personal access token](https://github.com/settings/personal-access-tokens/new) scoped to this one repo (`Contents: Read and write`), and use the editor. Supports new posts, drafts (private until you publish them), editing/renaming/deleting existing posts, and image uploads — all committed straight to this repo via GitHub's API, no git required.
2. **By hand** — add a file to `_posts/` named `YYYY-MM-DD-your-title.md` with `title` (and optionally `tags`) in the front matter, then Markdown below. The filename's date controls sort order and the displayed date; the URL itself is just `/blog/your-title/`, with no date in it.

## Running locally

**Prerequisites:** Ruby and Bundler. On Windows, a native gem in the dependency chain also needs the MSYS2/MinGW toolchain — if `bundle install` fails trying to compile a gem, run `ridk install` and choose option 3 (MSYS2 and MINGW development toolchain).

```sh
bundle install
bundle exec jekyll serve --host 127.0.0.1 --port 8080
```

Then open `http://127.0.0.1:8080`. On Windows, `start-website.bat` does the same thing and opens the site in your browser automatically.

## Continuous integration

Every push and pull request against `master` runs a GitHub Actions workflow (`.github/workflows/build-check.yml`) that:

- Builds the site with Jekyll
- Checks every generated `.js` file for syntax errors
- Confirms `robots.txt` renders as plain text, not wrapped in the site's HTML layout
- Checks every internal link and same-page `#fragment` resolves to something real (`script/check_links.rb`), catching broken links from renames or restructuring before they reach the live site
