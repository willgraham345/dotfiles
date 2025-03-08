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

## Other dependencies

zoxide
batcat
fdfind
fzf
delta
lazydocker [lazydocker](https://github.com/jesseduffield/lazydocker)
npm
ripgrep
