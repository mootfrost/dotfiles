{pkgs, ...}: {
  packages.dotnet-mgcb-editor = import ./package.nix pkgs;
}
