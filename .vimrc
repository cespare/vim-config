" This is my .vimrc...I use gvim on linux, macvim on Mac OS. 7.3 required.
" Note that there's no particular ordering here (except pathogen stuff comes first).

" Pathogen == teh awesomes.
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

syntax on
filetype plugin indent on

" Text-wrapping stuff. (Also check out my cursorcolumn setting in .gvimrc.)
set textwidth=110 " 80-width lines is for 1995
let &wrapmargin= &textwidth
set formatoptions=croql " Now it shouldn't hard-wrap long lines as you're typing (annoying), but you can gq
                        " as expected.

set hidden "This allows vim to put buffers in the bg without saving, and then allows undoes when you fg them again.
set history=1000 "Longer history
set number
set hlsearch
set autoindent
set smartindent
set expandtab
set wildmenu
set wildmode=list:longest
set scrolloff=3 " This keeps three lines of context when scrolling
set title
set expandtab
set smarttab
set ts=2
set sw=2
set sts=2
set laststatus=2
set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%c\",getftime(expand(\"%:p\")))}%=\ lin:%l\,%L\ col:%c%V\ pos:%o\ ascii:%b\ %P
set ignorecase
set smartcase
set undofile
set backspace=indent,eol,start
set linespace=3

let mapleader = ","

" Mappings:
map <F6> :b#<CR>
map <C-n> :noh<CR>
map <C-Space> <C-x><C-o>

" Taglist stuff
nmap ,tu :!(ctags *.[ch])&<CR><CR>
map ,tl :TlistToggle<CR>
let Tlist_Exit_OnlyWindow = 1

" Colorscheme bullshittery:
set t_Co=16
set background=dark
colors zenburn

" latex build + evince ps view
nmap ,tex :!(texbuildps.py %)<CR><CR>

" Gundo settings
nnoremap <F5> :GundoToggle<CR>

" NERDTree settings
let g:NERDTreeChDirMode=2
let g:NERDChristmasTree=1

" Stupid NERDCommenter warning
let NERDShutUp=1

" Make it easier to move around through blocks of text:
noremap <C-J> gj
noremap <C-k> gk
noremap U 30k
noremap D 30j

" Ack >> grep
nnoremap <leader>a :Ack

" Audio bell == annoying
set vb t_vb=

" Show extra whitespace
highlight ExtraWhitespace ctermbg=green guibg=green
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" A command to delete all trailing whitespace from a file.
command DeleteTrailingWhitespace %s:\(\S*\)\s\+$:\1:

" For some reason I accidentally hit this shortcut all the time...let's disable it. (I usually don't look at
" man pages from within vim anyway.)
:map K <Nop>

" TODO: move all the language-specific settings to ftplugins

" Nice ruby settings
let ruby_space_settings = 1

" Go specific settings
augroup golang
  au!
  au FileType go set noexpandtab
augroup END

" Markdown settings
augroup markdown
  au!
  au FileType markdown set comments=b:*,b:-,b:+,n:>h
augroup END

" Better buffer close functionality =======================
nmap ,fc :call CleanClose(1)<CR>
nmap ,fq :call CleanClose(0)<CR>

function! CleanClose(tosave)
  if (a:tosave == 1)
    w!
  endif
let todelbufNr = bufnr("%")
let newbufNr = bufnr("#")
if ((newbufNr != -1) && (newbufNr != todelbufNr) && buflisted(newbufNr))
    exe "b".newbufNr
else
    bnext
endif

if (bufnr("%") == todelbufNr)
    new
endif
exe "bd".todelbufNr
endfunction
" ===================================================
