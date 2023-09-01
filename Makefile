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

.PHONY: setup/rtx
setup/rtx: setup_rtx

.PHONY: setup/zsh
setup/zsh: setup_zsh

.PHONY: setup/ansible
setup/ansible: setup_ansible

.PHONY: setup/tmux
setup/tmux: setup_tmux

.PHONY: update
update: update/submodule update/nvim

.PHONY: update/submodule
update/submodule:
	cd ./zsh/private-commands && git clean -fdx && git checkout .
	git submodule update --remote --recursive

.PHONY: update/nvim
update/nvim: setup/nvim
	$(MAKE) -C .config/nvim update
