" Vim syntax file
" Language:	Cobra
" Maintainer:	Caleb Spare <cespare@gmail.com>
" Last Change:	05-19-2009
" Filenames:	*.cobra
" Version:	0.1
"
" Based on the Dmitry Vasiliev's python syntax file
" <dima@hlabs.spb.ru>

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Keywords
syn keyword cobraInclude use

syn keyword cobraKeyword namespace inherits implements extend
syn keyword cobraKeyword where must be callable adds cue invariant as
syn keyword cobraKeyword pro var const from has body test shared is of event
syn keyword cobraKeyword using return yield listen ignore this base to to?

syn keyword cobraStorageClass abstract extern fake internal new nonvirtual
syn keyword cobraStorageClass override partial public private protected virtual

syn keyword cobraType bool char int uint decimal float dynamic number passthrough
syn keyword cobraType vari out inout

syn keyword cobraConditional require ensure old implies
syn keyword cobraConditional if else post for

syn keyword cobraStatement assert branch on off expect
syn keyword cobraStatement break continue pass

syn keyword cobraDefn	def sig class interface mixin enum struct nextgroup=cobraFunction skipwhite
syn match   cobraFunction	"[a-zA-Z_][a-zA-Z0-9_]*" display contained

syn keyword cobraRepeat	do while

syn keyword cobraException try catch success finally throw raise
syn keyword cobraException except

syn keyword cobraOperator	and or not any all in
syn keyword cobraOperator	get set print stop trace ref

syn keyword cobraBoolean true false
syn keyword cobraConstant nil


" Comments
syn match   cobraComment	"#.*$" display contains=cobraTodo,@Spell
syn match   cobraRun		"\%^#!.*$"
syn match   cobraCoding	"\%^.*\(\n.*\)\?#.*coding[:=]\s*[0-9A-Za-z-_.]\+.*$"
syn keyword cobraTodo		TODO FIXME XXX contained

" Errors
syn match cobraError		"\<\d\+\D\+\>" display
syn match cobraError		"$" display
syn match cobraError		"[&|]\{2,}" display
syn match cobraError		"[=]\{3,}" display

" Strings
syn region cobraString		start=+[bB]\='+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=cobraEscape,cobraEscapeError,@Spell
syn region cobraString		start=+[bB]\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=cobraEscape,cobraEscapeError,@Spell
syn region cobraString		start=+[bB]\="""+ end=+"""+ keepend contains=cobraEscape,cobraEscapeError,cobraDocTest2,cobraSpaceError,@Spell
syn region cobraString		start=+[bB]\='''+ end=+'''+ keepend contains=cobraEscape,cobraEscapeError,cobraDocTest,cobraSpaceError,@Spell

