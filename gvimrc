" Start NERDTree automatically.
autocmd VimEnter * NERDTree

" Different color scheme in MacVim/gvim
let g:zenburn_high_Contrast=1
colors zenburn
" See the theme-tweaks plugin for changes I've made to my theme

" Draw the color column wherever wrapmargin is set
let &colorcolumn = &wrapmargin

" My favorite coding font
set guifont=DroidSansMonoSlashed:h12

" Get rid of the macvim toolbar
set go-=T
