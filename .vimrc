" ============================================================================
" GENERAL SETTINGS
" ============================================================================
" Use Vim settings, rather than Vi settings.
set nocompatible

" ============================================================================
" PLUGINS
" ============================================================================
call plug#begin('~/.vim/plugged')

" --- ESSENTIALS ---
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'      " gcc to comment line, gc to comment selection

" --- UI & NAVIGATION ---
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'    " Shows + / - / ~ in the sidebar for git changes
" Fuzzy Finder (Files, Buffers, etc.)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" --- LANGUAGES & SYNTAX ---
" Polyglot loads support for almost everything...
Plug 'sheerun/vim-polyglot'
" ...but we load the official Ansible plugin AFTER to ensure we get the
" absolute latest Jinja/YAML handling for your 'Total Ansible' work.
Plug 'pearofducks/ansible-vim'

" --- INTELLIGENCE (LSP) ---
" Stable branch of CoC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" ============================================================================
" END PLUGINS
" ============================================================================

" ============================================================================
" MORE GENERAL SETTINGS
" ============================================================================
" Enable file type detection, plugins, and indentation rules.
" This is the modern standard superseding 'filetype plugin on'.
filetype plugin indent on

" Syntax highlighting
syntax on

" Set internal encoding to UTF-8 (essential for modern web dev/icons)
set encoding=utf-8

" Enable mouse support in all modes
set mouse=a

" ============================================================================
" UI & VISUALS
" ============================================================================
" Use 256 colors
set t_Co=256

" Color scheme (ensure ~/.vim/colors/Tomorrow-Night-Bright.vim exists)
try
  colorscheme Tomorrow-Night-Bright
catch
  colorscheme desert " Fallback if the theme file is missing
endtry

" Line Numbers
set number

" Highlight current line and column
set cursorline
set cursorcolumn

" Show the status line always (even if only one window)
set laststatus=2

" Status line format: row, col, filename, modified flag, read-only flag, filetype
set statusline=\ row:\ %l\ col:\ %c\ \ %f\ %m\ %r\ %y

" ============================================================================
" PLUGIN SETTINGS
" ============================================================================
" --- AIRLINE ---
let g:airline_theme='tomorrow'
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1

" --- FZF (Fuzzy Finder) ---
" Map Ctrl-p to find files (like VS Code)
nnoremap <C-p> :Files<CR>
" Map Ctrl-b to find open buffers
nnoremap <C-b> :Buffers<CR>
" Map Ctrl-f to search text inside files (requires ripgrep installed, or uses grep)
nnoremap <C-f> :Rg<CR>

" --- ANSIBLE ---
" Make sure Ansible-Vim handles Jinja2 files correctly
let g:ansible_unindent_after_newline = 1
let g:ansible_attribute_highlight = "ob"
let g:ansible_name_highlight = 'd'
let g:ansible_extra_keywords_highlight = 1

" --- COC (INTELLISENSE) ---
" 1. Use Tab for autocomplete triggers
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Helper for the Tab mapping above
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 2. Use Enter to confirm selection
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" 3. Code Navigation shortcuts (Go to Definition)
" gd = Go to Definition
nmap <silent> gd <Plug>(coc-definition)
" gy = Go to Type Definition
nmap <silent> gy <Plug>(coc-type-definition)
" gr = Go to References (where is this used?)
nmap <silent> gr <Plug>(coc-references)
" K = Show documentation (hover)
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" ============================================================================
" SEARCHING
" ============================================================================
" Highlight search results
set hls

" Incremental search (jump while typing)
set incsearch

" Case insensitive search...
set ignorecase
" ...unless capital letters are used
set smartcase

" ============================================================================
" SPLITS & WRAPPING
" ============================================================================
" Open new splits to the right and bottom
set splitright
set splitbelow

" Do not wrap long lines
set nowrap

" ============================================================================
" INDENTATION (GLOBAL DEFAULTS)
" ============================================================================
" These are your defaults. They will be overridden by the Language Section below.
set tabstop=2       " Width of a tab character
set shiftwidth=2    " Width of an indentation level
set softtabstop=2   " Fine-tune the amount of whitespace to be inserted
set expandtab       " Use spaces instead of tabs
set autoindent      " Copy indent from previous line

" ============================================================================
" LANGUAGE SPECIFIC CONFIGURATION (AUTOCMDS)
" ============================================================================
augroup CustomIndent
  autocmd!
  " Python: Force 4 spaces
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab

  " JS, TS, React, JSON, YAML, XML: Force 2 spaces
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact,json,yaml,xml,html,css setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END

" ============================================================================
" PERSISTENT UNDO
" ============================================================================
" Keep undo history even after closing the file.
" Note: Ensure the directory ~/.vim/backup exists, or change this path.
if has('persistent_undo')
  set undodir=~/.vim/backup
  set undofile
  set undoreload=10000
endif

" ============================================================================
" CUSTOM MAPPINGS
" ============================================================================
" Insert two spaces in Normal mode
nnoremap <space> i<space><space>

" Map space in Visual mode (default behavior usually advances cursor)
vnoremap <space> <space>

" Open a new line below but stay in Normal mode
nnoremap o o<Esc>

" ============================================================================
" UTILITY FUNCTIONS
" ============================================================================
" Remove trailing whitespace on save
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup CustomUtils
    autocmd!
    " Trigger the trim function automatically when writing (saving) a file
    autocmd BufWritePre * call TrimWhitespace()
augroup END
