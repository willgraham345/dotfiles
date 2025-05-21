# Dotfile structure

3 different folders contain the configuration for Will's dotfiles.

- `personal/`
- `work/`
- `misc/`
- server/

With both the personal and work, these are set up for Linux. The idea is to run a script that will set up symplink from the home directory (or `.config/`) to the Dotfiles repo. Execute a script to setup.

## Neovim

Install Neovim using homebrew to get the latest version

### Neovim with VSCode

Keybindings should be set up to be similar, don't worry too much about this. Only use vscode when you really need to.

## Tmux

Make sure to fetch the plugins for tmux, can be done by pressing

```
C-Space + I
```

- Make sure to hit shift+i to make it capital...

## Other dependencies

- zoxide
- batcat
- fdfind
- fzf
- delta
- lazydocker [lazydocker](https://github.com/jesseduffield/lazydocker)
- ripgrep
- libreadline-dev

Potential (mermaidcli stuff)

- npm (not sure that I need this one, doesn't work with )
  - mermaid.cli (install locally rather than globally)
- kitty
- [navi](https://github.com/denisidoro/navi?tab=readme-ov-file)
- luajit
- libmagickwand-dev
- luarocks
  - luarocks install magick

## Language Specifics

- Bacon (use cargo install bacon)
