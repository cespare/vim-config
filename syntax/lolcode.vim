" Vim syntax file
" Language:     Lolcode
" Filenames:    *.lol
" Maintainer:   Runa Sandvik  <runa@indentedlines.net>
" URL:          http://www.indentedlines.net/lolcode/vim.tar.gz
" Last Change:  2008 September 16
"               2007 June 16 - initial version

" this is for special characters in strings (they start with the colon)
syn match lolSpecial display contained ":[)>o:\"]"

" Statements
syn keyword lolStatement	VISIBLE HAI KTHX KTHXBYE SMOOSH
syn keyword lolStatement   GIMMEH PLZ ON INVISIBLE R ITZ GTFO

syn match lolStatement   "OPEN FILE" 
syn match lolStatement	 "I HAS A"
syn match lolStatement   "AWSUM THX"
syn match lolStatement   "O NOES" 
syn match lolStatement	 "CAN HAS"
syn match lolStatement   "HOW DOES I"
syn match lolStatement   "IF U SAY SO"
syn match lolStatement   "FOUND YR"

" Conditionals
syn keyword lolConditional IZ YARLY NOWAI WTF? MEBBE NOT OMG OMGWTF

syn match lolConditional "O RLY?"
syn match lolConditional "SUM OF"
syn match lolConditional "BOTH SAEM"
syn match lolConditional "DIFFRINT"
syn match lolConditional "BOTH OF"
syn match lolConditional "EITHER OF"
syn match lolConditional "WON OF"
syn match lolConditional "DIFF OF"
syn match lolConditional "PRODUKT OF"
syn match lolConditional "QUOSHUNT OF"
syn match lolConditional "MOD OF"
syn match lolConditional "BIGGR OF"
syn match lolConditional "SMALLR OF"
syn match lolConditional "MKAY"

" Repeat
syn match lolRepeat	"IM IN YR" 
syn match lolRepeat	"IM OUTTA YR"

" Operators
syn keyword lolOperator AN NOT UP YR UPPIN NERF NERFIN
syn match lolOperator "!!"

" Strings
syn region lolString start="\"" end="\"" contains=lolSpecial

" Comments
syn region lolComment start="OBTW" skip="\\$" end="TLDR"
syn match lolComment "BTW.*"

" Yay, highlight
if version >= 508 || !exists("did_lol_syntax_inits")
   if version < 508
	let did_lol_syntax_inits = 1
	command -nargs=+ HiLink hi link <args>
  else
	command -nargs=+ HiLink hi def link <args>
  endif

" The default highlighting
HiLink lolSpecial	SpecialChar
HiLink lolStatement	Statement
HiLink lolConditional	Conditional
HiLink lolRepeat	Repeat
HiLink lolOperator	Operator
HiLink lolComment	Comment
HiLink lolString	String
   
	delcommand HiLink
 endif
 
let b:current_syntax = "lolcode"
