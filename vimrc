"----------Plugins----------"
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'joshdick/onedark.vim'

" Insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'

" Comment smartly
Plug 'preservim/nerdcommenter'

" On-demand loading
Plug 'airblade/vim-gitgutter', {'on':'GitGutterEnable'}
Plug 'junegunn/goyo.vim', {'on':'Goyo'}
Plug 'preservim/nerdtree', {'on':['NERDTree','NERDTreeToggle','NERDTreeFind','NERDTreeFocus']}
Plug 'xuyuanp/nerdtree-git-plugin', {'on':['NERDTree','NERDTreeToggle','NERDTreeFind','NERDTreeFocus']}
Plug 'ryanoasis/vim-devicons', {'on':['NERDTree','NERDTreeToggle','NERDTreeFind','NERDTreeFocus']}
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', {'on':['NERDTree','NERDTreeToggle','NERDTreeFind','NERDTreeFocus']}
Plug 'ekalinin/Dockerfile.vim', {'for':'dockerfile'}
Plug 'fatih/vim-go', {'for':'go'}
Plug 'plasticboy/vim-markdown', {'for':['markdown','md']}
Plug 'chr4/nginx.vim', {'for':'nginx'}
Plug 'hashivim/vim-terraform', {'for':['hcl','terraform','tf']}
Plug 'cespare/vim-toml', {'for':'toml'}
Plug 'hashivim/vim-vagrant', {'for':['vagrant','Vagrantfile']}
Plug 'stephpy/vim-yaml', {'for':['yaml', 'yml']}

call plug#end()

"----------Theme-----------"
set termguicolors
let g:onedark_termcolors=256
let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
colorscheme onedark

"----------Basic configs----------"
retab
syntax on
filetype on
filetype plugin indent on
set background=dark
set number
set nobackup
set nocompatible
set cursorline
set encoding=UTF-8
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
set updatetime=100
set hlsearch
set incsearch

"----------Status Line--------------"
set statusline=
set statusline+=\ %Y\ %F\ %M\ %R
set statusline+=%=
set statusline+=\ row:\ %l\ col:\ %c\ percent:\ %p%%
set laststatus=2

"----------Plugins Configs----------"
let g:goyo_width='100%'
let g:goyo_height='100%'
let g:vim_markdown_folding_disabled=1
let g:hcl_align=1
let g:terraform_align=1
let g:terraform_fmt_on_save=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=0
let g:NERDTreeShowHidden=0
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeRespectWildIgnore=1
let g:NERDTreeIgnore=['\.git$','\.svn$','\.hg$','\.DS_Store$','\.devcontainer$','\.vscode$','__pycache__$','\.terraform$','\.terraform.lock.hcl$','\.terragrunt-cache$','\.pyc$']
let g:WebDevIconsOS='Darwin'
let g:webdevicons_enable=1
let g:webdevicons_enable_nerdtree=1
let g:WebDevIconsUnicodeDecorateFileNodes=1
let g:webdevicons_conceal_nerdtree_brackets=1
let g:WebDevIconsUnicodeDecorateFolderNodes=1

"----------Shortcuts----------"
let mapleader = ','

" Toggle IDE mode in VIM
nmap <C-i> :GitGutterEnable<cr>:NERDTreeFind<cr>

" Toggle GitGutter
nmap <C-g> :GitGutterEnable<cr>

" Toggle Fullscreen mode
nmap <C-f> :Goyo<cr>

" Toggle Terminal below current tab
nmap <C-d> :below terminal<cr>

" make NERDTree easier
nmap <C-t> :NERDTreeToggle<cr>
nmap <C-n> :NERDTreeFind<cr>

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

" Automatically source the Vimrc file on save.
augroup autosourcing
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup END
