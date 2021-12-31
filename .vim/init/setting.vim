"Ruby のファイルを高速で開くため、ruby_path を指定する"
let g:ruby_path="$HOME/.rbenv/shims/ruby"

"文字コードをUTF-8にする"
set fenc=utf-8
set encoding=utf8
"バックアップファイルを作らない"
set nobackup
"スワップファイルを作らない"
set noswapfile
"編集中のファイルが変更されたら自動で読み直す"
set autoread
" 入力中のコマンドをステータスに表示する
set showcmd
" 現在の行を強調表示
set cursorline
" インデントはスマートインデント
set smartindent
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 検索時に最後まで行ったら最初に戻る
set wrapscan
"行番号を表示する"
set number
"Tabを半角スペースにする"
set expandtab
"検索時インクリメンタルサーチを有効にする"
set incsearch
"改行時自動でインデントを入れる"
set autoindent
"シンタックスハイライトを有効にする"
syntax on
"自動インデントで入る空白の数"
set shiftwidth=4
"キーボードから入るタブの数"
set softtabstop=0
"新しいウィンドウを下に開く"
set splitbelow

