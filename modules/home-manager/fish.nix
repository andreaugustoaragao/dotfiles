{ config, pkgs, libs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      #set PATH /nix/var/nix/profiles/default/bin ~/.cargo/bin $PATH
      # Setup terminal, and turn on colors
      # set -x TERM xterm-256color
      # Enable color in grep
      set -x GREP_OPTIONS '--color=auto'
      set -x GREP_COLOR '3;33'
      # language settings
      set -x LANG en_US.UTF-8
      set -x LC_CTYPE "en_US.UTF-8"
      set -x LC_MESSAGES "en_US.UTF-8"
      set -x LC_COLLATE C
      set EDITOR "nvim"
      set VISUAL "neovide"
      function fish_greeting
        fortune
        colorscript random
      end
    '';
    functions = {

      o = ''
        if test (count $argv) -eq 0
          open .
        else
          open $argv
        end
      '';

      hm = ''
        pushd ~/.config
        home-manager switch --flake .#$argv[1]
        popd
      '';

      whatsmyip = ''
        curl ifconfig.me
      '';

      fixgpg = ''
        ssh $argv 'killall gpg-agent'
        rm ~/.ssh/sockets/*
        killall gpg-agent
        echo 'test' | gpg --clearsign
        ssh $argv 'ls /run/user/1000/gnupg/'
        ssh $argv 'echo 'test' | gpg --clearsign'
      '';

      fixssh = ''
        ssh $argv 'rm "~/.ssh/sockets/*"'
        rm ~/.ssh/sockets/*
        killall ssh-agent
        ssh $argv 'echo SSH_AUTH_SOCK: $SSH_AUTH_SOCK'
        ssh -tt $argv 'ssh git@github.com'
      '';

      mvbackup = ''
        mv $argv[1] $argv[1].bk-$(date +%Y%m%d-%H%M%S)
      '';

      mvrestore = ''
        original_file_name = echo $argv[1] | sed 's/\.bk(-.*)?//'
        mv $argv[1] 
      '';

      # This is a workaround needed to "fix" VSC on NixOS which is self-updating
      fixremotevsc = ''
        ssh $argv 'for DIR in ~/.vscode-server/bin/*; rm $DIR/node; ln -s (which node) $DIR/node; end'
      '';

      _git_fast = ''
        if begin not type -q commitizen; and test -z $argv[1]; end
          echo "No commit message provided or `commitizen` not installed"
          exit 1
        end
        set -x WIP_BRANCH (git symbolic-ref --short HEAD)
        git pull origin $WIP_BRANCH
        git add -A
        if test -z $argv[1]
          git cz
        else
          git commit -m $argv[1]
        end
        and git push origin $WIP_BRANCH
      '';
    };
    plugins = [
      {
        name = "fish-docker";
        src = pkgs.fetchFromGitHub {
          owner = "halostatue";
          repo = "fish-docker";
          rev = "e925cd39231398b3842db1106af7acb4ec68dc79";
          sha256 = "sha256-vFWSa4TlygBylWSqFFH195KZM3dE2G3RZjOMTkEhKW8=";
        };
      }
    ];
    shellAliases = {
      v = "nvim";
      gf = "_git_fast";
      fz = "fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'";
      cdg = "cd (git rev-parse --show-toplevel)";
      k = "kubectl";
    };

    shellAbbrs = {
      s = "ssh";

      # git
      g = "git";
      gs = "git status -s";
      ga = "git add";
      gl = "git log --pretty=format:'%C(yellow)%h %Cred%ar %Cblue%an%Cgreen%d %Creset%s' --date=short";
      gd = "git diff";
      gp = "git pull";
      gps = "git push";
      gcm = "git commit";
      gco = "git checkout";
      gcl = "git clone";

      d = "docker";
      dc = "docker compose";

      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";

      findport = "sudo lsof -iTCP -sTCP:LISTEN -n -P | grep";
    };
  };
}