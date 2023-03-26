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
    };
  };

  programs.alacritty = {
    enable = true;
    settings.font.normal.family = "JetBrainsMono Nerd Font Mono";
    settings.font.size = 13;
    settings.shell.program = "${pkgs.fish}/bin/fish";
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
    extraConfig = ''
      set -ga terminal-overrides ',screen-256color:Tc'
    '';
    terminal = "screen-256color";
    shell = "${pkgs.fish}/bin/fish";
    plugins = with pkgs; [
      tmuxPlugins.cpu
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

  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    extraConfig = "";
    extraLuaConfig = ''
      vim.opt.relativenumber = true
      vim.opt.nu = true
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true
      vim.opt.smartindent = true
      vim.opt.backup = false
      vim.opt.undofile = true
      vim.opt.termguicolors = true
      vim.opt.scrolloff = 8
      vim.opt.signcolumn = "yes"
      vim.opt.updatetime = 50
      vim.opt.colorcolumn = "120"
      vim.g.mapleader=" "
      vim.g.airline_powerline_fonts = 1
      vim.opt.foldmethod = 'expr'
      vim.cmd('set nofoldenable')
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
    ];
  };

  
  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };

  programs.home-manager.enable = true;
  home.homeDirectory = "/Users/andrearagao";
  home.username = "andrearagao";
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
    # enableFishIntegration = true;
  };

  #home.file.".inputrc".source = ./dotfiles/inputrc;
}
