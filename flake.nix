{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    jb-nixpkgs.url = "github:NixOS/nixpkgs/f02fa2f654c7bcc45f0e815c29d093da7f1245b4";

    sops.url = "github:Mic92/sops-nix";
    sops.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    codechecker = {
      url = "git+https://git.mootfrost.dev/Mootfrost/CodeChecker.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    yukigram.url = "github:yukigram/yukigram/release";
  };

outputs = inputs@{ self, nixpkgs, ... }:
let
  ctx = {
    sources = inputs;
    src = ./.;
    packages = import ./packages;
  };
  mkSystems = import ./utils/mkSystems.nix ctx;

  systems = mkSystems [
    "owl-pc"
  ];

in
{
  nixosConfigurations = systems.hosts;
  homeConfigurations = systems.homes;
};
}
