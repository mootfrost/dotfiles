{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./login.nix
    ./audio.nix
    ./drivers.nix
    ./security.nix
    ./backup.nix
    ./printer.nix
    ./network.nix
    ./power.nix
  ];
  services.dbus.implementation = "dbus";

  time.timeZone = "Europe/Moscow";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];
  boot.blacklistedKernelModules = [ "usci_acpi" ];

  environment.etc."machine-id".source = "/nux/persist/etc/machine-id";

  nixpkgs.config.allowUnfree = true;
  programs.zsh.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # programs.adb.enable = true;
  users.users.owl = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "adbusers"
      "vboxusers"
    ];
    shell = pkgs.zsh;
  };
  users.groups.plugdev = { };

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    mesa
    libGL
    libGLU
    v2rayn
    gnupg
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    fira
    fira-math
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    corefonts
  ];

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.host.enableKvm = true;
  virtualisation.virtualbox.host.addNetworkInterface = false;
  users.extraGroups.vboxusers.members = [ "owl" ];

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  services.cron = {
    enable = true;
  };

  system.stateVersion = "25.05";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  services.openssh.enable = true;
}
