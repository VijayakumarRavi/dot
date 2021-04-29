" Spell checking
set spell spelllang=en_us

" Does not highlight conceal
highlight Conceal ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE

" VimTex specific settings
set conceallevel=1
let g:tex_conceal='abdmg'

" Auto complete for $ in pandoc markdown
let b:AutoPairs = extend({'$': '$'}, g:AutoPairs, 'keep')
let java_ignore_javadoc=1
