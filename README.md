# dotfiles

ファイルに実行権限を付与し、実行
```
$ chmod +x ~/dotfiles/setup.sh
$ ./setup.sh
$ setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
$ ./setup.sh
```
