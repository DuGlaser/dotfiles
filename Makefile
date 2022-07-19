.PHONY: init
init:
	$(MAKE) setup/init ansible/install

.PHONY: ansible/install
ansible/install:
	@ansible-playbook -i inventory/localhost install.yml

.PHONY: setup/init
setup/init:
	./.bin/init_setup.sh

.PHONY: setup/nvim
setup/nvim:
	./.bin/setup_nvim.sh

.PHONY: setup/alacritty
setup/alacritty:
	./.bin/setup_alacritty.sh

.PHONY: setup/zsh
setup/zsh:
	./.bin/setup_zsh.sh
