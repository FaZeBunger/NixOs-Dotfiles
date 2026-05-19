{ pkgs, config, ... }:
let
  pname = "capacities";
  version = "1.64.6";
  src = pkgs.fetchurl {
    url = "https://2vks4.upcloudobjects.com/capacities-desktop-app/Capacities-1.64.6.AppImage";
    sha256 = "1rzfsxlw18i7rvrj08dghyc260rjaw1a1sc38q2mwpx1hfzb69a4";
  };

  # This creates the FHS environment
  capacities-fhs = pkgs.appimageTools.wrapType2 {
    inherit pname version src;
    extraPkgs = pkgs: with pkgs; [
      libsecret
      icu
      at-spi2-atk
      at-spi2-core
      atk
      cairo
      cups
      dbus
      expat
      fontconfig
      freetype
      gdk-pixbuf
      glib
      gtk3
      libGL
      libappindicator-gtk3
      libdrm
      libnotify
      libpulseaudio
      libuuid
      libva
      mesa
      nspr
      nss
      pango
      pipewire
      systemd
      xorg.libX11
      xorg.libXScrnSaver
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXi
      xorg.libXrandr
      xorg.libXrender
      xorg.libXtst
      xorg.libxcb
      xorg.libxshmfence
    ];
  };
in
{
  home.packages = [
    (pkgs.symlinkJoin {
      name = "capacities";
      paths = [ capacities-fhs ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        # Remove the original symlink so we can replace it with a wrapper
        rm $out/bin/${pname}
        
        # Create a wrapper that points to the actual FHS binary in the store
        makeWrapper ${capacities-fhs}/bin/${pname} $out/bin/${pname} \
          --add-flags "--no-sandbox"

        # Correct the desktop file
        mkdir -p $out/share/applications
        cp ${pkgs.appimageTools.extractType2 { inherit pname version src; }}/capacities.desktop $out/share/applications/
        substituteInPlace $out/share/applications/capacities.desktop \
          --replace 'Exec=AppRun' 'Exec=${pname}'
      '';
    })
  ];
}
