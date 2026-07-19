{
  inputs,
  pkgs,
  ctx,
  ...
}:
{
  home.file =
    let
      mkVmOptions = ide: file: {
        name = ".config/JetBrains/${ide}/${file}";
        value.text = ''
          -Xmx4096m
          -Dawt.toolkit.name=WLToolkit
          -Didea.kotlin.plugin.use.k2=true
          -javaagent:/home/owl/jetbra/ja-netfilter.jar=jetbrains
          --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED
          --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED
        '';
      };
    in
    builtins.listToAttrs [
      (mkVmOptions "IntelliJIdea2025.3" "idea64.vmoptions")
      (mkVmOptions "CLion" "clion64.vmoptions")
      (mkVmOptions "PyCharm" "pycharm64.vmoptions")
      (mkVmOptions "Rider2025.3" "rider64.vmoptions")
      (mkVmOptions "CLion2025.3" "clion64.vmoptions")
    ]
    // {
      # ".local/share/jdks/temurin8".source  = pkgs.temurin-bin-8;
      # ".local/share/jdks/temurin11".source = pkgs.temurin-bin-11;
      # ".local/share/jdks/temurin17".source = pkgs.temurin-bin-17;
      ".local/share/jdks/temurin21".source = pkgs.temurin-bin-21;
    };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "homelab" = {
        hostname = "homelab.mootfrost.dev";
        port = 34444;
      };
      "vpn1" = {
        hostname = "de-01.mootfrost.dev";
      };
      "vpn2" = {
        hostname = "de-02.mootfrost.dev";
      };
    };
  };

  #    jbPkgs2024 = jbPkgs.jetbrains.idea-ultimate.overrideAttrs (old: {
  #      installPhase = ''
  #        ${old.installPhase}
  #        mv $out/bin/idea-ultimate $out/bin/idea-ultimate-2024
  #      '';
  #    });

  home.packages =
    with pkgs;
    [
      eza
      android-tools

      postman
      direnv
      heimdall
      tinymist
      typst

      # c#
      dotnetCorePackages.dotnet_8.sdk
      jetbrains.rider
      jetbrains.clion
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
      jetbrains.idea

      rustup
      gnumake
      clang
      qtcreator
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
      ruff
      pyright
      nixfmt

      lazygit
      zeronet-conservancy
      zed-editor
      peco
      ty
      shfmt

      craftos-pc
    ]

    ++ (with ctx.packages; [
      ctx.sources.codechecker.packages.${pkgs.system}.default
    ]);
}
