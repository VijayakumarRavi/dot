if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/vim/plugged')
"Plug 'dylanaraps/wal.vim'
"Plug 'wadackel/vim-dogrun'
Plug 'cocopon/iceberg.vim'
Plug 'arzg/vim-substrata'
"Plug 'bluz71/vim-moonfly-colors'
Plug 'arcticicestudio/nord-vim'

Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'dhruvasagar/vim-table-mode', { 'for': ['markdown', 'markdown.pandoc'] }

Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'

" Plug 'junegunn/goyo.vim', { 'for': ['markdown', 'markdown.pandoc', 'latex', 'tex'] }
Plug 'junegunn/goyo.vim'

Plug 'voldikss/vim-floaterm'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

Plug 'sheerun/vim-polyglot'
Plug 'vim-pandoc/vim-pandoc-syntax', {'for': ['markdown', 'markdown.pandoc']}
Plug 'lervag/vimtex', {'for': 'tex'}

Plug 'mhinz/vim-startify'

" Plug 'itchyny/lightline.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight', { 'for': ['cpp', 'c'] }

" For tmux
Plug 'tpope/vim-obsession'

" Remember cursor position
Plug 'farmergreg/vim-lastplace'

call plug#end()
