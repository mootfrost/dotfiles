{
  description = "My personal Nix templates";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }: {
    templates = {
      uv-python = {
        path = ./uv;
        description = "python+uv";
      };
    };
  };
}
