
call plug#begin('~/.vim/plugged')
" Minimal UI plugins for statusline and colorscheme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'
call plug#end()

" Basic setup
set nocompatible
set shortmess+=I
set noerrorbells visualbell t_vb=

" Color and Syntax
syntax on
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set termguicolors
set background=dark
colorscheme onedark

" Airline configuration
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Tab/Space Setup
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftround
let g:pyindent_open_paren=shiftwidth()

" General Editor Settings
set clipboard=unnamed
set autoindent
set breakindent
set number
set relativenumber
set laststatus=2
set display+=lastline
set showmode
set showcmd
set backspace=indent,eol,start
set cursorline
set wrapscan

" Search & UI
set ignorecase
set smartcase
set incsearch
set hlsearch 
set mouse+=a
set scrolloff=8
set wildmenu
set wildmode=longest:full,full

" Make leaving insertion mode quick
set timeout 
set ttimeout
set ttimeoutlen=100
set timeoutlen=1000

" Key Re-mappings
let mapleader = "\<Space>"
nnoremap <leader>cd :cd %:p:h<CR>
nnoremap <leader>/  :noh<CR>

" Window navigation
nnoremap <c-h>  <c-w>h
nnoremap <c-j>  <c-w>j
nnoremap <c-k>  <c-w>k
nnoremap <c-l>  <c-w>l

" Exit insert mode with jk 
inoremap jk <c-[>
