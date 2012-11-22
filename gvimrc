" Turn on indent guides automatically
IndentGuidesEnable

" Start NERDTree automatically.
autocmd VimEnter * NERDTree

call ToggleColorColumn()

" My favorite coding font
let s:uname = system("echo -n \"$(uname)\"")
if s:uname == "Darwin"
  set guifont=Inconsolata-dz\ for\ Powerline:h12
else
  set guifont=Inconsolata-dz\ for\ Powerline\ Medium\ 9
endif
set linespace=1

" Get rid of the macvim and gvim toolbars and scrollbars
set go-=T
set go-=m
set go-=l
set go-=L
set go-=r
set go-=R
set go-=b

" Don't hide the cursor
set nomousehide

" One of my plugin turns this on, and it's annoying
set noballooneval
