# Install dein
INSTALLATION_DIR=$HOME/.cache/dein

tmp_dir=$(mktemp -d)

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $tmp_dir/installer.sh
chmod u+x $tmp_dir/installer.sh

$tmp_dir/installer.sh $INSTALLATION_DIR

trap 'rm -rf "$tmp_dir"' EXIT