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
    # ./vpn.nix~
  ];

  time.timeZone = "Europe/Moscow";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];

  environment.etc."machine-id".source = "/nux/persist/etc/machine-id";

  nixpkgs.config.allowUnfree = true;
  programs.zsh.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  systemd.services.sing-box = {
    serviceConfig = {
      AmbientCapabilities = [ "CAP_NET_ADMIN" ];
      CapabilityBoundingSet = [ "CAP_NET_ADMIN" ];
    };
  };
  programs.throne = {
    enable = true;
    tunMode.enable = true;
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

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    sing-box
    mesa
    libGL
    libGLU
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
  #  systemd.services.nix-daemon.environment = {
  #    http_proxy = "http://127.0.0.1:8080";
  #    https_proxy = "http://127.0.0.1:8080";
  #  };

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
    allowedTCPPorts = [ 8384 ];
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
      {
        from = 445;
        to = 445;
      }
      {
        from = 50499;
        to = 50500;
      }
      {
        from = 1143;
        to = 1144;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
      {
        from = 445;
        to = 445;
      }
      {
        from = 50499;
        to = 50500;
      }
      {
        from = 1143;
        to = 1144;
      }
    ];
  };
  systemd.services.NetworkManager-wait-online.enable = false;
  networking.firewall.trustedInterfaces = [ "tun0" ];

  # grant CAP_NET_ADMIN for TUN support
  #   extraServiceConfig = {
  #     AmbientCapabilities = [ "CAP_NET_ADMIN" ];
  #   };

  # Ensure TUN device is available
  boot.kernelModules = [ "tun" ];
  systemd.services.NetworkManager.wantedBy = [ "multi-user.target" ];
  users.groups.networkmanager.members = [ "owl" ];
  services.resolved.enable = true;
  boot.kernel.sysctl."net.ipv4.ip_default_ttl" = 65;

  system.stateVersion = "25.05";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.printing = {
    enable = true;
    logLevel = "debug";
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "owl";
    dataDir = "/home/owl";
    configDir = "/home/owl/.config/syncthing";
    settings.gui = {
      user = "owl-nixos";
      password = "owl-owl-owl";
    };
  };

  systemd.services.nix-daemon.environment = {
    http_proxy = "http://127.0.0.1:2080";
    https_proxy = "http://127.0.0.1:2080";
    all_proxy = "http://127.0.0.1:2080";
    no_proxy = "127.0.0.1,localhost,internal.domain";
  };

  services.printing.drivers = [
    pkgs.brlaser
    pkgs.brgenml1lpr
    pkgs.brgenml1cupswrapper
    pkgs.gutenprint
  ];

  services.power-profiles-daemon.enable = true;
  powerManagement.powertop.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply",ENV{POWER_SUPPLY_ONLINE}=="0",RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"
    SUBSYSTEM=="power_supply",ENV{POWER_SUPPLY_ONLINE}=="1",RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced"
  '';
}
