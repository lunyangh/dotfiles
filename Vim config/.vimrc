" Comments in Vimscript start with a `"`.

" some predefined variables 

" ********* Basic setup **********
set nocompatible
set shortmess+=I                        " Disable the default Vim startup message.
set noerrorbells visualbell t_vb=       " Disable audible bell because it's annoying.

" ********** Vundle Setup ***********
" First already in there 
"set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"***************** Plugins added myself **************
" Nice status line 
Plugin 'vim-airline/vim-airline'    
" fuzzy file search
Plugin 'junegunn/fzf'               
Plugin 'junegunn/fzf.vim'
Plugin 'preservim/nerdtree'


" ************* example plugins ****************
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ


" ********** configuration for plugins *************

" NERDTree 
let g:NERDTreeShowLineNumbers=1         " show line number for better navigation



" ************ non-plugin setup ***********
" filetype setup already in Vundle part below.
"filetype plugin indent on              " Load plugins according to detected filetype, 

" Turn on syntax highlighting.
syntax on

" ensuring encoding is correct
if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif


" ************ font and colorscheme *************
" enable true color 
" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

" For Neovim > 0.1.5 and Vim > patch 7.4.1799 - https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
" Based on Vim patch 7.4.1770 (`guicolors` option) - https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
if (has('termguicolors'))
  set termguicolors
endif

" setup color theme 
"set t_Co=256
"let g:material_theme_style = 'darker'
colorscheme onedark 



" *********** Other setup **********
" tab/space setup 
set softtabstop=4       " tab to space 
set shiftwidth=4        " Tab key indents by 4 spaces
set expandtab           " insert spaces when type tabs 
set shiftround          " >> indents adjust to multiple of 'shiftwidth'
" indent 
set autoindent          " Indent according to previous line
set smartindent         " Smart indent accoding to file type 
" Show line numbers.
set number
set relativenumber
" Status bar
set laststatus=2        " Always show the status line at the bottom.
set display+=lastline  " Show as much as possible of the last line 
set showmode            " show current mode in command line
set showcmd             " show partially typed command
set backspace=indent,eol,start " make backspace able to delete in insertion mode freely.
set report=0            " report any line changes
set synmaxcol=300     " only highlight the first 300 columns 
" additional display
set cursorline          " find current line easily 
set wrapscan            " searches wrap around end-of-line, go to top when hit bottom 
" allow line numbers in file explorer netrw 
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
" Show non-printable characters.
set list                   
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif
" buffer 
set hidden              " allow hidden buffer when changes not saved
" window
set splitbelow          " :split split the new window on below 
set splitright          " :vsplit split the new window on the right
" case insensitive search
set ignorecase
set smartcase
" increaemntal search and highlight 
set incsearch
set hlsearch 
" Enable mouse support.
set mouse+=a
" minimal lines of below and above cursor
set scrolloff=8
" menu of autocompletion in command line mode 
set wildmenu
set wildmode=longest:full,full

" ************** backup setting *****************
" Put all temporary files under the same directory.
" https://github.com/mhinz/vim-galore#handling-backup-swap-undo-and-viminfo-files
set backup                      " create backup files for current editing file
set backupdir   =$HOME/.vim/files/backup/   " directory to save backup file
set backupext   =-vimbackup                 " string added to backup file's name 
set backupskip  =                           " skip certain file types when start backup, see helpfile

set directory   =$HOME/.vim/files/swap//    " directory to save swap file
set noswapfile                              " no swapfiles 
set updatecount =100                        " minimal string to update swap file

set undofile                                " set undofile 
set undodir     =$HOME/.vim/files/undo/     " directory of undofile
set viminfo     ='100,n$HOME/.vim/files/info/viminfo "save vim session information

" *************** remap keybinds ***************
" Setup leader key and related mapping 
let mapleader = "," 
" let localmapleader = "\<space>" " check ':h localleader?'



" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.
" shut down arrow keys to prevent bad habits
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>














