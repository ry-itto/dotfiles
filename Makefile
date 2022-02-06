DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .config .ruby-version .github
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
DEPS_INSTALLERS := $(wildcard installers/??*)
SETTINGS_INSTALLERS := $(wildcard settings/**/install.sh)

all: install deps

list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

install: 
	@echo 'Link dotfiles to home directory...'
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@echo 'Create $(HOME)/.config and copy .config settings to home directory...'
	@mkdir -p $(HOME)/.config && cp -r .config/* $(HOME)/.config
	@echo 'Install setting'
	$(foreach val, $(SETTINGS_INSTALLERS), /bin/zsh $(val);)

deps:	
	$(foreach val, $(DEPS_INSTALLERS), /bin/zsh $(val);)
