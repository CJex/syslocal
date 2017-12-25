let s:_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

exe "source " . s:_dir . "/vimrc.local.vim"