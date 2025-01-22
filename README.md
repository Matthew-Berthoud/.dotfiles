# .dotfiles

_Configuration for Development and Life_

## Goals
Main goal: a brand new Mac can be opened up and configured by running a single script.

Inspiration:
[mathiasbynens' Dotfiles](https://github.com/mathiasbynens/dotfiles)
[Brew Bundle](https://gist.github.com/ChristopherA/a579274536aab36ea9966f301ff14f3f)

## Tailscale
I have all my devices connected through a [Tailscale](https://tailscale.com) Tailnet. 
Without Tailscale, remotely accessing your devices from eachother is a bit more painful and risky, but with tailscale I can enable ssh between my devices easily.
My main use for Tailscale is [Tailscale SSH](https://tailscale.com/kb/1193/tailscale-ssh), but it has many other features as well!

## Mac
| Specification   | Details                  |
|-----------------|--------------------------|
| Chip            | Apple M1                 |
| Memory          | 8GB                      |
| Startup disk    | Macintosh HD             |
| Display         | 13.3-inch (2560 x 1600)  |
| Year            | 2020                     |

## Terminal and Shell
I use the default Mac Terminal since I don't customize anything about the terminal itself, just what runs in it.
I use `bash` instead of `zsh`, since `bash` is more ubiquitous in containers, servers, etc.
```sh
chsh -s /bin/bash
```
I don't install `tmux`, and instead just use the built-in `screen` utility to multiplex terminal screens.
[Here](http://hayne.net/MacDev/Notes/unixFAQ.html#shellStartup) are some good notes on what shell configuration files are read when on Mac.

<!--
## File Organization
I want my computer to be neat and tidy, without a lot of junk in my home directory (`/home/YOUR_USERNAME`, or `~`). Things like the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/latest/) are attractive to me. XDG doesn't work perfectly cleanly with Mac, or with all applications. [This Apple Documentation](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html) is particularly to learn about the MacOS file system.

MORE IN HERE ABOUT OTHER PROGRAMS.

Docker Desktop for Mac makes it impossible to change the default `~/.docker` directory. Hopefully it will be resolved in [this issue](https://github.com/docker/roadmap/issues/408), so I can move `~/.docker` to `~/.config/docker`.
-->


## Git
When you try to use `git` from the command-line of a fresh-intall Mac, it prompts you to install it along with various developer tools. I accepted these.
I use [ssh authentication with GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh), since I want to not have to enter a username and password every time I push, and I don't want to install the GitHub CLI.

## Karabiner Elements
I remapped Caps Lock to be Escape when pressed once, and Ctrl when held down. This makes Vim much more ergonomic. Download [Karabiner Elements](https://karabiner-elements.pqrs.org), allow it to do all the crazy admin level things to your computer, and add this Complex Modification:

```
{
    "description": "Caps→Esc/Ctrl if held",
    "manipulators": [
        {
            "from": {
                "key_code": "caps_lock",
                "modifiers": { "optional": ["any"] }
            },
            "to": [{ "key_code": "left_control" }],
            "to_if_alone": [{ "key_code": "escape" }],
            "type": "basic"
        }
    ]
}
```

## Docker Desktop
I'm making a valiant effort to download as few development dependencies as possible onto my machine, since I had over 120G of randomly strewn about "System Data" last time. [Docker](https://www.docker.com) helps keep things off my machine.

(Bonus: You can play [Vim Golf](https://www.vimgolf.com) through Docker)

## Homebrew
I'm using homebrew for dependency management, but trying to catalog everything that gets installed and why it's there, so I don't end up with too many dependencies.

Here's what I have so far. These can all be used by running `brew install NAME`

| `NAME` | purpose |
| ------ | ------- |
| `ctags` | jumping between instantiations and usages of words (variables) within a codebase, with Vim |
| `unnatural scrollwheels` | let's me set mouse scroll to be Windows-style, but keep trackpad as Mac style |


## Vim
I'm using vanilla Vim as my text editor. Yeah, I know.
[This video](https://www.youtube.com/watch?v=XA2WjJbmmoM) inspired me, and I'm slowly building up a decent configuration.

