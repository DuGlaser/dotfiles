# dotfiles

```
# brewのためにインストール
$ xcode-select --install

# 実家のような安心感
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# デフォルトターミナルがzshであることを確認する

# dotfilesをクローン
$ git clone --recursive https://github.com/DuGlaser/dotfiles.git
$ cd $HOME/Dotfiles

# setup.shに実行権限を付与
$ chmod +x ~/dotfiles/setup.sh

# 初期設定
$ ./setup.sh

# zinitの設定
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

# 一度ターミナルを再起動する
# starshipをまだインストールしていないためエラーが出るが
# 気にせずに作業する

$ zinit self-update

# brweでいろいろインストール
$ brew bundle install

# nvimのディレクトリ名を変える
$ mv .config/nvim_setting .config/nvim

# powerline10kの設定
# https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k
# 👆フォントをインストール

# tmux tmp settings
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# <Prifix>+I 
```
