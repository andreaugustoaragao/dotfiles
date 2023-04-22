#!/bin/sh
#https://xyno.space/post/nix-darwin-introduction
# builds the darwinConfiguration.
# after insalling nix-darwin, we won't need to specify extra-experimental-features anymore
set -e
HOSTNAME=$(hostname)
echo updating $HOSTNAME
nix flake update --commit-lock-file --extra-experimental-features "nix-command flakes" 
nix build .#darwinConfigurations.$HOSTNAME.system --extra-experimental-features "nix-command flakes"
./result/sw/bin/darwin-rebuild switch --flake . 