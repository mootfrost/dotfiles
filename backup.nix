{
  config,
  pkgs,
  lib,
  ...
}:
{
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

  systemd.services.borgmatic = {
    path = [ pkgs.networkmanager ];
    serviceConfig.ExecStart = lib.mkForce (
      pkgs.writeShellScript "borgmatic-if-home" ''
        SSID=$(nmcli -g active,ssid dev wifi 2>/dev/null \
          | grep '^yes:' | cut -d: -f2 | head -1)

        if [ "$SSID" != "Fyokla" ]; then
          exit 0
        fi
        exec ${pkgs.borgmatic}/bin/borgmatic
      ''
    );
  };

  systemd.timers.borgmatic.timerConfig = {
    OnCalendar = "*-*-* 22:00";
    Persistent = true;
  };

  services.borgmatic = {
    enable = true;
    configurations = {
      main = {
        source_directories = [
          "/home/owl/programming"
          "/home/owl/obsidian"
          "/home/owl/Desktop"
          "/home/owl/Pictures"
          "/home/owl/Zotero"
          "/home/owl/stuff"
        ];
        exclude_caches = true;
        exclude_patterns = [
          "*/.direnv"
          "*/.venv"
          "*/venv"
        ];
        repositories = [
          {
            label = "remote";
            path = "ssh://borg@homelab.mootfrost.dev:34444/data/backup/laptop-repo";
          }
        ];
        encryption_passcommand = "cat ${config.sops.secrets.borg_repo_password.path}";
        keep_daily = 3;
        keep_weekly = 3;
        keep_monthly = 2;
        checks = [
          {
            name = "repository";
            frequency = "2 weeks";
          }
          {
            name = "archives";
            frequency = "1 month";
          }
        ];
      };
    };
  };
}
