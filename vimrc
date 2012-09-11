" This is my .vimrc...I use gvim on linux, macvim on Mac OS. 7.3 required.

" ----------------------------------------- Configure Pathogen ------------------------------------------ {{{
call pathogen#infect()

" }}}
" ----------------------------------------- Basic Settings ---------------------------------------------- {{{
syntax on
filetype plugin indent on

" Text-wrapping stuff. (Also check out my cursorcolumn setting in .gvimrc.)
set textwidth=110 " 80-width lines is for 1995
let &wrapmargin= &textwidth
set formatoptions=croql " Now it shouldn't hard-wrap long lines as you're typing (annoying), but you can gq
                        " as expected.

set hidden "This allows vim to put buffers in the bg without saving, and then allows undoes when you fg them.
set history=1000 "Longer history
set number
set hlsearch
set autoindent
set wildmenu
set wildmode=list:longest
set scrolloff=3 " This keeps three lines of context when scrolling
set expandtab
set smarttab
set ts=2
set sw=2
set sts=2
set laststatus=2
set ignorecase
set smartcase
set undofile
set backspace=indent,eol,start
set incsearch
set nojoinspaces

" When completing, don't automatically select the first choice, but instead just insert the longest common
" text.
set completeopt=menu,longest

" See stuff in .vim/after/plugins/endwise.vim for some more completion settings that necessarily must be
" loaded after endwise. (https://github.com/tpope/vim-endwise/pull/16)
" TODO: Get around this; it's better to have all configuration in this file or in plugins directly.

" Leaving foldmethod=syntax on all the time causes horrible slowdowns for some syntaxes in gvim.
set foldmethod=manual
set foldlevel=99
" TODO(caleb): Investigate and implement a workaround such as those listed here:
" http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text

" Allow for modelines
set modeline

let mapleader = ","

" Bells == annoying
set vb
set t_vb=
if has("autocmd") && has("gui")
  au GUIEnter * set t_vb=
endif

" For some reason I accidentally hit this shortcut all the time...let's disable it. (I usually don't look at
" man pages from within vim anyway.)
noremap K <Nop>

" Textmate-style invisible char markers
set list
set listchars=tab:▸\ ,eol:¬

" Macvim default clipboard interaction is bullshit
set clipboard=unnamed

" Ensure the temp dirs exist
if !isdirectory($HOME . "/.vim/tmp")
  call system("mkdir -p ~/.vim/tmp/swap")
  call system("mkdir -p ~/.vim/tmp/backup")
  call system("mkdir -p ~/.vim/tmp/undo")
endif

" Change where we store swap/undo files
set dir=~/.vim/tmp/swap//
set backupdir=~/.vim/tmp/backup//
set undodir=~/.vim/tmp/undo/

