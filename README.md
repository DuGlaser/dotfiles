# dotfiles

```
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/Dotfiles/.zprezto/runcoms/^README.md(.N); do
  ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```

```
ln -sf ~/Dotfiles/.zprezto ~/.zprezto 
ln -sf ~/Dotfiles/.zshrc ~/.zshrc
```
