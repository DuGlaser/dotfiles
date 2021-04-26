# nvim_setting

## Requirements
* Neovim nightly
* Node
* Python3

## Setup

0. この設定ファイルでneovimを起動したときは色々エラーが出ると思いますが、無視してください(plugin入れてないのでそれはそう)
1. https://github.com/DuGlaser/dotfiles/blob/master/.config/nvim/lua/defaults/init.lua#L3 をコメントアウトします
2. 以下のコマンドを実行します
```bash
$ cd <this_project_root>
$ cp lua/defaults/path.example.lua lua/defaults/path.lua
```
3. `lua/defaluts/path.lua` にnodeとpythonのpathを設定します
4. 以下のコマンドを実行します
```bash
$ pip install pynvim
$ npm install -g neovim
```
5. Neovimを再起動し、`:PackageInstall` を実行します
6. Neovimを再起動し、`:TSInstall all` を実行します
