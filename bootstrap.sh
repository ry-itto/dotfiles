# link dotfiles
for dotfile in `find . -maxdepth 1 | xargs basename | grep -E '^\..+'`;
do
    if [ $dotfile = '.git' ]; then continue; fi
    echo "link $(pwd)/$dotfile to ~/$dotfile"
    ln -is $(pwd)/$dotfile ~/$dotfile
done

# homebrew
if ! type "brew" > /dev/null; then
    echo '`brew` not found. Install Homebrew'
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew bundle check --global
if [ $? -ne 0 ]; then
    echo 'Install `brew` dependencies...'
    brew bundle --global
else
    echo '`brew` dependencies are satisfied :smile:' | emojify
fi

# macOS and Xcode setting
echo 'macOS and Xcode setting...'
./.macos/macos.sh
./.xcode/xcode.sh
