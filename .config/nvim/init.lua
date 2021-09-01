-- neovim config
-- github.com/ojroques

vim.g.mapleader = ' '
-------------------- HELPERS -------------------------------
local api, cmd, fn, g = vim.api, vim.cmd, vim.fn, vim.g
local opt, wo, op = vim.opt, vim.wo, vim.o
local fmt = string.format

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

-------------------- PLUGINS -------------------------------

local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

cmd 'packadd paq-nvim'
local paq = require('paq-nvim').paq
paq {'savq/paq-nvim', opt = true}                             -- Neovim package manager written in Lua.
paq {'airblade/vim-rooter'}                                   -- Changes the working directory to the project root when you open a file or directory.
paq {'joshdick/onedark.vim'}                                  -- A dark Vim/Neovim color scheme.
paq {'lewis6991/gitsigns.nvim'}                               -- Git decorations implemented purely in lua/teal.
paq {'lukas-reineke/indent-blankline.nvim'}                   -- This plugin adds indentation guides to all lines (including empty lines).

paq {'ojroques/nvim-bufbar'}                                  -- A simple and very light bufferline for Neovim written in Lua.
paq {'ojroques/nvim-bufdel'}                                  -- A very small Neovim plugin to improve the deletion of buffers.
paq {'ojroques/nvim-buildme'}                                 -- A Neovim plugin to build or run a project using the built-in terminal.
paq {'ojroques/nvim-hardline'}                                -- A statusline / bufferline for Neovim written in Lua.
paq {'ojroques/vim-oscyank'}                                  -- A Vim / Neovim plugin to copy text to the system clipboard from anywhere using the ANSI OSC52 sequence.
paq {'ojroques/nvim-lspfuzzy'}

paq {'tpope/vim-fugitive'}                                    -- A Git wrapper.
paq {'tpope/vim-unimpaired'}                                  -- This plugin provides several pairs of bracket maps. Reff -- https://github.com/tpope/vim-unimpaired/blob/master/doc/unimpaired.txt 
paq {'nvim-telescope/telescope.nvim'}                         -- Its a highly extendable fuzzy finder over lists.
paq {'nvim-lua/plenary.nvim'}                                 -- A Lua module for asynchronous programming using coroutines {Telescope dependency}.
paq {'kyazdani42/nvim-web-devicons'}                          -- Icons for Telescope.
paq {'junegunn/fzf'}                                          -- Fzf is a general-purpose command-line fuzzy finder.
paq {'junegunn/fzf.vim'}                                      -- Fzf vim version.
paq {'justinmk/vim-dirvish'}                                  -- Path navigator designed to work with Vim's built-in mechanisms and complementary plugins.
paq {'christoomey/vim-tmux-navigator'}                        -- For Tmux pane switching.

paq {'neovim/nvim-lspconfig'}                                 -- Lsp Client for nvim.
paq {'hrsh7th/nvim-compe'}                                    -- Auto completion plugin for nvim.
paq {'kabouzeid/nvim-lspinstall'}                             -- Automatic lsp Install.
paq {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}    -- Tree-sitter is a parser generator tool and an incremental parsing library.
paq {'nvim-treesitter/nvim-treesitter-textobjects'}           -- Create your own textobjects using tree-sitter queries.

-------------------- PLUGIN SETUP --------------------------
-- fzf & fzf.vim
g['fzf_action'] = {['ctrl-s'] = 'split', ['ctrl-v'] = 'vsplit'}
map('n', '<leader>/', '<cmd>BLines<CR>')
map('n', '<leader>f', '<cmd>Files<CR>')
map('n', '<leader>;', '<cmd>History:<CR>')
map('n', '<leader>r', '<cmd>Rg<CR>')
map('n', 's', '<cmd>Buffers<CR>')

-- gitsigns.nvim
require('gitsigns').setup {
  signs = {
    add = {text = '+'},
    change = {text = '~'},
    delete = {text = '-'}, topdelete = {text = '-'}, changedelete = {text = '≃'},
  },
}

-- indent-blankline.nvim
g['indent_blankline_char'] = '┊'
g['indent_blankline_buftype_exclude'] = {'terminal'}
g['indent_blankline_filetype_exclude'] = {'fugitive', 'fzf', 'help', 'man'}

-- nvim-bufbar
require('bufbar').setup {show_bufname = 'visible', show_tabs = true, show_flags = true}

