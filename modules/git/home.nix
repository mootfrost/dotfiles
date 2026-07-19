{
  config,
  lib,
  ...
}: {
  programs.git = lib.mkIf (config.home.username == "owl") {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        name = "Andrew Semeykin";
        email = "hello@mootfrost.dev";
      };
      push.autoSetupRemote = true;
    };
  };
  programs.mergiraf = {
    enable = true;
    enableGitIntegration = true;
  };
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
