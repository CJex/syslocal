" Use `:version` or `:echo $MYVIMRC` to get current config file path
" Add `source /path/to/this/file.vim` to $HOME/.vimrc

let s:_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let &runtimepath .= "," . s:_dir . "/colorschemes"

" echo &runtimepath

color synic
color baycomb
set guifont=DejaVu\ Sans\ Mono\ 14
set tabstop=2
set shiftwidth=2
set expandtab
set nobackup
let loaded_matchparen = 1
set number
set autoindent
set nohlsearch
set fileformat=unix
filetype plugin indent on
filetype off
filetype plugin indent off
filetype plugin indent on
syntax on
autocmd BufWritePre * :%s/\s\+$//e
set shiftround


"Toggle Menu and Toolbar
set guioptions-=m
set guioptions-=T
"map <silent> <F2> :if &guioptions =~# 'T' <Bar>
"        \set guioptions-=T <Bar>
"        \set guioptions-=m <bar>
"    \else <Bar>
"        \set guioptions+=T <Bar>
"        \set guioptions+=m <Bar>
"    \endif<CR>

