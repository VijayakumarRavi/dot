" Line numbering
" set relativenumber number
set number

" Enable mouse scroll
" set mouse=a

" Lines vim should remember
set history=1000

" Don't be Vi compatible
set nocompatible

" Enable filytype plugin and indent
filetype plugin indent on

" Remap leader key
let mapleader=","

" Autoread file if changed externally
set autoread
au FocusGained,BufEnter * checktime

" Wildmenu in COMMAND mode
set path+=**
set wildmenu
set showcmd
" Ignore compiled files
set wildignore=*.o,*~,~*.pyc
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=node_modules/*,browse_components/*
if has("win16") || has("win32")
	set wildignore+=.git\*,.hg\*,.svn\*
else
	set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Make backspace work as it should
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Better searching
set ignorecase smartcase nohlsearch

" No redraw when using macros
set lazyredraw

" Vim's regular expression magic
set magic

" Show matching braces
set showmatch

" How many tenths of seconds ro blink
set mat=2

" Syntax highlighting
syntax enable

" utf-8 encoding
set encoding=utf-8
if &encoding != 'utf-8'
	set encoding=utf-8
endif

" unix as standard file format
set ffs=unix,dos,mac

" Hidden buffers
set hidden

" No backup files
set nobackup nowritebackup

" No swap files
set noswapfile

" Correct indentation
set autoindent smartindent

" Tab settings
set noexpandtab smarttab tabstop=4 shiftwidth=4

" Share system clipboard
set clipboard=unnamedplus

" Netrw directory history
let g:netrw_dirhistmax=0

" Autoremove unwanted whitespaces
autocmd BufWritePre * %s/\s\+$//e

" Shell
set shell=bash

" Python host
let g:python3_host_prog='/usr/bin/python3'

"Goyo
nnoremap <leader><ENTER> :Goyo<CR>
"Goyo settings
function! s:goyo_enter()
    set noshowmode
    set noshowcmd
    set nocursorline
	set number
    CocDisable
    Limelight
endfunction

function! s:goyo_leave()
    set showmode
    set showcmd
    set cursorline
    CocEnable
    Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

set scrolloff=4

