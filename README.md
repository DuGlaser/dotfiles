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
```

3. Create symbolic link.
```
$ sudo ansible-playbook -i inventory/localhost init.yml
```

4. Install tools.
```
$ sudo ansible-playbook -i inventory/localhost install.yml
```

5. Setup tools.
```
$ sudo ansible-playbook -i inventory/localhost setup.yml
```

## Other

- Font: https://github.com/romkatv/powerlevel10k#manual-font-installation
