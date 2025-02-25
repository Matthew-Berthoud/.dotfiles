# Docker Dev

I hate installing dependencies locally. With this Docker dev system I can develop everything in Docker containers. I launch containers for them with the following command:

```sh
ddev LANGUAGE
```

Right now I have containers for React, Go, and Python.

## Flathat Games
Specifically for the flat hat games project I'm working on, I have an alias `fhg` defined that runs `ddev react 5173 5173`. I also have a `vite.config.ts` file in this repo that I pop from my git stash in the flathat games repo in order for the ports to forward correctly.

