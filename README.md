# dotfiles

## Manjaro KDE

1. インストール
```bash
$ cd $HOME
$ git clone --recursive https://github.com/DuGlaser/dotfiles.git
$ cd $HOME/dotfiles

$ chmod +x $HOME/dotfiles/.bin/init_setup.sh
$ bash $HOME/dotfiles/.bin/init_setup.sh
$ bash $HOME/dotfiles/.config/setup_config.sh
```

```bash
$ cd $HOME && git clone --recursive https://github.com/DuGlaser/dotfiles.git && cd $HOME/dotfiles && chmod +x $HOME/dotfiles/.bin/init_setup.sh && bash $HOME/dotfiles/.bin/init_setup.sh && bash $HOME/dotfiles/.config/setup_config.sh
```

2. fishの設定
```bash
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

3. PC再起動
4. brewの設定
```
$ bash
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ cd $HOME/dotfiles
$ brew bundle
$ exit
```

5. tmuxの設定
```
$ sudo pacman -S xsel
# tmux tmp settings
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# <C-a>+I 
```

6. Alacrittyの設定
```
# https://github.com/alacritty/alacritty/blob/master/INSTALL.md#arch-linux
$ sudo pacman -S cmake freetype2 fontconfig pkg-config make libxcb
$ bash $HOME/dotfiles/.bin/setup_alacritty.sh
```

pkgconfig周りのbuildエラーが発生した場合、以下のコマンドを実行する
```
$ brew uninstall --ignore-dependencies pkg-config
```

7. nvimの設定
```
# https://github.com/neovim/neovim/wiki/Building-Neovim#arch-linux
$ sudo pacman -S base-devel cmake unzip ninja tree-sitter
$ bash $HOME/dotfiles/.bin/setup_nvim.sh
$ cp $HOME/dotfiles/.config/nvim/lua/defaults/path.example.lua $HOME/dotfiles/.config/nvim/lua/defaults/path.lua
$ brew install node
$ npm install -g neovim
$ pip3 install pynvim
```
