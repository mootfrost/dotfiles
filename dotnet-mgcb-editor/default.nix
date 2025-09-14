pkgs:
pkgs.buildDotnetGlobalTool {
  pname = "dotnet-mgcb-editor-linux";
  version = "3.8.4";
  nativeBuildInputs = [ 
    pkgs.gtk3
    pkgs.glib
    pkgs.gsettings-desktop-schemas
    pkgs.adwaita-icon-theme
    pkgs.hicolor-icon-theme

  ];  # Ensure gtk3 is available at build time

  nugetHash = "sha256-4QSxPHZODM1r6fefmLgTpzSnSvkhzvcd2t+R8ZkjPCg="; # Replace with the correct hash

  dotnetFixupHook = ''
    echo '<============ DEBUG START ==============>'
    # Create a new wrapper script that sets the GTK library paths.
    mkdir -p $out/bin
    cat > $out/bin/mgcb-editor <<'EOF'
    #! /usr/bin/env bash
    # Ensure GTK libraries can be found.
    export LD_LIBRARY_PATH=${pkgs.gtk3}/lib:\$LD_LIBRARY_PATH
    # Set the directory for GSettings schemas from both glib and gsettings-desktop-schemas.
    export GSETTINGS_SCHEMA_DIR=${pkgs.glib}/share/glib-2.0/schemas:${pkgs.gsettings-desktop-schemas}/share/glib-2.0/schemas
    # Set XDG_DATA_DIRS so that icon themes and desktop files are available.
    export XDG_DATA_DIRS=${pkgs.hicolor-icon-theme}/share:${pkgs.adwaita-icon-theme}/share:${pkgs.gtk3}/share:\$XDG_DATA_DIRS
    exec ${placeholder "out"}/lib/dotnet-mgcb-editor-linux/mgcb-editor-linux "$@"
EOF
    chmod +x $out/bin/mgcb-editor

    echo gdk-pixbuf-query-loaders
    echo '<============ DEBUG END ==============>'
  '';

  meta = {
    description = "MonoGame Content Builder Editor as a .NET global tool";
    homepage = "https://www.nuget.org/packages/dotnet-mgcb-editor/";
    license = pkgs.lib.licenses.mit;
    platforms = pkgs.lib.platforms.all;
  };
}