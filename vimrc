" This is my .vimrc...I use gvim on linux, macvim on Mac OS. 7.3 required.

" Some settings are OS-dependent
let s:uname = system("echo -n \"$(uname)\"")

" ----------------------------------------- Configure Pathogen ------------------------------------------ {{{
execute pathogen#infect()

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
if exists("&ballooneval")
  set noballooneval " annoying
endif

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
set listchars=tab:\ \ ,eol:¬

" Unify vim's default register and the system clipboard
set clipboard=unnamed
if s:uname == "Linux"
  set clipboard=unnamedplus
endif

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

" Don't save other tabs in sessions (as I don't use tabs)
set sessionoptions-=tabpages
" Don't save help pages in sessions
set sessionoptions-=help
" Don't save hidden buffers -- only save the visible ones.
set sessionoptions-=buffers


" }}}
" ----------------------------- Colorscheme Settings (assume Lucius) ------------------------------------ {{{
set t_Co=256
set background=dark
colorscheme lucius
LuciusBlack

" Adjust colors as necessary
hi IncSearch       ctermfg=NONE   ctermbg=67
hi Search          ctermfg=NONE   ctermbg=22
hi Comment         ctermfg=245    cterm=NONE
hi MatchParen      ctermfg=NONE   ctermbg=237
hi Error           ctermfg=NONE   ctermbg=239
hi LineNr      ctermfg=245   ctermbg=235

" Show extra whitespace
hi ExtraWhitespace guibg=#CCCCCC
hi ExtraWhitespace ctermbg=7
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" }}}
" -------------------------------------- Plugin-specific Settings --------------------------------------- {{{
"  Powerline is installed as a top-level repo (submodule of dotfiles).
set rtp+=$HOME/scripts/powerline/powerline/bindings/vim

" Gundo settings
nnoremap <leader>gu :GundoToggle<cr>

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
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/]\.(git|hg)$',
  \ 'file': '\.log$',
  \ }

" Syntastic settings
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['ruby', 'coffee'],
                           \ }

" Insertlessly settings
" I nmap space to :
let g:insertlessly_insert_spaces = 0
" I don't like deleting newlines when leaving insert mode (and I use DeleteTrailingWhitespace to do the whole
" file).
let g:insertlessly_cleanup_trailing_ws = 0
let g:insertlessly_cleanup_all_ws = 0

" Powerline settings
let g:Powerline_symbols = 'fancy'

" easy-align settings
vnoremap <leader>a :EasyAlign<Enter>

" Scratch (github.com/matth/scratch.vim)
let g:scratch_top = 0
let g:scratch_height = 25

" Gofmt (use goimports instead)
let g:gofmt_command = "goimports"

" }}}
" ---------------------------------- Custom Commands and Functions -------------------------------------- {{{
" A function to delete all trailing whitespace from a file. (From
" http://vimcasts.org/episodes/tidying-whitespace/)
function! <SID>DeleteTrailingWhitespace()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Preview the current markdown file:
command! MarkdownDoctor !markdown_doctor % | bcat
command! Markdownd !markdownd -w % >/dev/null &

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

" }}}
" ------------------------------------------ My Mappings ------------------------------------------------ {{{
" Quickly un-highlight search terms
noremap <leader>nn :noh<cr>

" Quickly delete trailing whitespace (with cursor position restore)
nnoremap <leader>$ :call <SID>DeleteTrailingWhitespace()<cr>

" Make Y be like C and D (yank to end of line), a mapping so obvious it's recommended by :help Y
nnoremap Y y$

" Make it easier to move around through blocks of text:
noremap <C-j> gj
noremap <C-k> gk
noremap <expr> <C-h> (&scroll-2).'k'
noremap <expr> <C-l> (&scroll+2).'j'

" Close a buffer without messing with the windows (vim-bclose)
"nmap <leader>q <Plug>Kwbd
nnoremap <silent> <leader>q :Sbd<cr>

" Close the quickfix window
nnoremap <leader>x :cclose<cr>

" No colon in command mode to enter an ex command; just use space
nnoremap <Space> :

" Shortcuts for custom commands:
"noremap <leader>m :MarkdownDoctor<cr><cr>
noremap <leader>m :Markdownd<cr><cr>
noremap <leader>l :ToggleColorColumn<cr>
nnoremap <leader>nw :SelectNerdTreeWindow<cr>

" Git blame shortcut (fugitive)
noremap <leader>bl :Gblame<cr>

" Quick fold toggling
noremap <leader>f za

" Get rid of Ex mode and map a useful command for reflowing text
nnoremap Q gqap

" Suggestions from Learn Vimscript the Hard Way
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Go (vim-go) shortcuts and settings
au FileType go nmap <leader>gi <Plug>(go-info)
au FileType go nmap <leader>gd <Plug>(go-doc)
au FileType go nmap <leader>gr <Plug>(go-rename)
let g:go_fmt_command = "goimports"
" I'm using a more general mechanism for this
let g:go_highlight_trailing_whitespace_error = 0

" I usually want to evaluate the outermost s-expr in Clojure. This is often more handy than cpp (evaluate
" current expr).
nnoremap cpo :Eval<cr>

nnoremap <leader>sc :Scratch<cr>

" Ag
nnoremap <leader>a :Ag 

" }}}
" ------------------------------------ Language-specific Settings --------------------------------------- {{{
" Nice ruby settings
let ruby_space_settings = 1

" Go specific settings
augroup golang
  au!
  au FileType go setlocal noexpandtab
augroup END

" Markdown settings
augroup markdown
  au!
  au FileType markdown setlocal comments=b:*,b:-,b:+,n:>h
augroup END

" Vimscript settings
augroup filetype_vim
  au!
  au FileType vim setlocal foldmethod=marker
augroup END

" Git commit messages
augroup gitcommit
  au!
  au FileType gitcommit setlocal textwidth=72
augroup END

" Coffeescript settings (related to vim-coffee-script plugin)
vnoremap <leader>co :CoffeeCompile<cr>

" Clojure settings
let g:clojure_align_multiline_strings = 0
let g:clojure_fuzzy_indent = 1
let g:clojure_fuzzy_indent_patterns = "with.*,def.*,let.*,send.*"
let g:clojure_fuzzy_indent_patterns .= ",GET,POST,PUT,PATCH,DELETE,context"   " Compojure
let g:clojure_fuzzy_indent_patterns .= ",clone-for"                           " Enlive
let g:clojure_fuzzy_indent_patterns .= ",select,insert,update,delete,with.*"  " Korma
let g:clojure_fuzzy_indent_patterns .= ",fact,facts"                          " Midje
let g:clojure_fuzzy_indent_patterns .= ",up,down"                             " Lobos
let g:clojure_fuzzy_indent_patterns .= ",entity"                              " Custom
let g:clojure_fuzzy_indent_patterns .= ",check"                               " Custom

" Nimrod settings
fun! JumpToDef()
  if exists("*GotoDefinition_" . &filetype)
    call GotoDefinition_{&filetype}()
  else
    exe "norm! \<C-]>"
  endif
endf
nn <M-g> :call JumpToDef()<cr>
ino <M-g> <esc>:call JumpToDef()<cr>i
