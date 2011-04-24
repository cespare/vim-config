" Start NERDTree automatically.
autocmd VimEnter * NERDTree

" Further color adjustments
hi ColorColumn guibg=#444444
hi ExtraWhitespace guibg=#CCCCCC

call ToggleColorColumn()

" My favorite coding font
let s:uname = system("uname")
if s:uname == "Darwin"
  set guifont=DroidSansMonoSlashed:h12
else
  set guifont="Droid Sans Mono Slashed 10"
endif

" Get rid of the macvim toolbar
set go-=T
