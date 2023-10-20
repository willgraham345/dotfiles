# How to use


This repo uses python's dotfiles (https://pypi.org/project/dotfiles/#configuration) as a way to keep track of different configuration files wihtin a linux system. 


Installation of Python tool to use this repo:
`$ pip install dotfiles`

Adding dotfiles to this repo (~/.vimrc in this example)

`$ dotfiles --add ~/.vimrc     (relative paths work also)`



How to sync configuration on a new computer
`$ dotfiles --sync`

To install zsh plugins:
```
'''
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
'''
For specifically powerline10k
```
sudo apt-get install fonts-powerline
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

Installing LF
```
wget https://github.com/gokcehan/lf/releases/download/r8/lf-linux-amd64.tar.gz
tar xvf lf-linux-amd64.tar.gz
mv lf /usr/local/bin
```
The first command downloads it, the second unpacks it, the third moves it into an executable




