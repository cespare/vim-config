" Some settings are OS-dependent
let s:uname = system("echo -n \"$(uname)\"")

" }}}
" ----------------------------------------- Basic Settings ---------------------------------------------- {{{
syntax on
filetype plugin indent on

" Text-wrapping stuff. (Also check out my cursorcolumn setting in .gvimrc.)
set textwidth=80
let &wrapmargin= &textwidth
" Don't hard-wrap long lines as you're typing (annoying), but allow gq to work.
set formatoptions=croql

set hidden
set history=1000
set number
set hlsearch
set autoindent
set wildmenu
set wildmode=list:longest
set scrolloff=3 " This keeps three lines of context when scrolling.
set autoread    " Reload changed files when focus returns.
au FocusGained * :checktime " Make autoread work with neovim/vimr
set expandtab
set smarttab
set ts=2
set sw=2
set sts=-1
set laststatus=2
set ignorecase
set smartcase
set undofile
set backspace=indent,eol,start
set incsearch
set nojoinspaces
set splitright
set nospell " turn this on as required
if exists("&ballooneval")
  set noballooneval " annoying
endif
set noshowcmd
" Govim recommendations
set updatetime=500
set balloondelay=250

" When completing, don't automatically select the first choice, but instead just
" insert the longest common text.
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

" For some reason I accidentally hit this shortcut all the time...let's disable it. (I usually don't look at
" man pages from within vim anyway.)
noremap K <Nop>

" Disable ctrl-a; I press this accidentally because of tmux all the time.
noremap <C-a> <Nop>

" Unify vim's default register and the system clipboard
set clipboard=unnamed
if s:uname == "Linux"
  set clipboard=unnamedplus
endif

" Ensure the temp dirs exist
if !isdirectory($HOME . "/.vim/tmp")
  call system("mkdir -p ~/.vim/tmp/swap")
  call system("mkdir -p ~/.vim/tmp/undo")
endif

" Change where we store swap/undo files.
set dir=~/.vim/tmp/swap//
set undodir=~/.vim/tmp/undo/

" Don't save backup files. That's what git is for.
set nobackup
set nowritebackup

" Don't save other tabs in sessions (as I don't use tabs)
set sessionoptions-=tabpages
" Don't save help pages in sessions
set sessionoptions-=help
" Don't save hidden buffers -- only save the visible ones.
set sessionoptions-=buffers

" Viminfo saves/restores editing metadata in ~/.viminfo.
" '100   Save marks for the last 100 edited files
" f1     Store global marks
" <500   Save max of 500 lines of each register
" :100   Save 100 lines of command-line history
" /100   Save 100 searches
" h      Disable hlsearch when starting
set viminfo='1000,f1,<500,:100,/100,h

" Restore position when reopening a file.
augroup restore_position
  au!
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" }}}
" ----------------------------- Colorscheme Settings ---------------------------------------------------- {{{
set t_Co=256
colorscheme cespare

" Show extra whitespace
hi ExtraWhitespace guibg=#CCCCCC
hi ExtraWhitespace ctermbg=7
match ExtraWhitespace /\s\+$/
augroup highlight_whitespace
  au!
  au BufWinEnter * match ExtraWhitespace /\s\+$/
  au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  au InsertLeave * match ExtraWhitespace /\s\+$/
  au BufWinLeave * call clearmatches()
augroup END

" }}}
" -------------------------------------- Plugin-specific Settings --------------------------------------- {{{

" Gundo settings
let g:gundo_prefer_python3 = 1
nnoremap <leader>gu :GundoToggle<cr>

" fzf
nnoremap ; :Buffers<CR>
nnoremap <leader>d :Files<CR>

" ag (via ack.vim):
let g:ackprg = 'ag --vimgrep'
nnoremap <leader>a :Ack! 

" Insertlessly settings
" I nmap space to :
let g:insertlessly_insert_spaces = 0
" I don't like deleting newlines when leaving insert mode (and I use DeleteTrailingWhitespace to do the whole
" file).
let g:insertlessly_cleanup_trailing_ws = 0
let g:insertlessly_cleanup_all_ws = 0

" easy-align settings
vnoremap <leader>a :EasyAlign<Enter>

" Scratch (github.com/matth/scratch.vim)
let g:scratch_top = 0
let g:scratch_height = 25

" Airline
let g:airline_theme = 'minimalist'
let g:airline_section_z='%3p%% • %l/%L • %v'
let g:airline_section_error = ''
let g:airline_section_warning = ''
let g:airline#extensions#wordcount#enabled = 0

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

