{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    jb-nixpkgs.url = "github:NixOS/nixpkgs/f02fa2f654c7bcc45f0e815c29d093da7f1245b4";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, jb-nixpkgs, home-manager, ... }:
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { system = system; config.allowUnfree = true; };
      jbPkgs = import jb-nixpkgs { inherit system; config.allowUnfree = true; };
     in {
     imports = [ ./packages ];
     nixosConfigurations = {
       owl-pc = lib.nixosSystem {
         inherit system;
         modules = [ 
          ./configuration.nix 
          ];
       };
     };
     homeConfigurations = {
       owl = home-manager.lib.homeManagerConfiguration {
         inherit pkgs;
         modules = [ 
           ./home.nix
           {
             _module.args.jbPkgs = jbPkgs;
           }
         ];
       };
     };
   };
}
