.PHONY: update
update:
	nvim --headless "+Lazy! update" +qa
	nvim --headless "+TSInstall all" +qa
	nvim --headless +TSUpdateSync +qa

.PHONY: init
init:
	cp -R ./lua/defaults/path.example.lua ./lua/defaults/path.lua

.PHONY: install_provider
install_provider:
	python3 -m pip install pynvim
	npm -g install neovim
