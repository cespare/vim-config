" Start NERDTree automatically.
autocmd VimEnter * NERDTree

" Different color scheme in MacVim/gvim
let g:zenburn_high_Contrast=1
colors zenburn

" Adjust zenburn's garish search/visual colors.
hi IncSearch guifg=NONE guibg=#545449
hi Search    guifg=NONE guibg=#545449
hi Visual    guifg=NONE guibg=#444444
hi VisualNOS guifg=NONE guibg=#444444

" Further color adjustments
hi ColorColumn guibg=#444444
hi ExtraWhitespace guibg=#CCCCCC

call ToggleColorColumn()

" My favorite coding font
set guifont=DroidSansMonoSlashed:h12

" Get rid of the macvim toolbar
set go-=T
