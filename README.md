# dotfiles

## Setup

1. Clone this repo.
```
$ git clone https://github.com/DuGlaser/dotfiles.git ~/dotfiles
```

2. Install `Ansible`
```
# mac os
$ ~/dotfiles/.bin/mac/install_ansible.sh

# arch linux
$ sudo pacman -S ansible

$ sudo chown -R $(whoami) ~/.ansible/tmp
```

3. Create symbolic link.
```
$ cd $HOME/dotfiles
$ chmod +x ./.bin/init_setup.sh
$ ./.bin/init_setup.sh
```

4. Install tools.
```
$ sudo ansible-playbook -i inventory/localhost install.yml
```

5. Switch the default shell to `fish`.
> https://github.com/fish-shell/fish-shell#switching-to-fish

## Other

- Font: https://github.com/romkatv/powerlevel10k#manual-font-installation
