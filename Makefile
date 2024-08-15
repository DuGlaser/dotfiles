.PHONY: init
init: setup/init setup/ansible ansible/install

DEBUG_LEVEL:=-v

.PHONY: ansible/install
ansible/install:
	@ansible-playbook -i inventory/localhost install.yml $(DEBUG_LEVEL)

.PHONY:install_tools 
install_tools: install_tool/aws install_tool/docker install_tool/rust

install_tool/%:
	./scripts/installer/$*.sh

.PHONY: setup/init
setup/init:
	./scripts/init_setup.sh

.PHONY: setup_%
setup_%:
	./scripts/setup_$*.sh

.PHONY: setup/nvim
setup/nvim: setup_nvim

.PHONY: setup/alacritty
setup/alacritty: setup_alacritty

.PHONY: setup/mise
setup/mise: setup_mise

.PHONY: setup/ansible
setup/ansible: setup_ansible

.PHONY: setup/tmux
setup/tmux: setup_tmux

.PHONY: update
update: update/submodule update/nvim update/rust update/zsh

.PHONY: update/submodule
update/submodule:
	git submodule update --remote --recursive

.PHONY: update/nvim
update/nvim: setup/nvim
	$(MAKE) -C .config/nvim update

.PHONY: update/rust
update/rust:
	rustup update stable
	cargo install-update -a

.PHONY: update/zsh
update/zsh:
	sheldon lock --update
