" Start NERDTree automatically.
autocmd VimEnter * NERDTree

set linespace=3 

call ToggleColorColumn()

" My favorite coding font
let s:uname = system("echo -n \"$(uname)\"")
if s:uname == "Darwin"
  set guifont=Droid\ Sans\ Mono\ Slashed:h12
else
  set guifont="Droid Sans Mono Slashed 10"
endif

" Get rid of the macvim and gvim toolbars
set go-=T
set go-=m

