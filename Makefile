.PHONY: init
init: setup/init setup/ansible ansible/install

DEBUG_LEVEL:=-v

.PHONY: ansible/install
ansible/install:
	@ansible-playbook -i inventory/localhost install.yml $(DEBUG_LEVEL)

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

IMAGE_NAME:=duglaser-dotfiles

.PHONY: docker/ubuntu
docker/ubuntu:
	DOCKER_BUILDKIT=1 docker build -t $(IMAGE_NAME):ubuntu --target UBUNTU .
	docker run -it $(IMAGE_NAME):ubuntu /bin/bash
