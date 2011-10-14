" Start NERDTree automatically.
autocmd VimEnter * NERDTree

set linespace=3

call ToggleColorColumn()

" My favorite coding font
let s:uname = system("echo -n \"$(uname)\"")
if s:uname == "Darwin"
  set guifont=Inconsolata:h14
else
  set guifont="Inconsolata 12"
endif

" Get rid of the macvim and gvim toolbars
set go-=T
set go-=m

" One of my plugin turns this on, and it's annoying
set noballooneval
