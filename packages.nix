{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    firefox
    (google-chrome.override {
        commandLineArgs = ["--enable-wayland-ime" "--wayland-text-input-version=3"];
    })
    vscode
    _64gram
    kdePackages.dolphin
    spotify
    duf
    htop
    pavucontrol
    pamixer
    brightnessctl
    libreoffice-qt
    obsidian
    obs-studio
  ];
}