.PHONY: update
update:
	nvim --headless "+Lazy! update" +qa
	nvim --headless "+TSInstallSync all" +qa
	nvim --headless +TSUpdateSync +qa

.PHONY: install_provider
install_provider:
	python3 -m pip install --user --upgrade pynvim
	npm -g install neovim
