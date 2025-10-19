{
  config,
  pkgs,
  lib,
  ...
}: {
  services.kdeconnect = {
    enable = true;
    package = pkgs.kdePackages.kdeconnect-kde;
    indicator = true;
  };

  home.packages = with pkgs; [
    scrcpy
    ffmpeg
    hiddify-app
    prismlauncher
    xwayland-satellite
    neofetch
    firefox
    (google-chrome.override {
        commandLineArgs = ["--enable-wayland-ime" "--wayland-text-input-version=3"];
    })
    yubikey-manager
    _64gram
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

    nautilus
    kdePackages.ark
    rar
    
    (import ./foxshot pkgs)
    (import ./dotnet-mgcb-editor pkgs)
  ];
}