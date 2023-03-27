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

  #users.users.andrearagao = {
  #  home = "/Users/andrearagao";
  #  shell = "${pkgs.fish}/bin/fish";
  #};
  #users.users.root = {
  #  home = "/var/root";
  #  shell = "${pkgs.fish}/bin/fish";
  #};

  fonts.fontDir.enable = true;
  fonts.fonts = [ (pkgs.nerdfonts.override { fonts = [ "Meslo" "JetBrainsMono"]; }) ];
  environment.systemPackages = [
    pkgs.go
    pkgs.gopls
    pkgs.neovide
    pkgs.direnv
    pkgs.dt-shell-color-scripts
    pkgs.docker
    pkgs.kubectl
    pkgs.zellij
    pkgs.jdk19
    pkgs.jdt-language-server
    pkgs.lombok
    pkgs.vscode
    pkgs.vscode-extensions.golang.go
    pkgs.vscode-extensions.catppuccin.catppuccin-vsc
    pkgs.vscode-extensions.sumneko.lua
    pkgs.vscode-extensions.jnoortheen.nix-ide
    pkgs.vscode-extensions.brettm12345.nixfmt-vscode
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
    pkgs.nixfmt
    pkgs.cargo
    pkgs.rustc
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
    pkgs.jq
    pkgs.sketchybar #config requires SF Pro Font https://developer.apple.com/fonts/
    pkgs.nnn
    pkgs.nodejs
    pkgs.nil
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
    casks = [ "raycast" "rocket-chat" "google-chrome" "1password" "sf-symbols"];
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
  system.defaults.LaunchServices.LSQuarantine = false;
  system.defaults.NSGlobalDomain.AppleFontSmoothing = 2;
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain.AppleShowAllFiles = true;

  system.defaults.dock.autohide = true;
  system.defaults.dock.mru-spaces = false;
  system.defaults.dock.orientation = "left";
  system.defaults.dock.showhidden = true;
  system.defaults.dock.minimize-to-application = true;
  system.defaults.dock.launchanim = false;
  system.defaults.dock.mineffect = "suck"; #genie, scale, null
  system.defaults.dock.appswitcher-all-displays = true;
  system.defaults.dock.show-recents = false;

 # below cannot be changed in Avaya laptops - this should be placed on its own separate file
 # system.defaults.alf.globalstate = 0;

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.QuitMenuItem = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

  system.defaults.trackpad.Clicking = true;
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  security.pam.enableSudoTouchIdAuth = true;

#https://github.com/FelixKratz/dotfiles/tree/e6288b3f4220ca1ac64a68e60fced2d4c3e3e20b

  services.yabai.enable = true;
  services.skhd.enable = true;
}
