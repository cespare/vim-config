augroup filetypedetect
  au BufNewFile,BufRead *.promela,*.prm,*.pr	setf promela " Promela
  au BufNewFile,BufRead *.lol setf lolcode " lolcode
  au BufRead,BufNewFile *.m	setf objc "Objective-C
  au BufNewFile,BufRead *.cobra setf cobra " Cobra
  au BufNewFile,BufRead *.scala,*.sbt setf scala " Scala
  au BufNewFile,BufRead *.cilk setf cpp " Cilk
  au BufNewFile,BufRead *.hj setf java " Habanero Java
  au BufNewFile,BufRead *.proto setfiletype proto " Protobufs
  au BufNewFile,BufRead *.thrift setfiletype thrift " Thrift
  au BufNewFile,BufRead *.cuh setfiletype cuda " Cuda header files
  au BufNewFile,BufRead *.i setfiletype swig
  au BufNewFile,BufRead *.as setfiletype actionscript " Actionscript
  au BufNewFile,BufRead *.mxml setfiletype mxml " MXML files
  au BufNewFile,BufRead *.less setfiletype less " LESS css
  au BufNewFile,BufRead Vagrantfile setfiletype ruby
  au BufNewFile,BufRead *.tmpl setfiletype gotplhtml " Go templates
augroup END
