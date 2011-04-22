" Start NERDTree automatically.
autocmd VimEnter * NERDTree

colors lucius

" Further color adjustments
hi ColorColumn guibg=#444444
hi ExtraWhitespace guibg=#CCCCCC

call ToggleColorColumn()

" My favorite coding font
set guifont=DroidSansMonoSlashed:h12

" Get rid of the macvim toolbar
set go-=T
