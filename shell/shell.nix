{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    initContent = ''
      eval "$(starship init zsh)"
      export PATH="$PATH:/home/owl/.dotnet/tools"
      export DOTNET_ROOT="/nix/store/bimi3z3jrawa24mia2h3m3g8hc0ips4v-dotnet-sdk-8.0.116/share/dotnet"
      eval "$(direnv hook zsh)"

      nfi() {
        nix flake init -t "github:mootfrost/devshells#$1"
      }

      function peco-select-history() {
        BUFFER=$(history -n 1 | tac | peco --query "$LBUFFER")
        CURSOR=$#BUFFER
        zle clear-screen
      } 
      zle -N peco-select-history
      bindkey '^r' peco-select-history
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=180'
    '';
    shellAliases = {
      hms = "home-manager switch --flake ~/.dotfiles";
      nss = "sudo nixos-rebuild switch --flake ~/.dotfiles\#owl-pc";
      ".." = "cd ..";
      l = "eza -la --icons";
      lg = "lazygit";
    };
  };

  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ./starship.toml;
  };
}
