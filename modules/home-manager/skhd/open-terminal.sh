#!/bin/bash
alacritty msg create-window "$@"|| (alacritty "$@" & disown)