# MacBook Pro

## Specs 
| Specification   | Details                   |
|-----------------|---------------------------|
| Chip            | Apple M1                 |
| Memory          | 8GB                      |
| Startup disk    | Macintosh HD             |
| Display         | 13.3-inch (2560 x 1600)  |
| Year            | 2020                     |

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

