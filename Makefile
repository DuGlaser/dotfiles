.PHONY: init
init: setup/init setup/ansible ansible/install

DEBUG_LEVEL:=-v

.PHONY: ansible/install
ansible/install:
	@ansible-playbook -i inventory/localhost install.yml $(DEBUG_LEVEL)

.PHONY:install_tools 
install_tools: install_tool/asdf install_tool/aws install_tool/docker install_tool/rust

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

.PHONY: setup/zsh
setup/zsh: setup_zsh

.PHONY: setup/ansible
setup/ansible: setup_ansible

.PHONY: setup/tmux
setup/tmux: setup_tmux

IMAGE_NAME:=duglaser-dotfiles

.PHONY: docker/ubuntu
docker/ubuntu:
	DOCKER_BUILDKIT=1 docker build -t $(IMAGE_NAME):ubuntu --target UBUNTU .
	docker run -it $(IMAGE_NAME):ubuntu /bin/bash
