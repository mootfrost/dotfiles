{
  # pkgs is needed because the args are injected dynamically based on the signature
  pkgs,
  lib,
  config,
  ...
} @ args: {
  _module.args.util = {
    readYaml = import ./readYaml.nix args;
  };
}
