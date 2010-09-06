    " $Author: Vladimir Penkin $
" $URL: http://twitter.com/mindwork $
" $Date: 2009-08-11 21:53:21 +0200 $ 

colorscheme ir_black_shell

syntax on					" Syntax highlighting
set showmatch 				" Show matching brackets
set history=1000 			" How many lines of history to remember.
set ignorecase smartcase	" Ignore case sens in search
set hlsearch				" Hightlight while search
set incsearch				" incremental search
set showtabline=2			" Show tab line

set number 					" show line numbers

" Indent 
set tabstop=4     			" numbers of spaces of tab character
set smartindent				" Smart indenting, based on the typed code.
set smarttab
set shiftwidth=4
set autoindent
set expandtab

let mapleader = ","			" Leader key

set diffopt+=iwhite			" Diff option: ignore whitespace

command Crlf :%s///g		" To get rid of ^M characters as result of DOS line endings

command Swarp :set wrap linebreak textwidth=0

" Highlight HTML code inside PHP strings
let php_htmlInStrings=1
" Highlight mySQL queries inside PHP strings
let php_sql_query=1

" Code folding
" ============

"set foldenable 
" Fold column width
"set foldcolumn=4
" Make folding indent sensitive
"set foldmethod=indent 
"set foldminlines=2
" Folds with a higher level will be automatically closed.
"set foldlevel=4
" Don't auto-open folds
"set foldopen=

nnoremap <silent> <F5> :NERDTreeToggle <CR>
map <F1> :previous<CR>  " map F1 to open previous buffer
map <F2> :next<CR>      " map F2 to open next buffer



map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
"map <F6> :vimgrep Todo: *.css<CR>:cw<CR>
"map <F6> :vimgrep /todo/j *.[css,phtml,html]<CR>:cw<CR>
  
" Fuzzy finder bindings
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
map <leader>f :FuzzyFinderBuffer <CR>
map <leader>F :FuzzyFinderFile <CR>
nnoremap <leader>l :FuzzyFinderFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR> 
map <leader>q :call ToggleQuickFix()<CR>


nmap <c-s> :w<cr> vmap <c-s> <esc><c-s> imap <c-s> <esc><c-s>

" Use all the memory needed, for maximum performance.
"set maxmemtot=2000000 
"set maxmem=2000000 
"set maxmempattern=2000000


function! ToggleScratch()
  if expand('%') == g:ScratchBufferName
    quit
  else
    Sscratch
  endif
endfunction

map <leader>s :call ToggleScratch()<CR>
cd /Users/vladimirpenkin/Documents/workspace
