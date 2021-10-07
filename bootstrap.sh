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

install_deps() {
	./installers/brew.sh
	./installers/zplug.sh
	./installers/rust.sh
	./installers/flutter.sh
}

setting() {
    echo 'macOS and Xcode setting...'
    ./macos/macos.sh
    ./xcode/xcode.sh
    ./vscode/vscode.sh
    ./.iterm/iterm.sh
    ./.vim/init.sh
}

main() {
    show_header
    link_dotfiles
    install_deps
    setting
    ruby_bundle
}

main
