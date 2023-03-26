{ pkgs, ... }:
{

  programs.fish.enable = true;
  programs.zsh.enable = true;
  #programs.bash.enable = true;
  
  nixpkgs.config.allowUnfree = true;
  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;
 
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  environment = {
    shells = with pkgs; [ fish ];
    loginShell = "${pkgs.fish}/bin/fish -l";
    pathsToLink = ["/Applications"];
  };

  users.users.andrearagao = {
    home = "/Users/andrearagao";
    shell = "${pkgs.fish}/bin/fish";
  };
  users.users.root = {
    home = "/var/root";
    shell = "${pkgs.fish}/bin/fish";
  };

  fonts.fontDir.enable = true;
  fonts.fonts = [ (pkgs.nerdfonts.override { fonts = [ "Meslo" "JetBrainsMono"]; }) ];
  environment.systemPackages = [
    pkgs.go
    pkgs.neovide
    pkgs.direnv
    pkgs.dt-shell-color-scripts
    pkgs.docker
    pkgs.kubectl
    pkgs.zellij
    pkgs.jdk19
    pkgs.vscode
    pkgs.vscode-extensions.golang.go
    pkgs.vscode-extensions.catppuccin.catppuccin-vsc
    pkgs.vscode-extensions.sumneko.lua
    pkgs.jetbrains.goland
    pkgs.jetbrains.idea-ultimate
    pkgs.speedtest-cli
    pkgs.graphviz
    pkgs.plantuml
    pkgs.git
    pkgs.coreutils
    pkgs.k9s
    pkgs.du-dust
    pkgs.bat
    pkgs.wget
    pkgs.curl
    pkgs.obsidian
    pkgs.alacritty
    pkgs.teams
    pkgs.neofetch
    pkgs.tealdeer
    pkgs.gnupg
    pkgs._1password
    pkgs.ngrok
    pkgs._1password-gui
    pkgs.nixfmt
    pkgs.rustup
    pkgs.font-awesome_5
    pkgs.nerdfonts
    pkgs.fortune
    pkgs.azure-cli
    pkgs.lima
    pkgs.docker-credential-helpers
    pkgs.docker-buildx
    pkgs.chafa
    pkgs.taskwarrior
    pkgs.taskwarrior-tui
    pkgs.rnix-lsp
    pkgs.bottom
    pkgs.gh
  ];

  homebrew = {
    enable = true;
    onActivation = {
      upgrade = true;
      autoUpdate = true;
      cleanup = "zap";
    };
    global.brewfile = true;
    caskArgs.no_quarantine = true;
    casks = [ "raycast" "rocket-chat" "google-chrome" ];
  };

  system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
  system.defaults.NSGlobalDomain.KeyRepeat = 3;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
  system.defaults.NSGlobalDomain._HIHideMenuBar = false;

  system.defaults.dock.autohide = true;
  system.defaults.dock.mru-spaces = false;
  system.defaults.dock.orientation = "bottom";
  system.defaults.dock.showhidden = true;
  system.defaults.dock.minimize-to-application = true;
  system.defaults.dock.launchanim = false;
  system.defaults.dock.appswitcher-all-displays = true;

  system.defaults.alf.globalstate = 0;

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.QuitMenuItem = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

  system.defaults.trackpad.Clicking = true;
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  security.pam.enableSudoTouchIdAuth = true;

  services.yabai.enable = true;
  services.yabai.package = pkgs.yabai;
  services.skhd.enable = true;
}
