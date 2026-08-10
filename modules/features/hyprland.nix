{self, ...}: {
  flake.nixosModules.hyprland = {config, ...}: {
    imports = [
      (self.lib.hm config.username "hyprland")
    ];
    programs.hyprland = {
      enable = true;
      # necessary for compatibility with apps that don't support the newer wayland protocol
      xwayland.enable = true;
    };
  };
  flake.homeModules.hyprland = {
    pkgs,
    config,
    lib,
    ...
  }: {
    options.monitor = lib.mkOption {};
    # keyboard based navigation of windows that implements wayland
    config = {
      wayland.windowManager.hyprland = {
        enable = true;
        configType = "lua";
        settings = {
          # modifier
          mod = {
            _var = "SUPER";
          };
          terminal = {
            _var = "ghostty";
          };
          # for my hp laptop
          inherit (config) monitor;
          config = {
            # remove popup on startup
            ecosystem.no_update_news = true;
            group.groupbar.height = 0;
          };
          # open the programs how I like them on startup
          on = {
            _args = [
              "hyprland.start"
              (lib.generators.mkLuaInline ''
                function()
                  hl.exec_cmd(terminal, { workspace = "1" })
                  hl.exec_cmd("chromium", { workspace = "3", silent = true })
                end
              '')
            ];
          };
          # toggles waybar visibility
          bind =
            [
              {
                _args = [
                  (lib.generators.mkLuaInline ''mod .. " + S"'')
                  (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("hyprlauncher")'')
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline ''mod .. " + C"'')
                  (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("chromium")'')
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline ''mod .. " + Q"'')
                  (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${config.configDir}/helpers/closewindow.sh")'')
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline ''mod .. " + T"'')
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(terminal)")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline ''mod .. " + W"'')
                  (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("pkill waybar --signal SIGUSR1")'')
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline ''mod .. " + SHIFT + S"'')
                  (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("hyprshutdown --post-cmd 'shutdown -P 0'")'')
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline ''mod .. " + SHIFT + R"'')
                  (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("hyprshutdown -t 'Restarting...' --post-cmd 'reboot'")'')
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline ''mod .. " + SHIFT + N"'')
                  (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("systemctl hibernate")'')
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline ''mod .. " + H"'')
                  (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "left" })'')
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline ''mod .. " + J"'')
                  (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "down" })'')
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline ''mod .. " + K"'')
                  (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "up" })'')
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline ''mod .. " + L"'')
                  (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "right" })'')
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline ''mod .. " + N"'')
                  (lib.generators.mkLuaInline "hl.dsp.group.next()")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline ''mod .. " + P"'')
                  (lib.generators.mkLuaInline "hl.dsp.group.prev()")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline ''mod .. " + G"'')
                  (lib.generators.mkLuaInline "hl.dsp.group.toggle()")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline ''mod .. " + SHIFT + H"'')
                  (lib.generators.mkLuaInline ''hl.dsp.window.resize({ x = -10, y = 0, relative = true })'')
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline ''mod .. " + SHIFT + J"'')
                  (lib.generators.mkLuaInline ''hl.dsp.window.resize({ x = 0, y = 10, relative = true })'')
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline ''mod .. " + SHIFT + K"'')
                  (lib.generators.mkLuaInline ''hl.dsp.window.resize({ x = 0, y = -10, relative = true })'')
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline ''mod .. " + SHIFT + L"'')
                  (lib.generators.mkLuaInline ''hl.dsp.window.resize({ x = 10, y = 0, relative = true })'')
                ];
              }
              {
                _args = [
                  "XF86AudioRaiseVolume"
                  (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")'')
                ];
              }
              {
                _args = [
                  "XF86AudioLowerVolume"
                  (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")'')
                ];
              }
              {
                _args = [
                  "CTRL + 2"
                  (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-")'')
                ];
              }
              {
                _args = [
                  "CTRL + 3"
                  (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+")'')
                ];
              }
              {
                _args = [
                  "XF86AudioMute"
                  (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")'')
                ];
              }
            ]
            # add the bindings inside the list below for each number 1-9
            ++ (
              builtins.concatLists (builtins.genList (i: let
                  workspace = i + 1;
                in [
                  {
                    _args = [
                      (lib.generators.mkLuaInline ''mod .. " + ${toString workspace}"'')
                      (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = ${toString workspace} })")
                    ];
                  }
                  {
                    _args = [
                      (lib.generators.mkLuaInline ''mod .. " + SHIFT + ${toString workspace}"'')
                      (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = ${toString workspace} })")
                    ];
                  }
                ])
                9)
            );
        };
      };
      # make sure we have the hyprshutdown package used for the keybindings above
      home.packages = with pkgs; [
        hyprshutdown
        hyprlauncher
        wl-clipboard
      ];
      services = {
        hyprpaper = {
          enable = true;
          settings = {
            wallpaper = [
              {
                monitor = "eDP-1";
                # setting this to a dir will cycle through wallpapers using timeout below
                path = "${config.configDir}/wallpapers/10002414.jpg";
                timeout = 60;
              }
            ];
          };
        };
        # blue light filter like redshift
        hyprsunset = {
          enable = true;
          settings = {
            profile = [
              {
                temperature = 3000;
              }
            ];
          };
        };
      };
    };
  };
}
