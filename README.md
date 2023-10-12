# How to use


This repo uses python's dotfiles (https://pypi.org/project/dotfiles/#configuration) as a way to keep track of different configuration files wihtin a linux system. 


Installation of Python tool to use this repo:
`$ pip install dotfiles`

Adding dotfiles to this repo (~/.vimrc in this example)

`$ dotfiles --add ~/.vimrc     (relative paths work also)`



How to sync configuration on a new computer
`$ dotfiles --sync`
