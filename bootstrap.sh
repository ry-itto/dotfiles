show_header() {
    printf "\e[34m"
    echo '====================================================================='
    echo ''
    echo '    ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗    '
    echo '    ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝    '
    echo '    ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗    '
    echo '    ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║    '
    echo '    ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║    '
    echo '    ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝    '
    echo '                                                                     '
    echo '                https://github.com/ry-itto/dotfiles                  '
    echo ''
    echo '====================================================================='
    printf "\e[0m\n"
}

link_dotfiles() {
    # ignore files that should not link to $HOME
    dotfile_ignore='''
    .git
    .gitignore
    .ruby-version
    .gitmodules
    .github
    '''

    for dotfile in `find . -maxdepth 1 | xargs basename | grep -E '^\..+'`;
    do
        if [ "$(echo $dotfile_ignore | grep $dotfile)" ] ; then continue; fi
        echo "link $(pwd)/$dotfile to $HOME/$dotfile"
        ln -fns $(pwd)/$dotfile $HOME/$dotfile
    done
}

homebrew() {
    if ! type "brew" > /dev/null; then
        echo '`brew` not found. Install Homebrew'
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi

    brew bundle check --global
    if [ $? -ne 0 ]; then
        echo 'Install `brew` dependencies...'
        brew bundle --global -v
    else
        echo '`brew` dependencies are satisfied :smile:' | emojify
    fi
}

setting() {
    echo 'macOS and Xcode setting...'
    ./macos/macos.sh
    ./xcode/xcode.sh
    ./.iterm/iterm.sh
}

ruby_bundle() {
    # install .ruby-version's ruby if not installed
    if [ "$(rbenv versions --bare | grep $(rbenv local))" = '' ]; then
        echo 'Install ruby...'
        rbenv install
    fi
    bundle install
}

main() {
    show_header
    link_dotfiles
    homebrew
    setting
    ruby_bundle
}

main
