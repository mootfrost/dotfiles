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
    direnv
    heimdall

    # c#
    dotnetCorePackages.dotnet_8.sdk
    jetbrains.rider
    mono
    unityhub
    glfw
    libGL
    vulkan-tools
    vulkan-loader
    tiled
    
    # node
    nodejs
    yarn-berry
    

    # FNA 
    faudio
    fna3d
    sdl3
    sdl2-compat

    orca-slicer
    vscode
    httpie
    tokei
    temurin-bin-21
    jetbrains.idea-ultimate
    
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