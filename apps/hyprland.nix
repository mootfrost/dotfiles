{
  programs.kitty.enable = true;
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    xwayland = {
      force_zero_scaling = true;
    };
    general = {
      gaps_in = 3;
      gaps_out = 7;
      resize_on_border = true;
      allow_tearing = true;
    };
    monitor = [
      "eDP-1,1920x1200@60,0x0,1.5"
      "DP-2,1920x1080@60,-1920x0,1"
    ];
    workspace = 
      [
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];
    windowrule = 
      [
        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
      ];
    input = {
      kb_layout = "us, ru";
      kb_options = "grp:caps_toggle";    
    };
    "$mod" = "SUPER";
    bindm = 
      [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    bindel = 
      [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];
    bindl =
      [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
    bind = 
      [
        "$mod, Q, exec, kitty"
        "$mod, E, exec, dolphin"
        "$mod, W, killactive,"
        "$mod, R, exec, tofi-drun --drun-launch=true"
        "$mod, mouse_up, workspace, e-1"
        "$mod, mouse_down, workspace, e+1"
        "$mod, V, togglefloating,"
        "$mod, J, togglesplit,"
        "$mod, P, pseudo,"
        "$mod, S, exec, foxshot"
        "$mod, F, fullscreen,"
      ]
      ++ (
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              "$mod CONTROL, code:1${toString i}, exec, hyprctl dispatch moveworkspacetomonitor ${toString i} current && hyprctl dispatch workspace ${toString i}"
            ]
          )
        9)
      );
  };
}
