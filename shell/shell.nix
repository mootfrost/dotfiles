{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    initExtra = ''
      eval "$(starship init zsh)"
      export PATH="$PATH:/home/owl/.dotnet/tools"
    '';
    shellAliases = {
      hms = "home-manager switch --flake ~/.dotfiles";
      nss = "nixos-rebuild switch --flake ~/.dotfiles";
    };
  };

  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ./starship.toml;
  };
}
