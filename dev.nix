{
  inputs,
  pkgs,
  pkgs-unstable,
  jbPkgs,
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
            -javaagent:/home/owl/jetbra/ja-netfilter.jar=jetbrains
            --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED
            --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED
          '';
        };
      })
      [
        "IntelliJIdea2025.1/idea64.vmoptions"
        "IntelliJIdea2024.1/idea64.vmoptions"
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
#    jbPkgs2024 = jbPkgs.jetbrains.idea-ultimate.overrideAttrs (old: {
#      installPhase = ''
#        ${old.installPhase}
#        mv $out/bin/idea-ultimate $out/bin/idea-ultimate-2024
#      '';
#    });

   home.packages = with pkgs; [
    direnv
    heimdall

    # c#
    dotnetCorePackages.dotnet_8.sdk
    jetbrains.rider
    # jetbrains.clion
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

    poetry
   ]; 
#++ [
#     jbPkgs.jetbrains.idea-ultimate 
#   ];
}
