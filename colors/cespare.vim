" ============================================================================
" Name:     cespare's personal color scheme
" Author:   Caleb Spare
" Version:  0.0.1
" ----------------------------------------------------------------------------

" This is a hack-up of LuciusDark.

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "cespare"

let s:normal_items = [
            \ "ColorColumn", "Comment", "Constant", "Cursor", "CursorColumn",
            \ "CursorIM", "CursorLine", "CursorLineNr", "DiffAdd", "DiffChange",
            \ "DiffDelete", "Directory", "Error", "ErrorMsg", "Identifier",
            \ "IncSearch", "LineNr", "MatchParen", "ModeMsg", "MoreMsg",
            \ "NonText", "Pmenu", "PmenuSbar", "PmenuSel",
            \ "PmenuThumb", "PreProc", "Question", "Search", "SignColumn",
            \ "Special", "SpecialKey", "Statement", "TabLine",
            \ "TabLineFill", "Todo", "Type", "VertSplit", "Visual",
            \ "WarningMsg", "WildMenu",
            \ ]

let s:bold_items = [
            \ "DiffText", "FoldColumn", "Folded", "TabLineSel",
            \ "Title",
            \ ]

let s:underline_items = [
            \ "Underlined", "VisualNOS"
            \ ]

" Clear default settings
for s:item in s:normal_items + s:bold_items + s:underline_items
    exec "hi " . s:item . " guifg=NONE guibg=NONE gui=none"
                \ . " ctermfg=NONE ctermbg=NONE cterm=none term=none"
endfor

hi clear Normal
hi Normal       ctermfg=NONE  ctermbg=NONE  guifg=#d7d7d7 guibg=#191919
hi IncSearch    ctermfg=NONE  ctermbg=24    guifg=NONE    guibg=#005f87
hi Search       ctermfg=NONE  ctermbg=24    guifg=NONE    guibg=#005f87
hi Comment      ctermfg=246   cterm=NONE    guifg=#949494 gui=NONE
hi MatchParen   ctermfg=NONE  ctermbg=237   guifg=NONE    guibg=#2c5475
hi Error        ctermfg=NONE  ctermbg=239   guifg=NONE    guibg=#4e4e4e
hi LineNr       ctermfg=245   ctermbg=235   guifg=#8a8a8a guibg=#404040
hi Cursor                                   guifg=bg      guibg=#87afd7
hi ColorColumn  ctermfg=NONE  ctermbg=237   guifg=NONE    guibg=#3a3a3a
hi Constant     ctermfg=150                 guifg=#afd787
hi VertSplit    ctermfg=236   ctermbg=244   guifg=#303030 guibg=#808080
hi CursorLine   ctermfg=NONE  ctermbg=238   guifg=NONE    guibg=#444444
hi Visual       ctermfg=NONE  ctermbg=24    guifg=NONE    guibg=#005f87
hi Title        ctermfg=74    ctermbg=NONE guifg=#5fafd7 guibg=NONE
hi Todo         ctermfg=185   ctermbg=NONE  guifg=#d7d75f guibg=NONE
hi Pmenu        ctermfg=NONE  ctermbg=249   guifg=bg      guibg=#b2b2b2
hi PmenuSel     ctermfg=NONE  ctermbg=24    guifg=fg      guibg=#005f87
hi PmenuSbar    ctermfg=249   ctermbg=252   guifg=#b2b2b2 guibg=#d0d0d0
hi PmenuThumb   ctermfg=NONE  ctermbg=244   guifg=fg      guibg=#808080

"hi StatusLine   ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
"hi StatusLineNC ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE

"hi Special      ctermfg=228                 guifg=#ffff87