-- nvim-bufdel
require('bufdel').setup {next = 'alternate', quit = false}
map('n', '<leader>w', '<cmd>BufDel<CR>')

-- nvim-buildme
map('n', 'bb', '<cmd>BuildMe<CR>')
map('n', '<leader>be', '<cmd>BuildMeEdit<CR>')
map('n', '<leader>bs', '<cmd>BuildMeStop<CR>')

-- nvim-hardline
require('hardline').setup {}

-- nvim-lspfuzzy
require('lspfuzzy').setup {}

-- vim-dirvish
g['dirvish_mode'] = [[:sort ,^.*[\/],]]
map('', '<leader>d', ':Shdo ')

-- vim-fugitive & git
local log = [[\%C(yellow)\%h\%Cred\%d \%Creset\%s \%Cgreen(\%ar) \%Cblue\%an\%Creset]]
map('n', '<leader>g<space>', ':Git ')
map('n', '<leader>gd', '<cmd>Gvdiffsplit<CR>')
map('n', '<leader>gg', '<cmd>Git<CR>')
map('n', '<leader>gl', fmt('<cmd>term git log --graph --all --format="%s"<CR><cmd>start<CR>', log))

-------------------- OPTIONS -------------------------------
local indent, width = 4, 180
opt.colorcolumn = tostring(width)   -- Line length marker
opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options
opt.cursorline = true               -- Highlight cursor line
opt.expandtab = true                -- Use spaces instead of tabs
opt.formatoptions = 'crqnj'         -- Automatic formatting options
opt.ignorecase = true               -- Ignore case
opt.inccommand = ''                 -- Disable substitution preview
opt.list = true                     -- Show some invisible characters
opt.number = true                   -- Show line numbers
opt.pastetoggle = '<F2>'            -- Paste mode
opt.pumheight = 12                  -- Max height of popup menu
opt.relativenumber = true           -- Relative line numbers
opt.scrolloff = 4                   -- Lines of context
opt.shiftround = true               -- Round indent
opt.shiftwidth = indent             -- Size of an indent
opt.shortmess = 'atToOFc'           -- Prompt message options
opt.sidescrolloff = 8               -- Columns of context
opt.signcolumn = 'yes'              -- Show sign column
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.tabstop = indent                -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
opt.textwidth = width               -- Maximum width of text
opt.updatetime = 100                -- Delay before swap file is saved
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.wrap = false                    -- Disable line wrap
opt.undofile = true                 -- Enable undo after reopening
opt.undodir = '/tmp'                -- Location to save the undo file
opt.spelllang='en'                    -- Spell cleck languages
cmd 'colorscheme onedark'
cmd 'set nohlsearch'
--cmd 'set mouse=a'

-------------------- MAPPINGS ------------------------------
map('', 'y', '"+y')
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
map('i', 'jj', '<ESC>')
map('n', '<C-w>T', '<cmd>tabclose<CR>')
map('n', '<C-w>m', '<cmd>lua toggle_zoom()<CR>')
map('n', '<C-w>t', '<cmd>tabnew<CR>')
map('n', '<F3>', ':lua toggle_wrap()<CR>')
map('n', '<F4>', ':set scrollbind!<CR>')
map('n', '<F5>', ':checktime<CR>')
map('n', '<S-Down>', '<C-w>2<')
map('n', '<S-Left>', '<C-w>2-')
map('n', '<S-Right>', '<C-w>2+')
map('n', '<S-Up>', '<C-w>2>')
map('n', '<leader>s', ':%s//gcI<Left><Left><Left><Left>')
map('n', '<leader>t', '<cmd>:split term://bash<CR>')
map('n', '<leader>u', '<cmd>update<CR>')
map('n', '<leader>x', '<cmd>conf qa<CR>')
map('n', 'Q', '<cmd>lua warn_caps()<CR>')
map('n', 'U', '<cmd>lua warn_caps()<CR>')
map('t', '<ESC>', '&filetype == "fzf" ? "\\<ESC>" : "\\<C-\\>\\<C-n>"' , {expr = true})
map('t', 'jj', '<ESC>', {noremap = false})
map('v', '<leader>s', ':s//gcI<Left><Left><Left><Left>')

-------------------- LSP -----------------------------------
require('lspinstall').setup() -- important

local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    require'lspconfig'[server].setup{}
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

