{ lib
, rustPlatform
, pkg-config
, openssl
, webkitgtk_4_1
, gtk3
, libsoup_3
, glib
, gdk-pixbuf
, pango
, cairo
, atk
, xdotool
}:

rustPlatform.buildRustPackage rec {
  pname = "rustysound";
  version = "1.0.0";

  src = lib.cleanSource ../..;

  cargoLock = {
    lockFile = ../../Cargo.lock;
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
    webkitgtk_4_1
    gtk3
    libsoup_3
    glib
    gdk-pixbuf
    pango
    cairo
    atk
    xdotool
  ];

  cargoBuildFlags = [
    "--no-default-features"
    "--features"
    "desktop"
  ];

  doCheck = false;

  meta = with lib; {
    description = "Cross-platform music streaming client for Navidrome/Subsonic servers";
    homepage = "https://github.com/AD-Archer/RustySound";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "rustysound";
  };
}
