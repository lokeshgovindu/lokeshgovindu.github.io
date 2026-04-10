# DevTips Blog

Jekyll-powered programmer blog for tips, tricks, and best practices.

## Write A New Post

1. Create a file in `_posts` using this format:

   `YYYY-MM-DD-title.md`

2. Add front matter:

   ```yaml
   ---
   layout: post
   title: "Your Post Title"
   date: 2026-04-10 10:00:00 +0530
   tags: [JavaScript, Productivity]
   ---
   ```

3. Write markdown content below the front matter.

## Local Preview

If you have Ruby/Jekyll installed:

```bash
bundle exec jekyll serve
```

Then open `http://127.0.0.1:4000`.

## Deployment

Push to `main`. GitHub Pages builds and publishes automatically for this repository.
