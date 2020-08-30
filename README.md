# dotfiles

```
# brewのためにインストール
$ xcode-select --install

# 実家のような安心感
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# dotfilesをクローン
$ git clone --recursive https://github.com/DuGlaser/dotfiles.git

# setup.shに実行権限を付与
$ chmod +x ~/dotfiles/setup.sh

# 初期設定
$ ./setup.sh

$ cd $HOME/Dotfiles

# brweでいろいろインストール
$ brew bundle install

# nvimのディレクトリ名を変える
$ mv .config/nvim_setting .config/nvim

# powerline10kの設定
# https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k
# 👆フォントをインストール
$ source $HOME/.p10k.zsh

# tmux tmp settings
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# <Prifix>+I 
```
