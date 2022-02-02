"coc.nvim"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gb <C-o>

"Flutter"
nnoremap <leader>fa :CocCommand flutter.run<cr>
nnoremap <leader>fq :CocCommand flutter.dev.quit<cr>
nnoremap <leader>fr :CocCommand flutter.dev.hotReload<cr>
nnoremap <leader>fR :CocCommand flutter.dev.hotRestart<cr>
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
