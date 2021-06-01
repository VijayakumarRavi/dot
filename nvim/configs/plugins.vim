if ! filereadable(system('echo -n "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/vim/plugged')
Plug 'cocopon/iceberg.vim'
Plug 'arzg/vim-substrata'
Plug 'arcticicestudio/nord-vim'
Plug 'sainnhe/everforest'

Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'dhruvasagar/vim-table-mode', { 'for': ['markdown', 'markdown.pandoc'] }

Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'

Plug 'junegunn/goyo.vim'

Plug 'voldikss/vim-floaterm'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" to view csv files
Plug 'chrisbra/csv.vim'

Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

Plug 'sheerun/vim-polyglot'
Plug 'vim-pandoc/vim-pandoc-syntax', {'for': ['markdown', 'markdown.pandoc']}
Plug 'lervag/vimtex', {'for': 'tex'}

" Nice Start window
Plug 'mhinz/vim-startify'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight', { 'for': ['cpp', 'c'] }

" For tmux
Plug 'tpope/vim-obsession'

" Remember cursor position
Plug 'farmergreg/vim-lastplace'

call plug#end()