" Don't back up temp files
set backupskip=/tmp/*,/private/tmp/*

" }}}
" ----------------------------- Colorscheme Settings (assume Lucius) ------------------------------------ {{{
set t_Co=256
set background=dark
colorscheme lucius

" Adjust colors as necessary
hi ColorColumn     guibg=#444444
hi ColorColumn     ctermbg=8
hi IncSearch       guifg=NONE     guibg=#353E44
hi IncSearch       ctermfg=NONE   ctermbg=67
hi Search          guifg=NONE     guibg=#545449
hi Search          ctermfg=NONE   ctermbg=22
hi Comment         guifg=#999999  gui=NONE
hi Comment         ctermfg=245    cterm=NONE

" Show extra whitespace
hi ExtraWhitespace guibg=#CCCCCC
hi ExtraWhitespace ctermbg=7
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Unset the background color on Linux because it doesn't play nicely with Terminator
let s:uname = system("echo -n \"$(uname)\"")
if s:uname == "Linux"
  hi Normal ctermbg=NONE
endif

" }}}
" -------------------------------------- Plugin-specific Settings --------------------------------------- {{{
" Gundo settings
nnoremap <leader>g :GundoToggle<cr>

" NERDTree settings
let g:NERDTreeChDirMode=2
let g:NERDChristmasTree=1
nnoremap <leader>t :NERDTreeToggle<cr><C-w>=
nnoremap <leader>nf :NERDTreeFind<cr>

" Stupid NERDCommenter warning
let NERDShutUp=1

" CtrlP Settings
" Disable default mapping
let g:ctrlp_map = ''
" Going to use <leader>d* commands to launch ctrlp.
" No good mnemonic, but it's very quick to type and unused.
nnoremap <leader>dp :CtrlP<cr>
nnoremap <leader>db :CtrlPBuffer<cr>
nnoremap <leader>dm :CtrlPMRU<cr>
" Consider a Gemfile in addition to the other project root indicators
let g:ctrlp_root_markers = ['Gemfile']
" Start CtrlP in the project root (containing .git, etc)
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = {
  \ 'dir': '\.git$',
  \ 'file': '\.log$',
  \ }

" Syntastic settings
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['ruby', 'coffee'],
                           \ }

" Insertlessly settings
let g:insertlessly_insert_spaces = 0 " I nmap space to :

" }}}
" ---------------------------------------- Custom Commands ---------------------------------------------- {{{
" A command to delete all trailing whitespace from a file.
command! DeleteTrailingWhitespace %s:\(\S*\)\s\+$:\1:

" Preview the current markdown file:
command! MarkdownDoctor !markdown_doctor % | bcat

" Toggle colorcolumn
function! ToggleColorColumn()
  if &colorcolumn == 0
    " Draw the color column wherever wrapmargin is set
    let &colorcolumn = &wrapmargin
  else
    let &colorcolumn = 0
  endif
endfunction
command! ToggleColorColumn call ToggleColorColumn()

" Quickly select the NERDTree window
command! SelectNerdTreeWindow execute "normal " . bufwinnr("NERD_tree_1") . "\<C-w>w"

" Use gofmt to format go code
function Goformat()
  let regel=line(".")
  %!gofmt
  call cursor(regel, 1)
endfunction
autocmd Filetype go command! Fmt call Goformat()

" }}}
" ------------------------------------------ My Mappings ------------------------------------------------ {{{
" Mappings:
noremap <F6> :b#<cr>
noremap <leader>nn :noh<cr>

" Make it easier to move around through blocks of text:
noremap <C-j> gj
noremap <C-k> gk
noremap U 30k
noremap D 30j

" Close a buffer without messing with the windows (vim-bclose)
"nmap <leader>q <Plug>Kwbd
nnoremap <silent> <leader>q :Sbd<cr>

" Hashrocket
inoremap <C-l> <Space>=><Space>

" No colon in command mode to enter an ex command; just use space
nnoremap <Space> :

" Shortcuts for custom commands:
noremap <leader>m :MarkdownDoctor<cr><cr>
noremap <leader>l :ToggleColorColumn<cr>
nnoremap <leader>nw :SelectNerdTreeWindow<cr>

" Git blame shortcut (fugitive)
noremap <leader>bl :Gblame<cr>

" Quick fold toggling
noremap <leader>f za

" Get rid of Ex mode and map a useful command for reflowing text
nnoremap Q gqap

" Suggestions from Learn Vimscript the Hard Way
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" Format Go code
:nnoremap <leader>nf :Fmt<cr>

" }}}
" ------------------------------------ Language-specific Settings --------------------------------------- {{{
" Nice ruby settings
let ruby_space_settings = 1

" Go specific settings
augroup golang
  au!
  au FileType go set noexpandtab
  au FileType go set listchars=tab:\ \ ,eol:¬
augroup END

" Markdown settings
augroup markdown
  au!
  au FileType markdown set comments=b:*,b:-,b:+,n:>h
augroup END

" Vimscript settings
augroup filetype_vim
  au!
  au FileType vim setlocal foldmethod=marker
augroup END

" Coffeescript settings (related to vim-coffee-script plugin)
vnoremap <leader>co :CoffeeCompile<cr>
