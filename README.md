# dotfiles

## Setup

1. Clone this repo.
```
git clone https://github.com/DuGlaser/dotfiles.git ~/dotfiles
```

2. Install `Ansible`.
```
# mac os
~/dotfiles/.bin/mac/install_ansible.sh
```

```
# arch linux
sudo pacman -S ansible

# ubuntu
sudo apt install ansible
```

```
sudo chown -R $(whoami) ~/.ansible/tmp
```

3. Create symbolic link.
```
cd $HOME/dotfiles
chmod +x ./.bin/init_setup.sh ./.bin/setup_zsh.sh
./.bin/init_setup.sh
./.bin/setup_zsh.sh
```

4. Install tools.
```
ansible-playbook -i inventory/localhost install.yml
```

5. change login shell
```
chsh -s $(which zsh)
```

## Other

- Font: https://github.com/romkatv/powerlevel10k#manual-font-installation
