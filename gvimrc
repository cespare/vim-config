" Start NERDTree automatically.
autocmd VimEnter * NERDTree

" Different color scheme in MacVim/gvim
let g:zenburn_high_Contrast=1
colors zenburn

" Colorcolumn is the best! Also, 7.3-specific.
"set colorcolumn=110
let &colorcolumn = &wrapmargin
hi ColorColumn guibg=#4E4E4E
hi ExtraWhitespace guibg=#CCCCCC

" My favorite coding font
set guifont=DroidSansMonoSlashed:h12

" Get rid of the macvim toolbar
set go-=T
