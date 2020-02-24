# link dotfiles
for dotfile in `find . -maxdepth 1 -type f | xargs basename | grep '^\.'`;
do
    echo "link $(pwd)/$dotfile to ~/$dotfile"
    ln -is $(pwd)/$dotfile ~/$dotfile
done

# homebrew
if ! type "brew" > /dev/null; then
    echo '`brew` not found. Install Homebrew'
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo 'Install `brew` dependencies...'
brew bundle --global

