" Ensure Vim goodies and enhancements are active
" This also ensures there are no conflicts with our later options
set nocompatible

set foldmethod=syntax
set foldlevelstart=1

" Enable mouse scrolling, clicking, etc.
set mouse=a

" Tell Vim to use 256 colors in case we're in a color-gimped terminal
" This has to be set before you set your colorscheme
set t_Co=256
colors Tomorrow-Night-Bright

" This is for syntax-highlighting and tells Vim to attempt to determine
" the type of file being edited
filetype plugin on

" Tell Vim how many columns wide a tab should be
set tabstop=2

" Force Vim to insert spaces when you press Tab while in insert mode.
" Prevents Vim from using tab characters at all.
set expandtab

set shiftwidth=2

" Tells Vim how many spaces to use when you press Tab in insert mode.
set softtabstop=2

" Vim will copy the indentation from the previous line
set autoindent

" Vim will not wrap code/text when the editor width is exceeded
set nowrap

" Highlight search to highlight all instances of the searched-for string
set hls

" Turn on line numbers
set number

" Perform case-insensitive searches.
set ignorecase

" If one or more letters in the search string are upper-case, the search
" will be case-sensitive, instead.
set smartcase

" Turn on incremental search
set incsearch

" When split-opening files vertically, the new file opens to the right
" of the active file.
set splitright

" When split-opening files horizontally, the new file opens below the
" active file.
set splitbelow

" Turn on high-lighting of the line and column where the cursor is,
" respectively.
set cursorline
set cursorcolumn

" MAPPINGS --------------------------------------------------------------- {{{

nnoremap <space> i<space><space>
vnoremap <space> <space>
nnoremap o o<Esc>

" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{

if version >= 703
  set undodir=~/.vim/backup
  set undofile
  set undoreload=10000
endif

" }}}

" STATUS LINE ------------------------------------------------------------ {{{

" Clear status line when vimrc is reloaded.
set statusline=

" Status line right side.
set statusline+=\ row:\ %l\ col:\ %c\ %f\ %m\ %r\ %y

" Show the status on the second to last line.
set laststatus=2

" }}}
