DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .config .ruby-version .github
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
DEPS_INSTALLERS := $(wildcard installers/??*)
SETTINGS_INSTALLERS := $(wildcard settings/**/install.sh)

# 進捗表示用の変数
STEP := 0
TOTAL_STEPS := 4

define print_step
	@echo "\n============================================="
	@echo "Step $(STEP)/$(TOTAL_STEPS): $1"
	@echo "=============================================\n"
	@$(eval STEP := $(shell echo $$(($(STEP) + 1))))
endef

all: install deps
	@echo "\n✨ All tasks completed successfully!\n"

list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

install: 
	$(call print_step,Installing dotfiles)
	@echo 'Linking dotfiles to home directory...'
	@$(foreach val, $(DOTFILES), echo "  Linking $(val)..." && ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@echo 'Creating $(HOME)/.config and copying settings...'
	@mkdir -p $(HOME)/.config && cp -r .config/* $(HOME)/.config
	@echo 'Installing settings...'
	$(foreach val, $(SETTINGS_INSTALLERS), echo "  Installing $(val)..." && /bin/zsh $(val);)

deps:	
	$(call print_step,Installing dependencies)
	@echo 'Running dependency installers...'
	$(foreach val, $(DEPS_INSTALLERS), echo "  Running $(val)..." && /bin/zsh $(val);)
