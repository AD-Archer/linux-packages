# AD-Archer Packages

This repository serves as the unified staging and distribution source-of-truth for apps built by **AD-Archer** (currently featuring **RustySound**).

## Installation

As of right now, my apps are primarily available via **AltStore** (iOS) and **Flatpak** (Linux).

### iOS (AltStore)

Add my source repository to AltStore to easily install and update my iOS apps! Click the button below from your iOS device:

<a href="https://stikstore.app/altdirect/?url=https://ad-archer.github.io/packages/source.json" target="_blank">
  <img src="https://github.com/CelloSerenity/altdirect/blob/main/assets/png/AltSource_Blue.png?raw=true" alt="Add AltSource" width="200">
</a><br>

Alternatively, you can manually add this source URL to your AltStore:

```text
https://ad-archer.github.io/packages/source.json
```

### Linux (Flatpak)

You can install my Flatpak builds from this repository before they hit official distribution channels like Flathub.

1. **Add the AD-Archer remote (only needed once):**

   ```bash
   flatpak remote-add --if-not-exists --user adarcher-apps https://ad-archer.github.io/packages/repo
   ```

2. **Install an app (Example: RustySound):**

   ```bash
   flatpak install --user adarcher-apps app.adarcher.rustysound//stable
   ```

3. **Run the app:**
   ```bash
   flatpak run app.adarcher.rustysound
   ```

**To update:**

```bash
flatpak update --user app.adarcher.rustysound
```

**To uninstall:**

```bash
flatpak uninstall --user app.adarcher.rustysound
# To also clean up the remote if you have no other AD-Archer apps:
flatpak remote-delete --user adarcher-apps
```

_(Note: Replace `app.adarcher.rustysound` with the ID of the app you want to manage)_

---

## Repository Layout

This repo stores packaging metadata organized by platform and application:

- **AltStore:** `altstore/source.json` (Generated universally from our iOS release assets)
- **Flatpak:** `flatpak/<app-name>/<app-id>.yml` (Manifest used by CI and local builds)
  - `cargo-sources.json`: Vendored Cargo source metadata for offline/reproducible builds.
- **AUR:** `aur/<app-name>/PKGBUILD` (Arch package recipes)
- **Nix:** `nix/pkgs/<app-name>/default.nix` (Nix package expressions)

## Automation & CI

Packaging updates are automatically synced from their respective upstream repositories (e.g., `AD-Archer/RustySound`):

1. App-specific CI pipelines periodically update package manifests, checksums, and sync files to this repository.
2. This repo regenerates the unified `altstore/source.json` using the collected release assets.
3. Our GitHub workflow (`.github/workflows/flatpak-publish.yml`) continuously builds the Flatpak bundles.
4. Everything (Flatpak repo + AltStore source) is published to GitHub Pages.

## Local Build & Test (Flatpak)

To build and test a Flatpak locally from this repo (Example using RustySound):

```bash
flatpak-builder --force-clean build-dir flatpak/rustysound/app.adarcher.rustysound.yml
flatpak build-export repo build-dir
flatpak build-bundle repo rustysound.flatpak app.adarcher.rustysound
flatpak install -y --user ./rustysound.flatpak
flatpak run app.adarcher.rustysound
```

**Notes:**

- Build artifacts (`.flatpak-builder/`, `build-dir/`, `repo/`, `*.flatpak`) are ignored in version control.
- The Flatpak runtime may vary depending on the app's framework (currently GNOME 49 in our examples).
