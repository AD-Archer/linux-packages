# linux-packages

Linux packaging source-of-truth for **ad-archer**.

This repo stores packaging metadata for:
- Flatpak (`flatpak/rustysound`)
- AUR (`aur/rustysound`)
- Nix expression (`nix/pkgs/rustysound`)

This is the staging/distribution repo while the app is not yet in official Flathub.

## Repository layout

- `flatpak/rustysound/app.adarcher.rustysound.yml`:
  Flatpak manifest used by CI and local builds
- `flatpak/rustysound/cargo-sources.json`:
  vendored Cargo source metadata for offline/reproducible Flatpak builds
- `aur/rustysound/PKGBUILD`:
  Arch package recipe
- `nix/pkgs/rustysound/default.nix`:
  Nix package expression

## Automation

Packaging updates are synced from `AD-Archer/RustySound` release automation.

When a new release is published in RustySound:
1. RustySound CI updates package manifests and checksums
2. RustySound CI syncs files into this repo
3. This repo's workflow (`.github/workflows/flatpak-publish.yml`) builds Flatpak and publishes a Flatpak repo to GitHub Pages

## Flatpak install (temporary repo)

Once Pages deployment succeeds, users can install with:

```bash
flatpak remote-add --if-not-exists --user adarcher-rustysound https://ad-archer.github.io/linux-packages/repo
flatpak install --user adarcher-rustysound app.adarcher.rustysound
flatpak run app.adarcher.rustysound
```

Update existing installs:

```bash
flatpak update --user app.adarcher.rustysound
```

Remove remote/app:

```bash
flatpak uninstall --user app.adarcher.rustysound
flatpak remote-delete --user adarcher-rustysound
```

## Local build/test

From this repo:

```bash
flatpak-builder --force-clean build-dir flatpak/rustysound/app.adarcher.rustysound.yml
flatpak build-export repo build-dir
flatpak build-bundle repo rustysound.flatpak app.adarcher.rustysound
flatpak install -y --user ./rustysound.flatpak
flatpak run app.adarcher.rustysound
```

## Notes

- Build artifacts are intentionally ignored (`.flatpak-builder/`, `build-dir/`, `repo/`, `*.flatpak`).
- Flatpak runtime is currently configured for GNOME 49.
- App ID is `app.adarcher.rustysound`.
