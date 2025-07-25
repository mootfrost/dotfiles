{
  pkgs,
  lib,
  config,
  ...
}:
{
  services.blueman-applet.enable = true;
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        "layer" = "top";
        "position" = "top";
        "height" = 30;
        "spacing" = 4;
        "modules-left" = ["hyprland/workspaces"];
        "modules-right" = [
            "tray"
            "pulseaudio"
            "network"
            "hyprland/language"
            "temperature"
            "battery"
            "clock"
        ];
        "wlr/workspaces" = {
          "on-click" = "activate";
          "format" = "{name}";
          "all-outputs" = true;
          "disable-scroll" = false;
          "active-only" = false;
        };
        "pulseaudio" = {
          "format" ="{icon} {volume}%";
          "format-muted" = "  muted";
          "format-icons" = {
            "headphone" = "";
            "default" = ["󰖀" "󰕾" ""];
          };
          "on-click-middle" = "pamixer -t";
          "on-click" = lib.getExe pkgs.pavucontrol;
        };
        "network" = {
            "format" = "{ifname}";
	        "format-wifi" = "{icon}";
	        "format-ethernet" = "󰌘";
	        "format-disconnected" = "󰌙";
	        "tooltip-format" = "{ipaddr}  {bandwidthUpBits}  {bandwidthDownBits}";
	        "format-linked" = "󰈁 {ifname} (No IP)";
	        "tooltip-format-wifi" = "{essid} {icon} {signalStrength}%";
	        "tooltip-format-ethernet" = "{ifname} 󰌘";
	        "tooltip-format-disconnected" = "󰌙 Disconnected";
	        "max-length" = 30;
	        "format-icons" = [
		      "󰤯" "󰤟" "󰤢" "󰤥" "󰤨1"
	        ];
            "on-click-right" = "kitty nmtui";
        };
      };
    };
    style = ''
      * {
          min-height: 0;
          /* font-family: Lexend, "Font Awesome 6 Free Solid"; */
          font-family: ${config.preferences.font.monospace};
          font-size: 14px;
          font-weight: 500;
      }

      window#waybar {
          transition-property: background-color;
          transition-duration: 0.5s;
          /* background-color: #1e1e2e; */
          /* background-color: #181825; */
          background-color: rgba(24, 24, 37, 0.8);
      }

      window#waybar.hidden {
          opacity: 0.5;
      }

      #workspaces {
          background-color: transparent;
      }

      #workspaces button {
          all: initial;
          min-width: 0;
          box-shadow: inset 0 -3px transparent;
          padding: 2px 10px;
          min-height: 0;
          margin: 4px 4px;
          border-radius: 8px;
          background-color: #181825;
          color: #cdd6f4;
      }

      #workspaces button:hover {
          box-shadow: inherit;
          text-shadow: inherit;
          color: #1e1e2e;
          background-color: #cdd6f4;
      }

      #workspaces button.active {
          color: #1e1e2e;
          background-color: #89b4fa;
      }

      #workspaces button.urgent {
          background-color: #f38ba8;
      }

      #clock,
      #pulseaudio,
      #custom-logo,
      #custom-power,
      #custom-music-player,
      #cpu,
      #tray,
      #memory,
      #window,
      #custom-screen-recorder,
      #custom-gpu {
          min-height: 0;
          padding: 2px 10px;
          border-radius: 8px;
          margin: 4px 4px;
          background-color: #181825;
      }

      #custom-sep {
          padding: 0px;
          color: #585b70;
      }

      #custom-screen-recorder.recording {
          color: #10ef2c;
      }

      #custom-screen-recorder.not-recording {
          color: #df2020;
      }

      #custom-music-player.playing {
          color: #cdd6f4;
      }

      #custom-music-player.paused {
          color: #9399b2;
      }

      window#waybar.empty #window {
          background-color: transparent;
      }

      #cpu {
          color: #94e2d5;
          margin-left: 0;
          margin-right: 0;
      }

      #custom-gpu {
          color: #94e2d5;
          margin-left: 0;
          margin-right: 0;
      }

      #memory {
          margin-left: 0;
          color: #cba6f7;
      }

      #clock {
          color: #74c7ec;
      }

      #clock.simpleclock {
          color: #89b4fa;
      }

      #window {
          color: #a6e3a1;
      }

      #pulseaudio {
          color: #b4befe;
      }

      #pulseaudio.muted {
          color: #a6adc8;
      }

      #custom-logo {
          color: #89b4fa;
      }

      #custom-power {
          color: #f38ba8;
          padding-right: 5px;
          font-size: 14px;
      }

      @keyframes blink {
          to {
              background-color: #f38ba8;
              color: #181825;
          }
      }

      tooltip {
          border-radius: 8px;
      }

      #tray menu {
          background: rgb(24, 24, 37);
          color: white;
      }
    '';
  };
}
