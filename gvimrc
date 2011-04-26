" Start NERDTree automatically.
autocmd VimEnter * NERDTree

call ToggleColorColumn()

" My favorite coding font
let s:uname = system("echo -n \"$(uname)\"")
if s:uname == "Darwin"
  set guifont=Droid\ Sans\ Mono\ Slashed:h12
else
  set guifont="Droid Sans Mono Slashed 10"
endif

" Get rid of the macvim toolbar
set go-=T
