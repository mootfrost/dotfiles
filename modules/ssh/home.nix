{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    settings = {
      Host = {
        homelab = {
          HostName = "homelab.mootfrost.dev";
          Port = 34444;
        };

        vpn1 = {
          HostName = "de-01.mootfrost.dev";
        };

        vpn2 = {
          HostName = "de-02.mootfrost.dev";
        };
      };
    };
  };
}
