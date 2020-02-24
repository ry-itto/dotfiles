"Vundle"
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
call vundle#end()
filetype plugin indent on

"nerdtree"
map <C-n> :NERDTreeToggle<CR>

"文字コードをUTF-8にする"
set fenc=utf-8
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

if has("autocmd")
  "ファイルタイプの検索を有効にする
  filetype plugin on
  "ファイルタイプに合わせたインデントを利用
  filetype indent on
  "sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtabの略
  autocmd FileType c           setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cc          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType js          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType zsh         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scala       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType json        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scss        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sass        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript  setlocal sw=4 sts=4 ts=4 et
endif

