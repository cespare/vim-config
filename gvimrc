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

" Different Lucius variant
LuciusBlack

" Color adjustments
hi Normal                         guibg=#191919
hi IncSearch       guifg=NONE     guibg=#353E44
hi Search          guifg=NONE     guibg=#545449
hi Comment         guifg=#999999  gui=NONE
hi MatchParen      guifg=NONE     guibg=#2c5475
hi Error           guifg=NONE     guibg=#4e4e4e
hi LineNr          guifg=#8a8a8a  guibg=#404040
