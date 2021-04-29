" noremap <Up> <Nop>
" noremap <Down> <Nop>
" noremap <Left> <Nop>
" noremap <Right> <Nop>

inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

nnoremap <M-j> :resize -2<CR>
nnoremap <M-k> :resize +2<CR>
nnoremap <M-l> :vertical resize -2<CR>
nnoremap <M-h> :vertical resize +2<CR>

tnoremap <C-w> <C-\><C-n><C-w>

nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>n :Files<CR>
