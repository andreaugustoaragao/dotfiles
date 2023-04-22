{ pkgs, ... }: {

  imports = [ ./fish.nix ];

  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "22.11";
  # specify my home-manager configs
  home.packages = [
    pkgs.ripgrep
    pkgs.fd
    pkgs.curl
    pkgs.less
    # pkgs.go
    # pkgs.gopls
    # pkgs.neovide
    # pkgs.direnv
    pkgs.dwt1-shell-color-scripts
    pkgs.docker
    pkgs.kubectl
    pkgs.kubernetes-helm
    pkgs.zellij
    #pkgs.jdk11
    #pkgs.jdk19
    pkgs.jdt-language-server
    pkgs.lombok
    pkgs.jetbrains.goland
    pkgs.jetbrains.idea-ultimate
    pkgs.speedtest-cli
    pkgs.graphviz
    pkgs.plantuml
    pkgs.git
    pkgs.coreutils
    # pkgs.k9s
    pkgs.du-dust
    pkgs.bat
    pkgs.wget
    pkgs.curl
    pkgs.obsidian
    pkgs.teams
    pkgs.neofetch
    pkgs.tealdeer
    pkgs.gnupg
    pkgs._1password
    pkgs.ngrok
    pkgs.nixfmt
    pkgs.cargo
    pkgs.rustc
    pkgs.font-awesome_5
    #pkgs.nerdfonts
    pkgs.fortune
    pkgs.azure-cli
    pkgs.docker-credential-helpers
    pkgs.docker-buildx
    pkgs.chafa
    pkgs.taskwarrior
    pkgs.taskwarrior-tui
    pkgs.rnix-lsp
    # pkgs.bottom
    #pkgs.gh
    #pkgs.jq
    #pkgs.sketchybar #config requires SF Pro Font https://developer.apple.com/fonts/
    #pkgs.nnn
    pkgs.nodejs
    pkgs.nil
    pkgs.k6
    pkgs.maven
    pkgs.inetutils
    pkgs.redis
    pkgs.lima
  ];

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
    VISUAL = "neovide";
  };

  programs.bat.enable = true;
  programs.bat.config.theme = "TwoDark";
  programs.fzf.enable = true;
  programs.fzf.enableFishIntegration = true;
  programs.fzf.enableZshIntegration = true;
  programs.bottom.enable = true;

  programs.exa = {
    enable = true;
    enableAliases = true;
    extraOptions = [ "--group-directories-first" ];
    icons = true;
    git = true;
  };

  programs.git = {
    enable = true;
    userName = "andreaugustoaragao";
    userEmail = "andrearag@gmail.com";
    extraConfig = {
      includeIf = {
        "gitdir:~/src/avaya/" = {
          user = "aragao";
          email = "aragao@avaya.com";
        };
      };
    };
  };

  programs.jq.enable = true;
  programs.k9s.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    shellAliases = { };
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      command_timeout = 1200;
      scan_timeout = 10;
      format = ''
        [](bold blue)$directory$cmd_duration $all$kubernetes$azure$time
        $character'';
      azure = {
        disabled = false;
        format = "\\[[az:($subscription)]($style)\\]";
      };
      kubernetes = {
        format = "\\[[k8s:($cluster)]($style)\\]";
        disabled = false;
      };
      docker_context = {
        format = "\\[[($symbol)($context)]($style)\\]";
        disabled = false;

      };
      gcloud = { disabled = true; };
      hostname = {
        ssh_only = true;
        format = "<[$hostname]($style)";
        trim_at = "-";
        style = "bold dimmed white";
        disabled = true;
      };
      line_break = { disabled = true; };
      username = {
        style_user = "bold dimmed blue";
        show_always = false;
        format = "user: [$user]($style)";
      };
    };
  };

  programs.alacritty = {
    enable = true;
    settings.font.normal.family = "JetBrainsMono Nerd Font Mono";
    settings.font.normal.style = "SemiBold";
    settings.font.size = 14;
    settings.window.padding.x = 3;
    settings.window.padding.y = 5;
    settings.window.decorations = "buttonless";
    settings.window.title = "Alacritty";
    settings.window.dynamic_title = true;
    settings.window.option_as_alt = "Both";
    settings.shell.program = "${pkgs.tmux}/bin/tmux";
    settings.shell.args = [ "attach" ];
    #settings.shell.args = [ "- -l" "- -c" "- tmux attach || tmux" ];
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk11;
  };

  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    userSettings = {
      "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font Mono";
      "terminal.integrated.fontSize" = 14;
      "terminal.integrated.shellIntegration.enabled" = true;
      "editor.fontFamily" = "JetBrainsMono Nerd Font Mono";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 14;
      "terminal.integrated.defaultProfile.osx" = "fish";
      "editor.formatOnSave" = true;
      "editor.fontWeight" = "medium";
      "workbench.iconTheme" = "vscode-icons";
      "go.inlayHints.parameterNames" = true;
      "go.diagnostic.vulncheck" = "Imports";
    };
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      bbenoist.nix
      catppuccin.catppuccin-vsc
      yzhang.markdown-all-in-one
      ms-vscode.makefile-tools
      golang.go
      redhat.java
      brettm12345.nixfmt-vscode
      vscode-icons-team.vscode-icons
    ];
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    escapeTime = 0;
    aggressiveResize = true;
    disableConfirmationPrompt = true;
    historyLimit = 10000;
    mouse = true;
    newSession = true;
    sensibleOnTop = true;
    prefix = "C-a";
    customPaneNavigationAndResize = true;
    terminal = "screen-256color";
    shell = "${pkgs.fish}/bin/fish";
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.cpu;
        extraConfig = ''
          set -g status-right "\
          #[fg=#89b4fa, bg=colour237] \
          #[fg=colour237, bg=#89b4fa] CPU: #{cpu_icon} #{cpu_percentage} \
          #[fg=colour241, bg=colour237]\
          #[fg=colour7, bg=colour241] %a %h-%d %H:%M \
          #[fg=colour248, bg=colour239]"


          #set -g status-right '#{cpu_bg_color} CPU: #{cpu_icon} #{cpu_percentage} | %a %h-%d %H:%M '
        '';
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15' # minutes
        '';
      }
    ];
    extraConfig = ''
      set -g terminal-overrides ',XXX:RGB'
      set -g terminal-overrides ',*256col*:RGB'
      set -g terminal-overrides ',alacritty:RGB'
      set -g focus-events on

      # Length of tmux status line
      set -g status-left-length 30
      set -g status-right-length 150

      set-option -g status "on"

      # Default statusbar color
      set-option -g status-style bg=colour237,fg=colour223 # bg=bg1, fg=fg1

      # Default window title colors
      set-window-option -g window-status-style "bg=#89b4fa,fg=colour237" # bg=yellow, fg=bg1

      # Default window with an activity alert
      set-window-option -g window-status-activity-style bg=colour237,fg=colour248 # bg=bg1, fg=fg3

      # Active window title colors
      set-window-option -g window-status-current-style bg=red,fg=colour237 # fg=bg1

      # Set active pane border color
      set-option -g pane-active-border-style "fg=#89b4fa"

      # Set inactive pane border color
      set-option -g pane-border-style fg=colour239

      # Message info
      set-option -g message-style bg=colour239,fg=colour223 # bg=bg2, fg=fg1

      # Writing commands inactive
      set-option -g message-command-style bg=colour239,fg=colour223 # bg=fg3, fg=bg1

      # Pane number display
      set-option -g display-panes-active-colour colour1 #fg2
      set-option -g display-panes-colour colour237 #bg1

      # Clock
      set-window-option -g clock-mode-colour colour109 #blue

      # Bell
      set-window-option -g window-status-bell-style bg=colour167,fg=colour235 # bg=red, fg=bg

      set-option -g status-left "\
      #[fg=colour7, bg=colour241]#{?client_prefix,#[bg=colour167],} ❐ #S \
      #[fg=colour241, bg=colour237]#{?client_prefix,#[fg=colour167],}#{?window_zoomed_flag, 🔍,}"

      #https://github.com/sbernheim4/dotfiles/blob/251a30db0dbbd2953df35bfa0ef43e92ce15b752/tmux/.tmux.conf#L193


      set-option -g status-right "\
      #[fg=#89b4fa, bg=colour237] \
      #[fg=colour237, bg=#89b4fa] CPU: #{cpu_icon} #{cpu_percentage} \
      #[fg=colour241, bg=colour237]\
      #[fg=colour7, bg=colour241] %a %h-%d %H:%M \
      #[fg=colour248, bg=colour239]"

      # set -g status-right '#{forecast} #{prefix_highlight} | %a %Y-%m-%d %H:%M'
      set-window-option -g window-status-current-format "\
      #[fg=colour237, bg=#89b4fa]\
      #[fg=colour239, bg=#89b4fa] #I* \
      #[fg=colour239, bg=#89b4fa, bold] #W\
      #[fg=#89b4fa, bg=colour237]"

      set-window-option -g window-status-format "\
      #[fg=colour237,bg=colour239,noitalics]\
      #[fg=colour223,bg=colour239] #I \
      #[fg=colour223, bg=colour239] #W\
      #[fg=colour239, bg=colour237]"

      set-option -g status-interval 2
    '';

  };

  programs.go = { enable = true; };

  programs.gitui = { enable = true; };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    extraConfig = "";
    extraLuaConfig = ''
      require("config")      
    '';
    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      telescope-file-browser-nvim
      alpha-nvim
      plenary-nvim
      trouble-nvim
      zen-mode-nvim
      nvim-treesitter.withAllGrammars
      lualine-nvim
      lualine-lsp-progress
      catppuccin-nvim
      mason-nvim
      mason-lspconfig-nvim
      nvim-lspconfig
      nvim-navic
      toggleterm-nvim
      todo-comments-nvim
      neo-tree-nvim
      go-nvim
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp_luasnip
      cmp-nvim-lua
      friendly-snippets
      nvim-web-devicons
      nui-nvim
      persistence-nvim
      rose-pine
      nvim-jdtls
      which-key-nvim
      undotree
      alpha-nvim
      lspkind-nvim
      nvim-autopairs
      harpoon
      indent-blankline-nvim
    ];
  };

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };

  xdg.configFile."sketchybar" = {
    source = ./sketchybar;
    recursive = true;
  };

  xdg.configFile."yabai" = {
    source = ./yabai;
    recursive = true;
  };

  xdg.configFile."skhd" = {
    source = ./skhd;
    recursive = true;
  };

  programs.home-manager.enable = true;
  # home.homeDirectory = "/Users/andrearagao";
  # home.username = "andrearagao";
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
    #enableFishIntegration = true;
  };

  programs.nnn = {
    enable = true;
    bookmarks = {
      d = "~/Documents";
      D = "~/Downloads";
      a = "~/OneDrive - Avaya";
      s = "~/src";
    };
  };

  programs.gh = { enable = true; };
  #home.file.".inputrc".source = ./dotfiles/inputrc;
}
