.PHONY: init
init: setup/init setup/ansible ansible/install

.PHONY: ansible/install
ansible/install:
	@ansible-playbook -i inventory/localhost install.yml -v

.PHONY: setup/init
setup/init:
	./scripts/init_setup.sh

.PHONY: setup/nvim
setup/nvim:
	./scripts/setup_nvim.sh

.PHONY: setup/alacritty
setup/alacritty:
	./scripts/setup_alacritty.sh

.PHONY: setup/zsh
setup/zsh:
	./scripts/setup_zsh.sh

.PHONY: setup/ansible
setup/ansible:
	./scripts/setup_ansible.sh

.PHONY: setup/rust
setup/rust:
	./scripts/setup_rust.sh

.PHONY: setup/asdf
setup/asdf:
	./scripts/setup_asdf.sh
