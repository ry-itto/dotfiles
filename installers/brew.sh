if ! type "brew" > /dev/null; then
	echo '`brew` not found. Install Homebrew'
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle check --global
if [ $? -ne 0 ]; then
	echo 'Install `brew` dependencies...'
	brew bundle --global -v
else
	echo '`brew` dependencies are satisfied :smile:' | emojify
fi
