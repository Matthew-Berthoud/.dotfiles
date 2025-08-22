# .dotfiles

_Configuration for Development and Life_

## Overview
This repo contains everything you should need to set up a brand new Mac with my development configuration, and the best part is it can all be done by running one script:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Matthew-Berthoud/.dotfiles/HEAD/scripts/install.sh)"
```

## Tailscale
I have all my devices connected through a [Tailscale](https://tailscale.com) Tailnet. 
Without Tailscale, remotely accessing your devices from eachother is a bit more painful and risky, but with tailscale I can enable ssh between my devices easily.
My main use for Tailscale is [Tailscale SSH](https://tailscale.com/kb/1193/tailscale-ssh), but it has many other features as well!

## PC
I use a Windows PC for some gaming and hosting Linux VMs.
I change the behavior of the caps lock key to function as both escape and control (helpful for vim) with [kmonad](https://github.com/kmonad/kmonad/tree/master).
The config.kbd file in this repo sets it up, and it can be used on both Windows and Linux, which is convenient, since I use both on this computer.

## Mac
My main machine, and the one for which these dotfiles are primarily written, is a Mac.

| Specification   | Details                  |
|-----------------|--------------------------|
| Chip            | Apple M1                 |
| Memory          | 8GB                      |
| Startup disk    | Macintosh HD             |
| Display         | 13.3-inch (2560 x 1600)  |
| Year            | 2020                     |

## Homebrew
I use homebrew to manage dependencies, and Brewfiles to manage the management of dependencies, with
[brew bundle](https://gist.github.com/ChristopherA/a579274536aab36ea9966f301ff14f3f).
Some things like Go and Tailscale I don't use homebrew for, and running the `install.sh` script should make it clear how they're installed.

## Karabiner Elements
I remapped Caps Lock to be Escape when pressed once, and Ctrl when held down. This makes Vim much more ergonomic.
Karabiner Elements gets installed with Homebrew, and you can add the file in this repo as a Complex Modification to get the remapped behavior.

## Terminal and Shell
I use [Ghostty](https://ghostty.org/) since it seems cool and the default Mac terminal has weird issues with Neovim colorscheme.
I use `bash` instead of `zsh`, since `bash` is more ubiquitous in containers, servers, etc, so it's worth getting used to.
```sh
chsh -s /bin/bash
```
[Here](http://hayne.net/MacDev/Notes/unixFAQ.html#shellStartup) are some good notes on what shell configuration files are read when on Mac.

## Development
neovim, tmux, docker

(Bonus: You can play [Vim Golf](https://www.vimgolf.com) through Docker)

## Languages
My worst nightmare is having a bunch of miscellaneous installations of various languages lingering around on my computer.
In order to avoid this, I try to use the most standard, organized ways of installing lanugages.

### Python
I use Homebrew to install `pyenv`, a version manager and virtual environment manager for python versions.
It has a pretty simple CLI and seems to cleanly manage things.

### JS and Node
I use Node Version Manager (`nvm`), installed with Homebrew, to manage my installs of node, and node package manager (`npm`).

### Go
I directly downloaded and installed the Go binary, which is the recommended method, since go managages updates for itself.

### Bash
Installed from brew, since the Mac default is too old for some things.

## ssh
So that I don't have to type the password every time when ssh-ing into a machine:
```bash
ssh-copy-id -i ~/.ssh/id_ed25519.pub remote-user@remote-host
```

