" Vim syntax file
" Language:	Promela
" Maintainer:	Viliam Holub <holub@nenya.ms.mff.cuni.cz>
" Last Change:	2006 Oct 27
" Filenames:	*.promela
" URL:		http://nenya.ms.mff.cuni.cz/~holub/
" Credits: 	Some ideas has been stolen from the official c.vim file.

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
	finish
endif

syntax case match

" Comments
syn keyword	promelaTodo		contained TODO FIXME XXX
syn region	promelaComment		start="/\*" end="\*/" contains=promelaTodo fold
syn match	promelaCommentError	"\*/"
syn region	promelaComment		start="//" skip="\\$" end="$" keepend contains=promelaTodo

" Promela constants
syn region	promelaString		start=+"+ skip=+\\"+ end=+"+ contains=promelaFormat
syn match	promelaStringFormat	display "%\(d\|u\|x\|o\|c\|e\|%\)" contained
syn match	promelaStringFormat	display "\\\(n\|t\|\\\|\"\|\)"  contained
syn match	promelaNumber		"\<[0-9]\+\>"
syn keyword	promelaBoolean		true false TRUE FALSE

" Identifiers
syn keyword	promelaFunction		printf len empty nempty full nfull enabled eval pc_value 

" Statements
syn keyword 	promelaStatement		atomic d_step goto never of priority provided timeout _ _last _pid c_code c_decl c_track c_expr np_ STDIN trace notrace
syn keyword	promelaStatementConditional	assert else fi if unless xr xs
syn keyword 	promelaStatementRepeat		do od
syn keyword 	promelaStatementLabel		break skip
syn match   	promelaStatementLabel		display "\s*\I\i*\s*:"
syn keyword 	promelaStatementOperator	run

" Preprocessor
syn region	promelaPreProcIncluded	display contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match	promelaPreProcInclude	display "^\s*\(%:\|#\)\s*include\>\s*\"" contains=promelaPreProcIncluded
syn region	promelaPreProcDefine	start="^\s*\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$" end="//"me=s-1 contains=promelaNumber,promelaComment
syn region	promelaPreProcCondit	start="^\s*\(%:\|#\)\s*\(if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" end="//"me=s-1 contains=promelaComment
syn match	promelaPreProcCondit	display "^\s*\(%:\|#\)\s*\(else\|endif\)\>"
syn region	promelaOut		start="^\s*\(%:\|#\)\s*if\s\+0\+\>" end=".\@=\|$" contains=promelaOut2 fold
syn region	promelaOut2		contained start="0" end="^\s*\(%:\|#\)\s*\(endif\>\|else\>\|elif\>\)" contains=promelaSkip
syn region	promelaSkip		contained start="^\s*\(%:\|#\)\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>" contains=promelaSkip

" Types
syn keyword	promelaType		bit bool byte pid chan int mtype proctype short unsigned Dproctype 
syn keyword 	promelaStorageClass	hidden init inline active local show
syn keyword 	promelaTypedef		typedef c_state 

" Basic block definition
syntax region	promelaBlock		start="{" end="}" transparent fold

" Define the default highlighting.
hi def link promelaComment		Comment
hi def link promelaCommentError		Error
hi def link promelaString		String
hi def link promelaStringFormat		Special
hi def link promelaNumber		Number
hi def link promelaBoolean		Boolean
hi def link promelaPreProcDefine	Define
hi def link promelaPreProcInclude	Include
hi def link promelaPreProcIncluded	String
hi def link promelaPreProcCondit	PreCondit
hi def link promelaStatement		Statement
hi def link promelaStatementConditional	Conditional
hi def link promelaStatementRepeat	Repeat
hi def link promelaStatementLabel	Label 
hi def link promelaStatementOperator	Operator
hi def link promelaFunction		Function
hi def link promelaType			Type
hi def link promelaStorageClass		StorageClass
hi def link promelaTypedef		Typedef
hi def link promelaTodo			Todo
hi def link promelaOut			Comment
hi def link promelaOut2			Comment
hi def link promelaSkip			Comment

let b:current_syntax = "promela"

" vim: ts=8
