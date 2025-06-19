# somafzf

Simple bash/fish shell scripts to browse and play SomaFM radio streams from the command line.  
It fetches the station list from the SomaFM homepage, presents it in an interactive menu via `fzf`, and plays your selection with `mpv`. When you quit `mpv` normally (press `q`), the menu comes back up so you can pick another station; if you abort with Ctrl‑C, the function exits back to your shell.

---

## Features

- **Live station list**: automatically scrapes `https://somafm.com/` for all available stations.
- **Clean options**: collapses all URLs (e.g. `groovesalad128.pls`, `groovesalad64.pls`) down to the base station slug.
- **Interactive picker**: uses [fzf](https://github.com/junegunn/fzf) for fuzzy‐search station selection.
- **Looping playback**: after a clean `mpv` quit (exit code 0), the station menu returns; otherwise it exits.

---

## Prerequisites

Make sure you have the following installed and available in your `$PATH`:

- **[fzf](https://github.com/junegunn/fzf)** — interactive fuzzy finder  
- **[mpv](https://mpv.io/)** — media player
- **[Fish shell](https://fishshell.com/)** — if you are using the fish version
- **curl, grep, sed, sort** — all normally pre‑installed  

On Debian/Ubuntu you can install them like:

```sh
sudo apt update
sudo apt install fzf mpv
```
