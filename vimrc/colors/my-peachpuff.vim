hi clear
if exists("syntax_on")
    syntax reset
endif

" Load the base color scheme
runtime colors/peachpuff.vim

" Overload the colorscheme name
let g:colors_name = "my-peachpuff"

" Setup my own colors
hi Folded       guibg=grey30 guifg=gold ctermfg=darkgrey ctermbg=none
hi FoldColumn   guibg=grey30 guifg=tan ctermfg=darkgrey ctermbg=none
hi Search       cterm=reverse ctermbg=none

