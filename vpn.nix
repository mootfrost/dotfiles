{ config, lib, pkgs, ... }:
{
  services.sing-box = {
    enable = true;
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
          mtu = 1400;
          auto_route = true;
          strict_route = true;
        }
      ];

      outbounds = [
        {
          type = "vless";
          tag = "vless-out";
          server = "89.169.12.253";
          server_port = 443;
          uuid = "812c747a-c5b1-4fbf-bae4-80c338de2969";
          flow = "xtls-rprx-vision";
          tls = {
            enabled = true;
            server_name = "google.com";
            reality = {
              enabled = true;
              public_key = "wkchrC_toJ-4GEFhhP1fvmET3EivBYYb78Aov5N5cG0";
              short_id = "f9fed1";
            };
            utls = {
              enabled = true;
              fingerprint = "chrome";
            };
          };
        }
      ];
      dns = {
        servers = [ { address = "1.1.1.1"; } { address = "8.8.8.8"; } ];
      };
    };
  };
}