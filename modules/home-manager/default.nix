{ pkgs, ... }: {

  imports = [ ./fish.nix ];

  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "22.11";
  # specify my home-manager configs
  home.packages = with pkgs; [ ripgrep fd curl less ];
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
  programs.exa = {
    enable = true;
    enableAliases = true;
    extraOptions = [ "--group-directories-first" ];
    icons = true;
    git = true;
  };
  programs.git.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    shellAliases = { };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    settings = { 
      add_newline = false;
      command_timeout = 1200;
      scan_timeout = 10;
      format = "[](bold blue)$directory$cmd_duration $all$kubernetes$azure$time
$character";
      azure = {
        disabled = false;
      };
      line_break = {
        disabled = true;
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

  };

  programs.java = {
    enable = true;
    package = pkgs.jdk19;
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
        extraConfig = "set -g status-right '#{cpu_bg_color} CPU: #{cpu_icon} #{cpu_percentage} | %a %h-%d %H:%M '";
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
      packer-nvim
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
    # enableFishIntegration = true;
  };

  #home.file.".inputrc".source = ./dotfiles/inputrc;
}
