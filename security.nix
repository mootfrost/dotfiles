{
  pkgs,
  inputs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    tpm2-tools
  ];

  
  boot.initrd.systemd.enable = true;
  boot.initrd.luks.devices.enc.crypttabExtraOpts = [
    "tpm2-device=auto"
  ];
}
