link_dotfiles() {
    for dotfile in `find . -maxdepth 1 | xargs basename | grep -E '^\..+'`;
    do
        if [ $dotfile = '.git' ]  || [ $dotfile = '.gitmodules' ] || [ $dotfile = '.ruby-version' ] || [ $dotfile = '.gitignore' ]; then continue; fi
        echo "link $(pwd)/$dotfile to ~/$dotfile"
        ln -fns $(pwd)/$dotfile ~/$dotfile
    done
}

homebrew() {
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
}

setting() {
    echo 'macOS and Xcode setting...'
    ./.macos/macos.sh
    ./.xcode/xcode.sh
    ./.iterm/iterm.sh
}

ruby_bundle() {
    # install .ruby-version's ruby if not installed
    if [ "$(rbenv versions --bare | grep $(rbenv local))" = '' ]; then
        rbenv install
    fi
    bundle install
}

main() {
    link_dotfiles
    homebrew
    setting
    ruby_bundle
}

main
