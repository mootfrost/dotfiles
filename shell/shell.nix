{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    initExtra = ''
      eval "$(starship init zsh)"
      export PATH="$PATH:/home/owl/.dotnet/tools"
      export DOTNET_ROOT="/nix/store/bimi3z3jrawa24mia2h3m3g8hc0ips4v-dotnet-sdk-8.0.116/share/dotnet"
      eval "$(direnv hook zsh)"
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
