{ config, pkgs, jbPkgs, ... }:

{
  home.username = "owl";
  home.homeDirectory = "/home/owl";

 
  home.stateVersion = "25.05";
  imports = [
    ./apps
    ./shell/shell.nix
    ./style.nix
    ./packages.nix
    ./dev.nix
  ];


  programs.home-manager.enable = true;
}
