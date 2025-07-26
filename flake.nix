{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { system = system; config.allowUnfree = true; };
     in {
     imports = [ ./packages ];
     nixosConfigurations = {
       owl-pc = lib.nixosSystem {
         inherit system;
         modules = [ ./configuration.nix ];
       };
     };
     homeConfigurations = {
       owl = home-manager.lib.homeManagerConfiguration {
         inherit pkgs;
         modules = [ ./home.nix ];
       };
     };
   };
}
