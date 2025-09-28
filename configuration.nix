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
  systemd.services.nekoray = {
  serviceConfig = {
    AmbientCapabilities = [ "CAP_NET_ADMIN" ];
    CapabilityBoundingSet = [ "CAP_NET_ADMIN" ];
  };
};
  

  programs.adb.enable = true;
  users.users.owl = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "adbusers" "vboxusers"];
    shell = pkgs.zsh;
  };

 
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    sing-box
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

  networking.networkmanager.enable = true;
  networking.firewall = rec {
  allowedTCPPortRanges = [ { from = 1714; to = 1764; } { from = 445; to = 445; } ];
  allowedUDPPortRanges = [ { from = 1714; to = 1764; } { from = 445; to = 445; } ];
};
  systemd.services.NetworkManager-wait-online.enable = false;
  networking.firewall.trustedInterfaces = [ "tun0" ];
  services.sing-box = {
    enable = false;
    package = pkgs.sing-box;

    settings = {
      log.level = "info";
      log.output = "stdout";

      inbounds = [
        {
          type = "tun";
          tag = "tun-in";
          interface_name = "tun0";
          address = [ "172.19.0.1/30" "fd00::1/126" ];
          mtu = 9000;
          auto_route = true;
          strict_route = true;
        }
      ];

      outbounds = [
        {
          type = "vless";
          tag = "vless-out";
          server = "178.236.244.84";
          server_port = 445;
          uuid = "d3b44e2c-2241-4491-b8cc-7defcf76018b";
          flow = "xtls-rprx-vision";
          tls = {
            enabled = true;
            server_name = "oopperabaletti.fi";
            reality = {
              enabled = true;
              public_key = "-qxGAVbfJ04dkOPnHSyObZej7_8rBu1-oa9TaHmjQVA";
              short_id = "be";
            };
            utls = {
              enabled = true;
              fingerprint = "chrome";
            };
          };
        }
      ];
    };

    # grant CAP_NET_ADMIN for TUN support
  #   extraServiceConfig = {
  #     AmbientCapabilities = [ "CAP_NET_ADMIN" ];
  #   };
  };

  # Ensure TUN device is available
  boot.kernelModules = [ "tun" ];
  systemd.services.NetworkManager.wantedBy = ["multi-user.target"];
  users.groups.networkmanager.members = ["owl"];
  services.resolved.enable = true;
  boot.kernel.sysctl."net.ipv4.ip_default_ttl" = 65;
  
  system.stateVersion = "25.05";
  nix.settings.experimental-features = ["nix-command" "flakes"];
}

