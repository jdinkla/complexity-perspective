# Deployment Guide

This document describes how to publish the compiled files from the `dist` folder for use by other projects (e.g., Jekyll/GitHub Pages sites).

## Option 1: GitHub Actions (Recommended)

This is the recommended approach as it:
- Automatically builds and deploys on every push
- Doesn't require committing compiled code
- Uses GitHub Pages natively

### Setup

1. **Enable GitHub Pages** in your repository settings:
   - Go to Settings → Pages
   - Source: **GitHub Actions** (not "Deploy from a branch")
   - The workflow will handle deployment automatically

2. **The GitHub Actions workflow** (`.github/workflows/deploy.yml`) will:
   - Build the Dart project on every push to `main`/`master`
   - Create the `dist` folder with compiled files
   - Deploy to GitHub Pages automatically

3. **Access your site** at:
   ```
   https://<username>.github.io/complexity-perspective/
   ```

### Manual Trigger

You can also manually trigger the workflow:
- Go to Actions tab → "Build and Deploy to GitHub Pages"
- Click "Run workflow"

### Using in Another Project

Once deployed, other projects can reference the files via:
- Direct URLs: `https://<username>.github.io/complexity-perspective/web/index.html`
- Or clone/include the `gh-pages` branch

## Option 1b: Publish to Separate Branch (For Submodule Use)

If you want to use this repository as a git submodule in another project:

1. **Enable the alternative workflow** by renaming `.github/workflows/publish-dist.yml.disabled` to `.github/workflows/publish-dist.yml` (or it's already enabled)

2. **The workflow** will create/update a `published` branch with only the `dist` contents

3. **In your other project**, add as submodule:
   ```bash
   git submodule add -b published https://github.com/<username>/complexity-perspective.git simulations
   ```

4. **Reference files** in your Jekyll project:
   ```html
   <script src="simulations/build/main.dart.js"></script>
   ```

## Option 2: Publish to Separate Branch (Alternative)

See Option 1b above for using a separate `published` branch that can be used as a git submodule.

## Option 3: Jekyll/GitHub Pages Integration

If you want to use Jekyll and commit compiled code:

### Setup

1. **Install Jekyll** (if not already installed):
   ```bash
   gem install bundler jekyll
   ```

2. **Build and copy to _site**:
   ```bash
   just dist
   mkdir -p _site
   cp -r dist/* _site/
   ```

3. **Commit _site folder**:
   ```bash
   git add _site/
   git commit -m "Update compiled files"
   git push
   ```

4. **Configure GitHub Pages** to use the `_site` folder or `gh-pages` branch

### Automated Jekyll Build

Add this to your `justfile`:
```bash
jekyll-build:
    @just dist
    @mkdir -p _site
    @cp -r dist/* _site/
    @echo "Jekyll site ready in _site/"
```

## Option 4: Manual Deployment

For manual deployment to any static hosting:

1. **Build the distribution**:
   ```bash
   just dist
   ```

2. **The `dist/` folder contains**:
   - `web/` - HTML files
   - `build/` - Compiled JavaScript files

3. **Upload `dist/` contents** to your hosting provider

## File Structure

After building, the `dist` folder structure is:
```
dist/
├── web/
│   ├── index.html
│   ├── einfaches_system.html
│   ├── kompliziertes_system.html
│   └── segregation.html
└── build/
    ├── main.dart.js
    ├── einfaches_system_web.dart.js
    ├── kompliziertes_system_web.dart.js
    └── segregation_web.dart.js
```

The HTML files reference JavaScript files using `../build/` paths.

## Notes

- The `dist/` folder is gitignored by default (see `.gitignore`)
- GitHub Actions approach doesn't require committing compiled code
- Jekyll approach requires committing `_site/` or using `gh-pages` branch
- For production, always use the GitHub Actions workflow for automatic deployment

