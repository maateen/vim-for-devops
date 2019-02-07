"----------Plugins----------"
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'rakr/vim-one'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ekalinin/Dockerfile.vim', { 'for': 'docker' }
Plug 'chr4/nginx.vim', { 'for': 'nginx' }
Plug 'lepture/vim-jinja', { 'for': 'jinja'}

" Initialize plugin system
call plug#end()

" True color support
if (empty($TMUX))
  if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

"----------Basic configs----------"
retab
filetype plugin indent on
syntax on
colorscheme one
set background=dark
set number
set nocompatible
set encoding=utf-8
set ruler
set showmatch
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autowriteall
set autoindent
set visualbell
set smartindent
set fileformat=unix
set backspace=indent,eol,start
set complete=.,w,b,u
set hlsearch
set incsearch
" set textwidth=79

let mapleader = ','

"----------Special Configs----------"
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

" Automatically source the Vimrc file on save.
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END

"----------Plugins Configs----------"

"make NERDTree easier to toggle
nmap <Leader><Bslash> :NERDTreeToggle<cr>
