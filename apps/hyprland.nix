{
  config,
  ...
}:
{
  programs.kitty.enable = true;
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "udiskie"
      "hyprpaper"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
    ];
    xwayland = {
      force_zero_scaling = true;
    };
    general = {
      gaps_in = 3;
      gaps_out = 7;
      resize_on_border = true;
      allow_tearing = true;
    };

    monitorv2 = [
      {
        output = "eDP-1";
        mode = "1920x1200@60";
        position = "0x0";
        scale = 1.25;
      }
      {
        output = "DP-2";
        mode = "1920x1080@60";
        position = "-1920x0";
        scale = 1;
      }
    ];
    workspace = [
      "w[tv1], gapsout:0, gapsin:0"
      "f[1], gapsout:0, gapsin:0"
      "f[1], gapsout:0, gapsin:0"
    ];
    windowrule = [
      "border_size 0, match:float false, match:workspace w[t1]"
      # "no_border on, match:float false, match:workspace w[tv1]"
      "rounding 0, match:float false, match:workspace w[t1]"
      "border_size 0, match:float false, match:workspace w[tv1]"
      # "no_border on, match:float false, match:workspace w[tv1]"
      "rounding 0, match:float false, match:workspace w[tv1]"
      "border_size 0, match:float false, match:workspace f[1]"
      # "no_border on, match:float false, match:workspace w[tv1]"
      "rounding 0, match:float false, match:workspace f[1]"
      "float on, match:class ^(org.gnome.Nautilus)$"
      "float on, match:class ^(org.kde.dolphin)$"
      "float on, match:class ^(org.gtk.FileChooser)$"
      "float on, match:class ^(xdg-desktop-portal-kde)$"
      "float on, match:title ^(Open File.*)$"
      "float on, match:title ^(Save File.*)$"
      "center on, match:class ^(java)$"
      "float on, match:class ^(java)$"
    ];
    input = {
      kb_layout = "us, ru";
      kb_options = "grp:caps_toggle";
    };
    "$mod" = "SUPER";
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
    bindel = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
      ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
    ];
    bindl = [
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
    bind = [
      "$mod, Q, exec, kitty"
      "$mod, E, exec, nautilus"
      "$mod, W, killactive,"
      "$mod, R, exec, tofi-drun --drun-launch=true"
      "$mod, mouse_up, workspace, e-1"
      "$mod, mouse_down, workspace, e+1"
      "$mod, B, togglefloating,"
      "$mod, V, exec, cliphist list | tofi | cliphist decode | wl-copy"
      "$mod, J, togglesplit,"
      "$mod, P, pseudo,"
      "$mod, S, exec, foxshot"
      "$mod, F, fullscreen,"
    ]
    ++ (builtins.concatLists (
      builtins.genList (
        i:
        let
          ws = i + 1;
        in
        [
          "$mod, code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          "$mod CONTROL, code:1${toString i}, exec, hyprctl dispatch moveworkspacetomonitor ${toString ws} current && hyprctl dispatch workspace ${toString ws}"
        ]
      ) 9
    ));
  };
}
