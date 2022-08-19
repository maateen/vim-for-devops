"----------Plugins----------"
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'lifepillar/vim-solarized8'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Insert or delete brackets, parens, quotes in pair
Plug 'tpope/vim-surround'

" Comment smartly
Plug 'preservim/nerdcommenter'

" On-demand loading
Plug 'airblade/vim-gitgutter', {'on':'GitGutterEnable'}
Plug 'junegunn/goyo.vim', {'on':'Goyo'}
Plug 'preservim/nerdtree', {'on':'NERDTreeToggle'}
Plug 'xuyuanp/nerdtree-git-plugin', {'on':'NERDTreeToggle'}
Plug 'ryanoasis/vim-devicons', {'on':'NERDTreeToggle'}
Plug 'ekalinin/Dockerfile.vim', {'for':'docker'}
Plug 'fatih/vim-go', {'for':'go'}
Plug 'plasticboy/vim-markdown', {'for':['markdown', 'md']}
Plug 'chr4/nginx.vim', {'for':'nginx'}
Plug 'hashivim/vim-terraform', {'for':['terraform', 'tf']}
Plug 'cespare/vim-toml', {'for':['toml']}
Plug 'hashivim/vim-vagrant', {'for':['vagrant', 'Vagrantfile']}
Plug 'stephpy/vim-yaml', {'for':['yaml', 'yml']}
Plug 'jvirtanen/vim-hcl', {'for':'hcl'}

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

"----------Theme-----------"
colorscheme solarized8

"----------Basic configs----------"
retab
syntax on
filetype on
filetype plugin indent on
set background=light
set number
set nobackup
set nocompatible
set cursorline
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

"----------Status Line--------------"
set statusline=
set statusline+=\ %Y\ %F\ %M\ %R
set statusline+=%=
set statusline+=\ row:\ %l\ col:\ %c\ percent:\ %p%%
set laststatus=2

" Automatically source the Vimrc file on save.
augroup autosourcing
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup END

"----------Plugins Configs----------"
let g:goyo_width='100%'
let g:goyo_height='100%'
let g:vim_markdown_folding_disabled=1
let g:terraform_align=1
let g:terraform_fmt_on_save=1
let g:NERDTreeShowHidden=1
let g:NERDTreeRespectWildIgnore=1
let g:NERDTreeIgnore=['\.DS_Store$','\.git$','\.devcontainer$']

"----------Shortcuts----------"
let mapleader = ','

" make GitGutter easier to toggle
nmap <Leader>g :GitGutterEnable<cr>

"Toggle Fullscreen mode
nmap <Leader>f : Goyo<cr>

"make NERDTree easier
nmap <Leader><Bslash> :NERDTreeToggle<cr>
nmap <Leader>n :NERDTreeFocus<cr>

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
