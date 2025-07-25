{
  config,
  ...
}:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${config.preferences.wallpaper}"
      ];
      wallpaper = [
        ",${config.preferences.wallpaper}"
      ];
    };
  };
}