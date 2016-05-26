" Start NERDTree automatically.
autocmd VimEnter * NERDTree

call ToggleColorColumn()

" My favorite coding font
let s:uname = system("echo -n \"$(uname)\"")
if s:uname == "Darwin"
  set guifont=Inconsolata-dz\ for\ Powerline:h12
  set lines=70 columns=180
else
  set guifont=Inconsolata-dz\ for\ Powerline\ Medium\ 9
  set lines=97 columns=200
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

augroup visual_bell_sucks
  au!
  au GUIEnter * set t_vb=
augroup END
