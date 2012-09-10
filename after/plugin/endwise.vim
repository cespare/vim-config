" Some completion configuration that must be configured after endwise is loaded.

" Make escape get out of pumenu mode and go back to the uncompleted word
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
"" Make enter select the current completion and close the menu
" TODO: Can't figure out how to make this play well with endwise :\
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
" When entering a completion mode, automatically select the first item.
" TODO: See if there's a way to do this for all completion types without coding each case individually.
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <C-f> pumvisible() ? '<C-n>' : '<C-x><C-f><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <C-o> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