"hi ModeMsg      guifg=fg
"hi Question     guifg=fg
"hi NonText			guifg=#5f875f
"hi SpecialKey		guifg=#5f5f87
"hi Directory    guifg=#afd7af
"hi Identifier   guifg=#afd787
"hi PreProc      guifg=#87d7af
"hi Statement    guifg=#87d7ff
"hi Title        guifg=#5fafd7
"hi Type         guifg=#87d7d7
"hi CursorColumn guifg=NONE
"hi CursorIM     guifg=bg
"hi VisualNOS    guifg=fg        guibg=NONE
"hi CursorColumn                 guibg=#444444
"hi CursorIM                     guibg=#87afd7
"hi ModeMsg      guifg=fg
"hi Question     guifg=fg
"hi ErrorMsg     guifg=#ff5f5f
"hi MoreMsg      guifg=#5fd7d7
"hi WarningMsg   guifg=#d7875f
"hi TabLine      guifg=bg
"hi TabLineSel   guifg=fg
"hi WildMenu     guifg=fg
"hi CursorLineNr guifg=#626262   guibg=#444444
"hi FoldColumn                   guibg=#4e4e4e
"hi Folded                       guibg=#4e4e4e
"hi SignColumn                   guibg=#4e4e4e
"hi TabLineFill  guifg=#444444
"hi WildMenu                     guibg=#005f87
"hi FoldColumn   guifg=#bcbcbc
"hi Folded       guifg=#bcbcbc
"hi SignColumn   guifg=#b2b2b2
"hi TabLine                      guibg=#b2b2b2
"hi TabLineFill                  guibg=#b2b2b2
"hi TabLineSel                   guibg=#005f87
"hi DiffAdd      guifg=fg
"hi DiffChange   guifg=fg
"hi DiffDelete   guifg=fg
"hi DiffAdd                      guibg=#5f875f
"hi DiffChange                   guibg=#87875f
"hi DiffDelete                   guibg=#875f5f
"hi DiffText                     guibg=#87875f
"hi DiffText     guifg=#ffff87
"
"let s:color_map = {
    "\ 'bg': 'bg', 'fg': 'fg', 'NONE': 'NONE',
    "\ '#000000':  '16', '#00005f':  '17', '#000087':  '18', '#0000af':  '19',
    "\ '#0000d7':  '20', '#0000ff':  '21', '#005f00':  '22', '#005f5f':  '23',
    "\ '#005f87':  '24', '#005faf':  '25', '#005fd7':  '26', '#005fff':  '27',
    "\ '#008700':  '28', '#00875f':  '29', '#008787':  '30', '#0087af':  '31',
    "\ '#0087d7':  '32', '#0087ff':  '33', '#00af00':  '34', '#00af5f':  '35',
    "\ '#00af87':  '36', '#00afaf':  '37', '#00afd7':  '38', '#00afff':  '39',
    "\ '#00d700':  '40', '#00d75f':  '41', '#00d787':  '42', '#00d7af':  '43',
    "\ '#00d7d7':  '44', '#00d7ff':  '45', '#00ff00':  '46', '#00ff5f':  '47',
    "\ '#00ff87':  '48', '#00ffaf':  '49', '#00ffd7':  '50', '#00ffff':  '51',
    "\ '#5f0000':  '52', '#5f005f':  '53', '#5f0087':  '54', '#5f00af':  '55',
    "\ '#5f00d7':  '56', '#5f00ff':  '57', '#5f5f00':  '58', '#5f5f5f':  '59',
    "\ '#5f5f87':  '60', '#5f5faf':  '61', '#5f5fd7':  '62', '#5f5fff':  '63',
    "\ '#5f8700':  '64', '#5f875f':  '65', '#5f8787':  '66', '#5f87af':  '67',
    "\ '#5f87d7':  '68', '#5f87ff':  '69', '#5faf00':  '70', '#5faf5f':  '71',
    "\ '#5faf87':  '72', '#5fafaf':  '73', '#5fafd7':  '74', '#5fafff':  '75',
    "\ '#5fd700':  '76', '#5fd75f':  '77', '#5fd787':  '78', '#5fd7af':  '79',
    "\ '#5fd7d7':  '80', '#5fd7ff':  '81', '#5fff00':  '82', '#5fff5f':  '83',
    "\ '#5fff87':  '84', '#5fffaf':  '85', '#5fffd7':  '86', '#5fffff':  '87',
    "\ '#870000':  '88', '#87005f':  '89', '#870087':  '90', '#8700af':  '91',
    "\ '#8700d7':  '92', '#8700ff':  '93', '#875f00':  '94', '#875f5f':  '95',
    "\ '#875f87':  '96', '#875faf':  '97', '#875fd7':  '98', '#875fff':  '99',
    "\ '#878700': '100', '#87875f': '101', '#878787': '102', '#8787af': '103',
    "\ '#8787d7': '104', '#8787ff': '105', '#87af00': '106', '#87af5f': '107',
    "\ '#87af87': '108', '#87afaf': '109', '#87afd7': '110', '#87afff': '111',
    "\ '#87d700': '112', '#87d75f': '113', '#87d787': '114', '#87d7af': '115',
    "\ '#87d7d7': '116', '#87d7ff': '117', '#87ff00': '118', '#87ff5f': '119',
    "\ '#87ff87': '120', '#87ffaf': '121', '#87ffd7': '122', '#87ffff': '123',
    "\ '#af0000': '124', '#af005f': '125', '#af0087': '126', '#af00af': '127',
    "\ '#af00d7': '128', '#af00ff': '129', '#af5f00': '130', '#af5f5f': '131',
    "\ '#af5f87': '132', '#af5faf': '133', '#af5fd7': '134', '#af5fff': '135',
    "\ '#af8700': '136', '#af875f': '137', '#af8787': '138', '#af87af': '139',
    "\ '#af87d7': '140', '#af87ff': '141', '#afaf00': '142', '#afaf5f': '143',
    "\ '#afaf87': '144', '#afafaf': '145', '#afafd7': '146', '#afafff': '147',
    "\ '#afd700': '148', '#afd75f': '149', '#afd787': '150', '#afd7af': '151',
    "\ '#afd7d7': '152', '#afd7ff': '153', '#afff00': '154', '#afff5f': '155',
    "\ '#afff87': '156', '#afffaf': '157', '#afffd7': '158', '#afffff': '159',
    "\ '#d70000': '160', '#d7005f': '161', '#d70087': '162', '#d700af': '163',
    "\ '#d700d7': '164', '#d700ff': '165', '#d75f00': '166', '#d75f5f': '167',
    "\ '#d75f87': '168', '#d75faf': '169', '#d75fd7': '170', '#d75fff': '171',
    "\ '#d78700': '172', '#d7875f': '173', '#d78787': '174', '#d787af': '175',
    "\ '#d787d7': '176', '#d787ff': '177', '#d7af00': '178', '#d7af5f': '179',
    "\ '#d7af87': '180', '#d7afaf': '181', '#d7afd7': '182', '#d7afff': '183',
    "\ '#d7d700': '184', '#d7d75f': '185', '#d7d787': '186', '#d7d7af': '187',
    "\ '#d7d7d7': '188', '#d7d7ff': '189', '#d7ff00': '190', '#d7ff5f': '191',
    "\ '#d7ff87': '192', '#d7ffaf': '193', '#d7ffd7': '194', '#d7ffff': '195',
    "\ '#ff0000': '196', '#ff005f': '197', '#ff0087': '198', '#ff00af': '199',
    "\ '#ff00d7': '200', '#ff00ff': '201', '#ff5f00': '202', '#ff5f5f': '203',
    "\ '#ff5f87': '204', '#ff5faf': '205', '#ff5fd7': '206', '#ff5fff': '207',
    "\ '#ff8700': '208', '#ff875f': '209', '#ff8787': '210', '#ff87af': '211',
    "\ '#ff87d7': '212', '#ff87ff': '213', '#ffaf00': '214', '#ffaf5f': '215',
    "\ '#ffaf87': '216', '#ffafaf': '217', '#ffafd7': '218', '#ffafff': '219',
    "\ '#ffd700': '220', '#ffd75f': '221', '#ffd787': '222', '#ffd7af': '223',
    "\ '#ffd7d7': '224', '#ffd7ff': '225', '#ffff00': '226', '#ffff5f': '227',
    "\ '#ffff87': '228', '#ffffaf': '229', '#ffffd7': '230', '#ffffff': '231',
    "\ '#080808': '232', '#121212': '233', '#1c1c1c': '234', '#262626': '235',
    "\ '#303030': '236', '#3a3a3a': '237', '#444444': '238', '#4e4e4e': '239',
    "\ '#585858': '240', '#626262': '241', '#6c6c6c': '242', '#767676': '243',
    "\ '#808080': '244', '#8a8a8a': '245', '#949494': '246', '#9e9e9e': '247',
    "\ '#a8a8a8': '248', '#b2b2b2': '249', '#bcbcbc': '250', '#c6c6c6': '251',
    "\ '#d0d0d0': '252', '#dadada': '253', '#e4e4e4': '254', '#eeeeee': '255',
    "\ }