syn match  cobraEscape		+\\[abfnrtv'"\\]+ display contained
syn match  cobraEscape		"\\\o\o\=\o\=" display contained
syn match  cobraEscapeError	"\\\o\{,2}[89]" display contained
syn match  cobraEscape		"\\x\x\{2}" display contained
syn match  cobraEscapeError	"\\x\x\=\X" display contained
syn match  cobraEscape		"\\$"

" Unicode strings
syn region cobraUniString	start=+[uU]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=cobraEscape,cobraUniEscape,cobraEscapeError,cobraUniEscapeError,@Spell
syn region cobraUniString	start=+[uU]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=cobraEscape,cobraUniEscape,cobraEscapeError,cobraUniEscapeError,@Spell
syn region cobraUniString	start=+[uU]"""+ end=+"""+ keepend contains=cobraEscape,cobraUniEscape,cobraEscapeError,cobraUniEscapeError,cobraDocTest2,cobraSpaceError,@Spell
syn region cobraUniString	start=+[uU]'''+ end=+'''+ keepend contains=cobraEscape,cobraUniEscape,cobraEscapeError,cobraUniEscapeError,cobraDocTest,cobraSpaceError,@Spell

syn match  cobraUniEscape	"\\u\x\{4}" display contained
syn match  cobraUniEscapeError	"\\u\x\{,3}\X" display contained
syn match  cobraUniEscape	"\\U\x\{8}" display contained
syn match  cobraUniEscapeError	"\\U\x\{,7}\X" display contained
syn match  cobraUniEscape	"\\N{[A-Z ]\+}" display contained
syn match  cobraUniEscapeError	"\\N{[^A-Z ]\+}" display contained

" Raw strings
syn region cobraRawString	start=+[rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=cobraRawEscape,@Spell
syn region cobraRawString	start=+[rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=cobraRawEscape,@Spell
syn region cobraRawString	start=+[rR]"""+ end=+"""+ keepend contains=cobraDocTest2,cobraSpaceError,@Spell
syn region cobraRawString	start=+[rR]'''+ end=+'''+ keepend contains=cobraDocTest,cobraSpaceError,@Spell

syn match cobraRawEscape	+\\['"]+ display transparent contained

" Unicode raw strings
syn region cobraUniRawString	start=+[uU][rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=cobraRawEscape,cobraUniRawEscape,cobraUniRawEscapeError,@Spell
syn region cobraUniRawString	start=+[uU][rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=cobraRawEscape,cobraUniRawEscape,cobraUniRawEscapeError,@Spell
syn region cobraUniRawString	start=+[uU][rR]"""+ end=+"""+ keepend contains=cobraUniRawEscape,cobraUniRawEscapeError,cobraDocTest2,cobraSpaceError,@Spell
syn region cobraUniRawString	start=+[uU][rR]'''+ end=+'''+ keepend contains=cobraUniRawEscape,cobraUniRawEscapeError,cobraDocTest,cobraSpaceError,@Spell

syn match  cobraUniRawEscape		"\([^\\]\(\\\\\)*\)\@<=\\u\x\{4}" display contained
syn match  cobraUniRawEscapeError	"\([^\\]\(\\\\\)*\)\@<=\\u\x\{,3}\X" display contained

" Numbers (ints, longs, floats, complex)
syn match   cobraHexError	"\<0[xX]\x*[g-zG-Z]\x*[lL]\=\>" display

syn match   cobraHexNumber	"\<0[xX]\x\+[lL]\=\>" display
syn match   cobraOctNumber "\<0[oO]\o\+[lL]\=\>" display
syn match   cobraBinNumber "\<0[bB][01]\+[lL]\=\>" display

syn match   cobraNumber	"\<\d\+[lLjJ]\=\>" display

syn match   cobraFloat		"\.\d\+\([eE][+-]\=\d\+\)\=[jJ]\=\>" display
syn match   cobraFloat		"\<\d\+[eE][+-]\=\d\+[jJ]\=\>" display
syn match   cobraFloat		"\<\d\+\.\d*\([eE][+-]\=\d\+\)\=[jJ]\=" display

syn match   cobraOctError	"\<0[oO]\=\o*[8-9]\d*[lL]\=\>" display
syn match   cobraBinError	"\<0[bB][01]*[2-9]\d*[lL]\=\>" display

if version >= 508 || !exists("did_cobra_syn_inits")
  if version <= 508
    let did_cobra_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink cobraInclude Include
  HiLink cobraKeyword Keyword
  HiLink cobraStorageClass StorageClass
  HiLink cobraType Type
  HiLink cobraConditional Conditional
  HiLink cobraDefn Keyword
  HiLink cobraFunction Function
  HiLink cobraRepeat Repeat
  HiLink cobraException Exception
  HiLink cobraOperator Operator
  HiLink cobraBoolean Boolean
  HiLink cobraConstant Constant

  HiLink cobraComment		Comment
  HiLink cobraCoding		Special
  HiLink cobraRun		Special
  HiLink cobraTodo		Todo

  HiLink cobraError		Error
  HiLink cobraIndentError	Error
  HiLink cobraSpaceError	Error

  HiLink cobraString		String
  HiLink cobraUniString	String
  HiLink cobraRawString	String
  HiLink cobraUniRawString	String

  HiLink cobraEscape			Special
  HiLink cobraEscapeError		Error
  HiLink cobraUniEscape		Special
  HiLink cobraUniEscapeError		Error
  HiLink cobraUniRawEscape		Special
  HiLink cobraUniRawEscapeError	Error

  HiLink cobraStrFormatting	Special
  HiLink cobraStrFormat    	Special
  HiLink cobraStrTemplate	    Special

  HiLink cobraDocTest		Special
  HiLink cobraDocTest2		Special

  HiLink cobraNumber		Number
  HiLink cobraHexNumber	Number
  HiLink cobraOctNumber	Number
  HiLink cobraBinNumber	Number
  HiLink cobraFloat		Float
  HiLink cobraOctError	    Error
  HiLink cobraHexError		Error
  HiLink cobraBinError		Error

  HiLink cobraBuiltinObj	Structure
  HiLink cobraBuiltinFunc	Function

  HiLink cobraExClass	Structure

  delcommand HiLink
endif

let b:current_syntax = "cobra"
