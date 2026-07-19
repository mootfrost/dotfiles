{
  config,
  pkgs,
  lib,
  ...
}:
{
  boot.kernelModules = [ "tun" ];
  systemd.services.NetworkManager.wantedBy = [ "multi-user.target" ];
  users.groups.networkmanager.members = [ "owl" ];
  services.resolved.enable = true;
  boot.kernel.sysctl."net.ipv4.ip_default_ttl" = 65;

  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };

  networking.networkmanager.enable = true;
  networking.nftables.enable = true;
  networking.firewall.enable = true;
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

  # systemd.services.nix-daemon.environment = {
  #   http_proxy = "http://127.0.0.1:2080";
  #   https_proxy = "http://127.0.0.1:2080";
  #   all_proxy = "http://127.0.0.1:2080";
  #   no_proxy = "127.0.0.1,localhost,internal.domain";
  # };
}
