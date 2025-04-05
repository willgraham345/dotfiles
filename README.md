# Dotfile structure

3 different folders contain the configuration for Will's dotfiles.

- `personal/`
- `work/`
- `misc/`
- server/

With both the personal and work, these are set up for Linux. The idea is to run a script that will set up symplink from the home directory (or `.config/`) to the Dotfiles repo. Execute a script to setup.

## Neovim

Requires you to install this with the "Universal App Image" from the [Install.md](<https://github.com/neovim/(neovim/blob/master/INSTALL.md)>, so you get the latest version. Note, this does require fuse and libfuse2 for the command to work correctly.

```shell
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
./nvim-linux-x86_64.appimage
```

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
- npm
  - mermaid.cli
- ripgrep
- libreadline-dev
- kitty
