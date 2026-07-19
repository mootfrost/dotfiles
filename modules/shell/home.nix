{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    initContent = ''
      eval "$(starship init zsh)"
      export PATH="$PATH:/home/owl/.dotnet/tools"
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
