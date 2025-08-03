{ config, lib, pkgs, ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
      ./login.nix
      ./audio.nix
      ./drivers.nix
      ./security.nix
      #./zapret
    ];

  time.timeZone = "Europe/Moscow";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  environment.etc."machine-id".source = "/nux/persist/etc/machine-id";
  
  nixpkgs.config.allowUnfree = true;  
  programs.zsh.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.nekoray.tunMode.enable = true;

  users.users.owl = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
  };
 
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    fira
    fira-math
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.services.NetworkManager.wantedBy = ["multi-user.target"];
  users.groups.networkmanager.members = ["owl"];
  networking.nameservers = ["1.1.1.1"];
  services.resolved.enable = true;
  boot.kernel.sysctl."net.ipv4.ip_default_ttl" = 65;
  
  system.stateVersion = "25.05";
  nix.settings.experimental-features = ["nix-command" "flakes"];
}

