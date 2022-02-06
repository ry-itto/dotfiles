if ! type 'code' > /dev/null; then
    echo 'Please install vscode and activate `code` command.'
    exit 1
fi

pkglist=(
bungcip.better-toml
CoenraadS.bracket-pair-colorizer
daylerees.rainglow
dbaeumer.vscode-eslint
eamodio.gitlens
elmTooling.elm-ls-vscode
esbenp.prettier-vscode
MS-CEINTL.vscode-language-pack-ja
ms-python.python
rust-lang.rust
shd101wyy.markdown-preview-enhanced
streetsidesoftware.code-spell-checker
toba.vsfire
VisualStudioExptTeam.vscodeintellicode
vscode-icons-team.vscode-icons
vscodevim.vim
yzane.markdown-pdf
)

for i in ${pkglist[@]}; do
    code --install-extension $i
done
