# dotfiles

```
# brewのためにインストール
$ xcode-select --install

# 実家のような安心感
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# dotfilesをクローン
$ git clone https://github.com/DuGlaser/dotfiles.git

# setup.shに実行権限を付与
$ chmod +x ~/dotfiles/setup.sh

# 初期設定
$ ./setup.sh
$ setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
$ ./setup.sh

$ cd $HOME/Dotfiles

# brweでいろいろインストール
$ brew bundle install

# nvimのディレクトリ名を変える
$ mv .config/nvim_setting .config/nvim

# powerline10kの設定
$ source $HOME/.p10k.zsh
```
