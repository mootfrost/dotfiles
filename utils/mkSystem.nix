ctx: hostname:
let
  home-manager = ctx.sources.home-manager;
  nixosSystem = import "${ctx.sources.nixpkgs}/nixos/lib/eval-config.nix";
  hostPath = ../hosts/${hostname};
  hostConfig = import hostPath;

  pkgs = import ctx.sources.nixpkgs {
    system = hostConfig.systemType or "x86_64-linux";
    config = {
      allowUnfree = true;
    };
  };

  args = {
    inherit
      ctx
      hostname
      pkgs
      hostPath
      hostConfig
      ;
    systemConfig = null;
  };

  mkHome =
    username: homeModule:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./modules.nix
        homeModule
      ];
      extraSpecialArgs = args // {
        mode = "home";
      };
    };

in
{
  hosts.${hostname} = nixosSystem {
    system = hostConfig.systemType or "x86_64-linux";
    specialArgs = args // {
      mode = "system";
    };

    modules = [
      ./modules.nix
      "${ctx.sources.sops}/modules/sops"
      hostConfig.system
      home-manager.nixosModules.home-manager

      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = args // {
            mode = "home";
          };
          users = hostConfig.users;
        };
      }
    ];
  };

  homes = builtins.listToAttrs (
    map (username: homeModule: {
      name = "${username}@${hostname}";
      value = mkHome username homeModule;
    }) (builtins.attrNames (builtins.removeAttrs hostConfig.users [ "root" ]))
  );
}
