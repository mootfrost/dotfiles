{
  config,
  pkgs,
  lib,
  ctx,
  ...
}:
{
  services.kdeconnect = {
    enable = true;
    package = pkgs.kdePackages.kdeconnect-kde;
    indicator = true;
  };

  home.packages = with pkgs; [
    thunderbird
    zip
    ghostscript
    inkscape
    scrcpy
    ffmpeg
    prismlauncher
    xwayland-satellite
    fastfetch
    firefox
    (google-chrome.override {
      commandLineArgs = [
        "--enable-wayland-ime"
        "--wayland-text-input-version=3"
      ];
    })
    yubikey-manager
    # _64gram
    spotify
    vesktop
    duf
    htop
    pavucontrol
    pamixer
    brightnessctl
    libreoffice-qt
    obsidian
    zotero
    obs-studio

    nautilus
    kdePackages.ark
    rar
    udiskie

    mpv
    vlc
    qbittorrent
    element-desktop

    loupe
    cliphist
    wl-clipboard

    ramus
    # cloudflare-warp 

    (import ./foxshot pkgs)
    # (import ./dotnet-mgcb-editor pkgs)
    (pkgs.writeShellScriptBin "yukigram" ''
      exec io.github.yukigram "$@"
    '')
  ]
  ++ (with ctx.packages; [
      ctx.sources.yukigram.packages.${pkgs.system}.nixpak
    ]);
}