" Toggle width between 80 and 110.
function! ToggleWidth()
  if &textwidth == 80
    set textwidth=110
  else
    set textwidth=80
  endif
  let &wrapmargin = &textwidth
  if &colorcolumn > 0
    let &colorcolumn = &wrapmargin
  endif
endfunction
command! ToggleWidth call ToggleWidth()

" Show the current highlight group underneath the cursor:
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" After running a command which alters the quickfix window, this function is
" useful for opening the window (if it's non-empty) and focus the first result.
function! FocusQuickfix()
  cwindow
  if len(getqflist()) > 0
    cfirst
  endif
endfunction
command! FocusQuickfix call FocusQuickfix()

" }}}
" ------------------------------------------ My Mappings ------------------------------------------------ {{{
" Quickly un-highlight search terms
noremap <leader>nn :noh<cr>

" Quickly delete trailing whitespace (with cursor position restore)
nnoremap <leader>$ :call <SID>DeleteTrailingWhitespace()<cr>

" Make Y be like C and D (yank to end of line), a mapping so obvious it's recommended by :help Y
nnoremap Y y$

" Shortcuts for creating splits
nnoremap <leader>h :split<cr>
nnoremap <leader>v :vsplit<cr>

" Make it easier to move around through blocks of text:
noremap <C-j> gj
noremap <C-k> gk
noremap <expr> <C-h> (&scroll-2).'k'
noremap <expr> <C-l> (&scroll+2).'j'

" Close a buffer without messing with the windows.
nnoremap <silent> <leader>q :bp\|bd #<CR>

" No colon in command mode to enter an ex command; just use space
nnoremap <Space> :

" Shortcuts for using the quickfix window (partly copied from unimpaired):
nnoremap ]q :cnext<cr>
nnoremap [q :cprevious<cr>
nnoremap [Q :cfirst<cr>
nnoremap ]Q :clast<cr>
nnoremap <leader>x :cclose<cr>

" Shortcuts for custom commands:
noremap <leader>m :Markdownd<cr><cr>
noremap <leader>l :ToggleColorColumn<cr>
noremap <leader>8 :ToggleWidth<cr>

" Git blame shortcut (fugitive)
noremap <leader>bl :Gblame<cr>
" Open GitHub page in browser (fugitive/rhubarb)
noremap <leader>bb :Gbrowse<cr>

" Quick fold toggling
noremap <leader>f za

" Get rid of Ex mode and map a useful command for reflowing text
nnoremap Q gqap

" Suggestions from Learn Vimscript the Hard Way
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Go shortcuts
nnoremap <leader>gi : <C-u>call GOVIMHover()<CR>
nnoremap <leader>gr :GOVIMRename<CR>
nnoremap <leader>gd :GOVIMQuickfixDiagnostics<CR> :FocusQuickfix<CR>

" TODO:
" nnoremap <leader>gb <Plug>(go-build)
" nnoremap <leader>gt <Plug>(go-test)
" nnoremap <leader>gf <Plug>(go-test-func)
" nnoremap <leader>gc <Plug>(go-coverage-toggle)

" I usually want to evaluate the outermost s-expr in Clojure. This is often more handy than cpp (evaluate
" current expr).
nnoremap cpo :Eval<cr>

" Quickly 'go run' the current file. Good for little scratch programs.
nnoremap <leader>gg :!go run %<cr>

" }}}
" ------------------------------------ Language-specific Settings --------------------------------------- {{{
" Nice ruby settings
let ruby_space_settings = 1

" Go (+govim) shortcuts and settings
" Docs here: https://godoc.org/github.com/myitcv/govim/cmd/govim/config
packadd govim
" Disable automatic population of quickfix.
call govim#config#Set("QuickfixAutoDiagnosticsDisable", 1)
" Disable showing signs in the gutter (I find this disruptive).
call govim#config#Set("QuickfixSignsDisable", 1)
" TODO:
" - Send the appropriate -local flag to gopls (https://github.com/golang/go/issues/32049)
" - Make govim use the gopls from my path (https://github.com/myitcv/govim/issues/440)
" - Add a shortcut for doing all of the following at once:
"   * Run GOVIMQuickfixDiagnostics
"   * If the quickfix window is populated, open it and jump to the first item
"   * If the quickfix window is not populated, close it
"   Once there is a command for running go test etc, add similar shortcuts for
"   those as well.
augroup go
  au!
  au FileType go,asm setlocal noexpandtab
  au FileType go,asm setlocal ts=8
  au FileType go,asm setlocal sw=8
augroup END
let g:go_highlight_trailing_whitespace_error = 0

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
augroup clojure
  au!
  au FileType clojure setlocal textwidth=110
  au FileType clojure setlocal wrapmargin=110
  au FileType clojure setlocal colorcolumn=110
augroup END
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