map('i', '<A-,>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('i', '<A-;>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('i', '<A-a>', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('i', '<A-d>', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('i', '<A-f>', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('i', '<A-h>', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('i', '<A-m>', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('i', '<A-r>', '<cmd>lua vim.lsp.buf.references()<CR>')
map('i', '<A-s>', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')



-------------------- Compe Setup ---------------------------
require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    Spell = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}

-------------------- TREE-SITTER ---------------------------
require('nvim-treesitter.configs').setup {
  ensure_installed = 'all',
  highlight = {enable = true},
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['aa'] = '@parameter.outer', ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer', ['if'] = '@function.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {['<leader>a'] = '@parameter.inner'},
      swap_previous = {['<leader>A'] = '@parameter.inner'},
    },
    move = {
      enable = true,
      goto_next_start = {[']a'] = '@parameter.outer', [']f'] = '@function.outer'},
      goto_next_end = {[']A'] = '@parameter.outer', [']F'] = '@function.outer'},
      goto_previous_start = {['[a'] = '@parameter.outer', ['[f'] = '@function.outer'},
      goto_previous_end = {['[A'] = '@parameter.outer', ['[F'] = '@function.outer'},
    },
  },
}

-------------------- COMMANDS ------------------------------
function init_term()
  cmd 'setlocal nonumber norelativenumber'
  cmd 'setlocal nospell'
  cmd 'setlocal signcolumn=auto'
end

function toggle_wrap()
  wo.breakindent = not wo.breakindent
  wo.linebreak = not wo.linebreak
  wo.wrap = not wo.wrap
end

function toggle_zoom()
  if zoomed then
    cmd 'wincmd ='
    zoomed = false
  else
    cmd 'resize | vertical resize'
    zoomed = true
  end
end

function warn_caps()
  cmd 'echohl WarningMsg'
  cmd 'echo "Caps Lock may be on"'
  cmd 'echohl None'
end

vim.tbl_map(function(c) cmd(fmt('autocmd %s', c)) end, {
  'TermOpen * lua init_term()',
  'TextYankPost * lua vim.highlight.on_yank {timeout = 200, on_visual = false}',
  'TextYankPost * if v:event.operator is "y" && v:event.regname is "+" | OSCYankReg + | endif',
})

------ My Custom Testing lua part ------

------ Remember cursor position --------
cmd ([[
" Go to the last cursor location when a file is opened, unless this is a
" git commit (in which case it's annoying)
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" | execute("normal `\"") | endif
]])

------ commenting_blocks_of_code -------
cmd ([[
augroup commenting_blocks_of_code
  autocmd!
  autocmd FileType c,cpp,java,scala let b:comment_leader = '//  '
  autocmd FileType bash,ruby,python   let b:comment_leader = '#  '
  autocmd FileType conf,fstab,sh    let b:comment_leader = '#  '
  autocmd FileType tex              let b:comment_leader = '%  '
  autocmd FileType mail             let b:comment_leader = '>  '
  autocmd FileType vim              let b:comment_leader = '"  '
  autocmd FileType lua              let b:comment_leader = '--  '

augroup END
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
]])

----- Moving Block of code ----
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

------ Telescope ----
map('n', '<leader>f', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden',  '-g', '!.git' }})<cr>", default_opts)
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
map('n', '<leader>g', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>b', '<cmd>Telescope buffers<cr>')
map('n', '<leader>h', '<cmd>Telescope help_tags<cr>')

local actions = require "telescope.actions"

require("telescope").setup {
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case", -- this is default
      hidden = true
    },
  },
  defaults = {
    vimgrep_arguments = { "rg", "--no-heading", "--hidden" },
    prompt_prefix = "❯ ",
    selection_caret = "❯ ",
    sorting_strategy = "ascending",
    color_devicons = true,
    layout_config = {
      prompt_position = "top",
      horizontal = {
        width_padding = 0.04,
        height_padding = 0.1,
        preview_width = 0.6,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.5,
      },
    },
    mappings = { i = { ["<Del>"] = actions.close } },
  },
}


----- Esc & Closing actions -----
map('i', '<F1>', '<Esc>')
map('i', '<C-c>', '<Esc>')
map('n', '<C-c>', ':wq<CR>')
map('n', '<C-z>', ':wa<CR>')
map('n', '<leader> ', ':so %<CR>')


