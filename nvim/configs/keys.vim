" noremap <Up> <Nop>
" noremap <Down> <Nop>
" noremap <Left> <Nop>
" noremap <Right> <Nop>

" inoremap <expr> <c-j> ("\<C-n>")
" inoremap <expr> <c-k> ("\<C-p>")

nnoremap <C-j> :resize -2<CR>
nnoremap <C-k> :resize +2<CR>
nnoremap <C-l> :vertical resize -2<CR>
nnoremap <C-h> :vertical resize +2<CR>

tnoremap <C-w> <C-\><C-n><C-w>

nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>n :Files<CR>
