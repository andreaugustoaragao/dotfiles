#!/bin/sh
#https://xyno.space/post/nix-darwin-introduction
# builds the darwinConfiguration.
# after insalling nix-darwin, we won't need to specify extra-experimental-features anymore
set -e
nix build .#darwinConfigurations.terminal-mbp.system --extra-experimental-features "nix-command flakes"

# the plan is to now run this to install nix-darwin with our configuration
./result/sw/bin/darwin-rebuild switch --flake . # this will fail as we first have to do the following lines

printf 'run\tprivate/var/run\n' | sudo tee -a /etc/synthetic.conf # read below
/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t # read below

# now we can finally darwin-rebuild
./result/sw/bin/darwin-rebuild switch --flake . # install nix-darwin
