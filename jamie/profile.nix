{ config, pkgs, lib, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  # secrets = import ../secrets.nix { };
  # smos = with lib; builtins.fetchGit
  #   {
  #     url = "https://github.com/NorfairKing/smos";
  #     ref = "refs/tags/smos-0.3.1";
  #   } + "/nix/home-manager-module.nix";
  # intray = with lib; builtins.fetchGit
  #   {
  #     url = "https://github.com/NorfairKing/intray";
  #     rev = "3c34a00365bf69053490b8b88be1d0c0842164ae";
  #     ref = "master";
  #   } + "/nix/home-manager-module.nix";
  # tickler = with lib; builtins.fetchGit
  #   {
  #     url = "https://github.com/NorfairKing/tickler";
  #     rev = "56fce9ca0410283ba9e2dc3cdf9704e519b4cc82";
  #     ref = "master";
  #   } + "/nix/home-manager-module.nix";
  nord0 = "#2E3440";
  nord1 = "#3b4252";
  nord2 = "#434c5e";
  nord3 = "#4c566a";
  nord4 = "#d8dee9";
  nord5 = "#e5e9f0";
  nord6 = "#eceff4";
  nord7 = "#8fbcbb";
  nord8 = "#88c0d0";
  nord9 = "#81a1c1";
  nord10 = "#5e81ac";
  nord11 = "#bf616a";
  nord12 = "#d08770";
  nord13 = "#ebcb8b";
  nord14 = "#a3be8c";
  nord15 = "#b48ead";
in
{
  imports = [
    ../desktop.nix
  ];

  users.users.jamie = {
    description = "Jamie Bertram";
    uid = 1111;
    isNormalUser = true;
    group = "nogroup";
    extraGroups = [
      "libvirtd"
      "wheel"
      "sound"
      "pulse"
      "audio"
      "lp"
      "networkmanager"
      "podman"
      "docker"
      config.services.kubo.group
    ];
    home = "/home/jamie";
    shell = pkgs.zsh;
    createHome = true;
    useDefaultShell = false;
    # hashedPassword = secrets.users.jamie.hashedPassword;
  };
  nix.settings.trusted-users = [ "root" "jamie" ];
  nix.settings.substituters = [
    "https://cache.iog.io"
  ];
  nix.settings.trusted-public-keys = [
    "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
  ];

  home-manager.users.jamie = {
    imports = [
      # smos
      # intray
      # tickler
      ../vim.nix
    ];

    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };

    home.stateVersion = "21.05";
    home.packages = with pkgs; [
      blender
      go
      vlc
      audacity
      nix-prefetch-git
      blueman
      cachix
      direnv
      entr
      firefox
      fzf
      git-crypt
      git-lfs
      (import ../pomo.nix { })
      ripgrep
      slack
      tmate
      tmux
      # (st.overrideAttrs (oldAttrs: rec {
      #   src = fetchFromGitHub {
      #     owner = "LukeSmithxyz";
      #     repo = "st";
      #     rev = "b53fc79c5b5889400807149997d81df64a8af083";
      #     sha256 = "0dv8aiw1jzawi14rv53avc5zkpg24g0f7lsvdz8g503s7yckgkj5";
      #   };
      #   buildInputs = oldAttrs.buildInputs ++ [ harfbuzz ];
      # }))
      unipicker
      zathura
    ];

    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
    };

    home.file = {
      ".screen-layout.sh".source = ./config-files/.screen-layout.sh;
      ".fehbg".source = ./config-files/.fehbg;
    };
    xdg.configFile = {
      "i3/config".source = ./config-files/i3/config;
      "polybar/config".source = ./config-files/polybar/config;
      "polybar/run-polybar.sh".source = ./config-files/polybar/run-polybar.sh;
      "wallpapers/haskell-space.jpg".source = ./config-files/haskell-space.jpg;
      "rofi/config.rasi".text =
        ''
            configuration {
              font: "Fira Mono 10";
              width: 33;
              location: 2;
              dpi: 128;
              show-icons: true;
              levenshtein-sort: true;
              matching: "fuzzy";
            }
            // Nord theme
            * {
              nord0: ${nord0};
              nord1: ${nord1};
              nord2: ${nord2};
              nord3: ${nord3};
              nord4: ${nord4};
              nord5: ${nord5};
              nord6: ${nord6};
              nord7: ${nord7};
              nord8: ${nord8};
              nord9: ${nord9};
              nord10: ${nord10};
              nord11: ${nord11};
              nord12: ${nord12};
              nord13: ${nord13};
              nord14: ${nord14};
              nord15: ${nord15};

              background-color: @nord1;
              border: 0px;
              margin: 0px;
              padding: 0px;
              spacing: 0px;
              text-color: @nord4;
            }
          #inputbar {
            text-color: @nord3;
            padding: 6px;
            children: [ entry ];
          }
          #entry {
            background-color: @nord3;
            text-color: @text-color;
            padding: 5px;
          }
          #message {
            border: 0px 0px 1px;
            border-color: @nord3;
            padding: 0px 0px 6px 7px;
          }
          #listview {
            lines: 10;
            padding: 4px 0px 0px;
            scrollbar: true;
          }
          #element {
            padding: 4px 8px;
            text-color: @text-color;
          }
          #element.normal.normal {
            text-color: @text-color;
            background-color: @background-color;
          }
          #element.normal.urgent {
            text-color: @nord11;
            background-color: @background-color;
          }
          #element.normal.active {
            text-color: @nord10;
            background-color: @background-color;
          }
          #element.alternate.normal {
            text-color: @text-color;
            background-color: @background-color;
          }
          #element.alternate.urgent {
            text-color: @nord11;
            background-color: @background-color;
          }
          #element.alternate.active {
            text-color: @nord10;
            background-color: @background-color;
          }
          #element.selected.normal {
            background-color: @nord8;
            text-color: @nord1;
          }
          #element.selected.urgent {
            background-color: @nord11;
            text-color: @text-color;
          }
          #element.selected.active {
            background-color: @nord10;
            text-color: @text-color;
          }
          #scrollbar {
            handle-color: @nord3;
            handle-width: 0.50em;
          }
          #button.selected {
            background-color: @nord8;
            text-color: @nord4;
          }
        '';
    };
    xsession = {
      pointerCursor = {
        size = 32;
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
      };
    };
    xresources.properties = {
      "Xft.dpi" = 128;
      "Xft.autohint" = 0;
      "Xft.lcdfilter" = "lcddefault";
      "Xft.hintstyle" = "hintfull";
      "Xft.hinting" = 1;
      "Xft.antialias" = 1;
      "Xft.rgba" = 1;
      "Gtk.ButtonImages" = 1;
      "Gtk.CanChangeAccels" = 1;
      "Gtk.CursorThemeName" = "default";
      "Gtk.CursorThemeSize" = 0;
      "Gtk.EnableEventSounds" = 0;
      "Gtk.FontName" = "Sans 10";
      "Gtk.IconThemeName" = "oxygen";
      "Gtk.MenuBarAccel" = "F10";
      "Gtk.MenuImages" = 1;
      "Gtk.ToolbarIconSize" = 3;
      "Gtk.ToolbarStyle" = "icons";
      "UXTerm*termName" = "xterm-256color";
      "UXTerm*faceName" = "Fira Mono For Powerline";
      "UXTerm*faceSize" = 10;
      "UXTerm*renderFont" = true;
      "st.font" = "Fira Mono For Powerline-10";
      "st.termname" = "st-256color";

      "*.foreground" = nord4;
      "*.background" = nord0;
      "*.cursorColor" = nord4;
      "*fading" = 35;
      "*fadeColor" = nord3;

      "*.color0" = nord1;
      "*.color1" = nord11;
      "*.color2" = nord14;
      "*.color3" = nord13;
      "*.color4" = nord9;
      "*.color5" = nord15;
      "*.color6" = nord8;
      "*.color7" = nord5;
      "*.color8" = nord3;
      "*.color9" = nord11;
      "*.color10" = nord14;
      "*.color11" = nord13;
      "*.color12" = nord9;
      "*.color13" = nord15;
      "*.color14" = nord7;
      "*.color15" = nord6;
    };

    programs.obs-studio.enable = false;

    # programs.smos = {
    #   enable = false;
    #   backup.enable = true;
    #   calendar = {
    #     enable = true;
    #     sources = [
    #       {
    #         name = "Personal Calendar";
    #         source = secrets.users.jamie.personalCalendar;
    #         destination = "personal-calendar.smos";
    #       }
    #       {
    #         name = "Tweag Calendar";
    #         source = secrets.users.jamie.tweagCalendar;
    #         destination = "tweag-calendar.smos";
    #       }
    #     ];
    #   };
    #   notify.enable = true;
    #   scheduler = {
    #     enable = true;
    #     schedule = [
    #       {
    #         description = "Weekly tasks";
    #         template = "templates/weekly.smos.template";
    #         destination = "projects/weekly-[ %V | monday ].smos";
    #         schedule = "0 4 * * 0";
    #       }
    #       {
    #         description = "Monthly tasks";
    #         template = "templates/monthly.smos.template";
    #         destination = "projects/monthly-[ %b ].smos";
    #         schedule = "0 4 1 * *";
    #       }
    #     ];
    #   };
    #   sync = {
    #     enable = true;
    #     server-url = "https://api.smos.online";
    #     username = "jamalambda";
    #     password = secrets.users.jamie.smosPassword;
    #   };
    #   config = {
    #     github = {
    #       oauth-token = secrets.users.jamie.smosGithubToken;
    #     };
    #   };
    # };

    # programs.intray = {
    #   enable = false;
    #   sync = {
    #     enable = true;
    #     username = "jamalambda";
    #     password = secrets.users.jamie.intrayPassword;
    #   };
    # };

    # programs.tickler = {
    #   enable = false;
    #   sync = {
    #     enable = true;
    #     username = "jamalambda";
    #     password = secrets.users.jamie.ticklerPassword;
    #   };
    # };

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.git = {
      enable = true;
      lfs.enable = true;
      userEmail = "jhbertra@gmail.com";
      userName = "Jamie Bertram";
      extraConfig = {
        color.ui = true;
        commit.gpgsign = true;
        core.editor = "nvim";
        github.user = "jhbertra";
        alias = {
          br = "branch";
          ch = "checkout";
          co = "commit";
          hist = "log --oneline --graph --decorate --all";
          pf = "push --force-with-lease";
          s = "status";
        };
        init.defaultBranch = "main";
        merge = {
          tool = "vimdiff";
          conflictstyle = "diff3";
        };
        mergetool = {
          keepBackup = false;
          prompt = false;
          "vimdiff" = {
            cmd = "nvim -d $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
          };
        };
        pull.rebase = true;
        fetch.prune = true;
        diff.colorMoved = "zebra";
        user.signingkey = "D3BBD3ADD79DA763";
      };
    };

    programs.ssh = {
      enable = true;
      extraOptionOverrides = {
        ForwardAgent = "no";
        IdentitiesOnly = "yes";
        Compression = "yes";
      };
      extraConfig = ''
        Host eu.nixbuild.net
          PubkeyAcceptedKeyTypes ssh-ed25519
          IdentityFile /home/jamie/.ssh/dev-nixbuild-key
      '';
      matchBlocks = {
        "github.com" = {
          host = "github.com";
          user = "git";
          identityFile = "~/.ssh/id_ed25519";
        };
        "nix-docker" = {
          user = "root";
          host = "nix-docker";
          hostname = "127.0.0.1";
          port = 3022;
          identityFile = "~/.ssh/docker_rsa";
        };
      };
    };

    programs.tmux = {
      enable = true;
      clock24 = true;
      customPaneNavigationAndResize = true;
      historyLimit = 500000;
      keyMode = "vi";
      resizeAmount = 10;
      shortcut = "j";
      terminal = "st-256color";
      plugins = with pkgs.tmuxPlugins; [
        cpu
        nord
      ];
    };

    services.dunst = {
      enable = true;
      iconTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
        size = "32x32";
      };
      settings = {
        global = {
          # Display
          follow = "keyboard";
          geometry = "500x6-10+30";
          indicate_hidden = "yes";
          padding = 16;
          horizontal_padding = 16;
          frame_width = 2;
          frame_color = nord5;
          separator_color = "frame";
          sort = "yes";
          idle_threshold = 360;
          # Text
          font = "Fira Mono Regular 10";
          markup = "full";
          format = "<b>%s</b>\\n%b";
          alignment = "left";
          vertical_alignment = "center";
          word_wrap = "yes";
          ignore_newline = "no";
          stack_duplicates = true;
          # Icons
          icon_position = "left";
          max_icon_size = 32;
          # Misc/Advanced
          browser = "firefox";
          startup_notification = true;
          corner_radius = 8;
        };
        urgency_low = {
          background = nord1;
          foreground = nord3;
        };
        urgency_normal = {
          background = nord2;
          foreground = nord5;
        };
        urgency_critical = {
          background = nord8;
          foreground = nord6;
        };
      };
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      git_commit = {
        tag_disabled = false;
        only_detached = false;
      };
      git_metrics = {
        disabled = false;
      };
      memory_usage = {
        disabled = false;
        format = "via $symbol[\${ram_pct}]($style) ";
        threshold = -1;
      };
      shlvl = {
        disabled = false;
        symbol = "↕";
        threshold = -1;
      };
      status = {
        disabled = false;
        map_symbol = true;
        pipestatus = true;
      };
      time = {
        disabled = false;
        format = "[\\[ $time \\]]($style) ";
      };
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableBashCompletion = true;
    ohMyZsh = {
      enable = true;
      plugins = [
        "command-not-found"
        "fzf"
        "git"
        "history"
        "nix-shell"
        "ripgrep"
      ];
    };
    interactiveShellInit =
      ''
        eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
        export GPG_TTY="$(tty)"
      '';
  };

  services.xserver = {
    xkb.layout = "us";
    xkb.options = "ctrl:swapcaps,compose:ralt";
    # xkbVariant = "dvp";
  };

  services.kubo = {
    enable = true;
  };
}
