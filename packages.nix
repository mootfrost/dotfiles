{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    neofetch
    nekoray
    firefox
    (google-chrome.override {
        commandLineArgs = ["--enable-wayland-ime" "--wayland-text-input-version=3"];
    })
    yubikey-manager
    _64gram
    kdePackages.dolphin
    spotify
    vesktop
    duf
    htop
    pavucontrol
    pamixer
    brightnessctl
    libreoffice-qt
    obsidian
    obs-studio
    kdePackages.ark
    (import ./foxshot pkgs)
  ];
}