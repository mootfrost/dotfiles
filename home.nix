{ config, pkgs, ... }:

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
  
  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
