" Turn on indent guides automatically
IndentGuidesEnable

" Start NERDTree automatically.
autocmd VimEnter * NERDTree

call ToggleColorColumn()

" My favorite coding font
let s:uname = system("echo -n \"$(uname)\"")
if s:uname == "Darwin"
  set guifont=Inconsolata:h14
  set linespace=3
else
  set guifont=Inconsolata-dz\ 9
  set linespace=1
endif

" Get rid of the macvim and gvim toolbars
set go-=T
set go-=m

" Don't hide the cursor
set nomousehide

" One of my plugin turns this on, and it's annoying
set noballooneval
