# dotfiles

## MacOS

1. brewの設定
```
$ xcode-select --install
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
2. デフォルトターミナルがzshであることを確認する 
3. インストール
```
$ git clone --recursive https://github.com/DuGlaser/dotfiles.git
$ cd $HOME/Dotfiles

$ chmod +x $HOME/dotfiles/.bin/init_setup.sh

$ $HOME/dotfiles/.bin/init_setup.sh
$ $HOME/dotfiles/.bin/setup_zsh.sh
```
4. ターミナル再起動

5. プラグインインストール
```
$ zinit self-update

$ brew bundle install
```

6. フォントの設定
```
# powerline10kの設定
# https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k
# 👆フォントをインストール
```

7. tmuxの設定
```
# tmux tmp settings
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# <Prifix>+I 
```

## Linux(Ubuntu)

1. インストール
```
$ git clone --recursive https://github.com/DuGlaser/dotfiles.git
$ cd $HOME/Dotfiles

$ chmod +x $HOME/dotfiles/.bin/init_setup.sh

$ bash $HOME/dotfiles/.bin/init_setup.sh
$ bash $HOME/dotfiles/.bin/setup_fish.sh
```

2. fishの設定
```zsh
$ sudo apt-add-repository ppa:fish-shell/release-3
$ sudo apt-get update
$ sudo apt-get install fish

$ echo /usr/bin/fish | sudo tee -a /etc/shells

# or
# echo /usr/local/bin/fish | sudo tee -a /etc/shells

$ chsh -s /usr/bin/fish

# or
# chsh -s /usr/local/bin/fish

$ curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
```

3. ターミナル再起動
4. brewの設定
```
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ cd $HOME/dotfiles
$ brew bundle
```

5. tmuxの設定
```
$ sudo apt-get install xsel
# tmux tmp settings
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# <Prifix>+I 
```
