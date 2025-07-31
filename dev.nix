{
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.file =
    builtins.listToAttrs (
      map
      (vmoptionsPath: {
        name = ".config/JetBrains/${vmoptionsPath}";
        value = {
          text = ''
            -Xmx4096m
            -Dawt.toolkit.name=WLToolkit
            -Didea.kotlin.plugin.use.k2=true
          '';
        };
      })
      [
        "IntelliJIdea2025.1/idea64.vmoptions"
        "CLion2025.1/clion64.vmoptions"
        "PyCharm2025.1/pycharm64.vmoptions"
      ]
    )
    // {
      # ".local/share/jdks/temurin8".source = pkgs.temurin-bin-8;
      # ".local/share/jdks/temurin11".source = pkgs.temurin-bin-11;
      # ".local/share/jdks/temurin17".source = pkgs.temurin-bin-17;
      ".local/share/jdks/temurin21".source = pkgs.temurin-bin-21;
    };

   home.packages = with pkgs; [
    orca-slicer
    vscode
    httpie
    tokei
    temurin-bin-21
    jetbrains.idea-ultimate
    jetbrains.rider
    rustup
    gnumake
    clang
    (python3.withPackages (
      ps:
        with ps;
          [
            black
            dbus-python
            ipython
            httpx
          ]
          ++ black.optional-dependencies.d
    ))
   ];
}