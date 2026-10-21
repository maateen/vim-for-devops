" =============================================================================
" VIM for DevOps
" A lightweight Vim configuration for infrastructure and automation work.
"
" Repository : https://github.com/maateen/vim-for-devops
" License    : GPL-3.0
"
" Sections:
"   1. Plugins
"   2. Theme and appearance
"   3. Editor defaults
"   4. Plugin configuration
"   5. Autocommands
"   6. Key mappings
" =============================================================================

scriptencoding utf-8

set nocompatible
set encoding=utf-8

let mapleader = ','
let maplocalleader = ','

"----------Plugins----------"
" vim-plug: https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" Theme and UI
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

" File explorer
Plug 'preservim/nerdtree', {'on': ['NERDTree', 'NERDTreeToggle', 'NERDTreeFind', 'NERDTreeFocus']}
Plug 'xuyuanp/nerdtree-git-plugin', {'on': ['NERDTree', 'NERDTreeToggle', 'NERDTreeFind', 'NERDTreeFocus']}
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', {'on': ['NERDTree', 'NERDTreeToggle', 'NERDTreeFind', 'NERDTreeFocus']}
Plug 'Yggdroot/indentLine', {'on': 'IndentLinesToggle'}

" Language server and completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Linting and formatting
Plug 'dense-analysis/ale'

" Editing
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter', {'on': 'GitGutterEnable'}

" Language support
Plug 'andrewstuart/vim-kubernetes', {'for': ['yaml', 'yml']}
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'chr4/nginx.vim', {'for': 'nginx'}
Plug 'ekalinin/Dockerfile.vim', {'for': ['dockerfile', 'Dockerfile']}
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'hashivim/vim-terraform', {'for': ['hcl', 'terraform', 'tf']}
Plug 'hashivim/vim-vagrant', {'for': ['ruby', 'vagrant']}
Plug 'pearofducks/ansible-vim', {'for': ['yaml', 'yaml.ansible', 'ansible']}
Plug 'plasticboy/vim-markdown', {'for': ['markdown', 'md']}
Plug 'stephpy/vim-yaml', {'for': ['yaml', 'yml']}
Plug 'towolf/vim-helm', {'for': ['helm', 'yaml']}
Plug 'vim-scripts/JSON.vim', {'for': 'json'}

" Utilities
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'mattn/webapi-vim'

call plug#end()

"----------Theme and appearance----------"
" onedark options must be set before loading the colorscheme.
let g:onedark_hide_endofbuffer = 1
let g:onedark_terminal_italics = 1
if !has('termguicolors')
  let g:onedark_termcolors = 256
endif

if has('termguicolors')
  set termguicolors
endif

set background=dark

filetype plugin indent on
syntax enable
try
  colorscheme onedark
catch /^Vim\%((\a\+)\)\=:E185/
  " Colorscheme is not installed yet: run :PlugInstall.
  colorscheme desert
endtry

"----------Editor defaults----------"
set fileformats=unix,dos

" Display
set number
set cursorline
set ruler
set showmatch
set showcmd
set laststatus=2
set signcolumn=yes
set scrolloff=5
set sidescrolloff=5
set splitbelow
set splitright
if has('mouse')
  set mouse=a
endif

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent

" Files and buffers
set hidden
set nobackup
set nowritebackup
set noswapfile
set autoread
set confirm
set fileencoding=utf-8
set backspace=indent,eol,start

" Persistent undo
if has('persistent_undo')
  let s:undo_dir = expand('~/.vim/undo')
  if !isdirectory(s:undo_dir)
    call mkdir(s:undo_dir, 'p')
  endif
  let &undodir = s:undo_dir
  set undofile
endif

" Command line completion
set wildmenu
set wildmode=longest:full,full
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.vscode/*
set wildignore+=*/node_modules/*,*/vendor/*,*/__pycache__/*,*/venv/*,*/.venv/*
set wildignore+=*/.terraform/*,*/.terragrunt-cache/*
set path+=**

" Completion and performance
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set complete=.,w,b,u
set updatetime=300
set lazyredraw
set ttyfast
set history=1000

" Clipboard
if has('clipboard')
  if has('unnamedplus') && !has('mac')
    set clipboard=unnamedplus
  else
    set clipboard=unnamed
  endif
endif

"----------Plugin configuration----------"
" ALE: asynchronous linting and fixing.
" CoC handles completion, so ALE completion stays disabled.
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'json': ['jq'],
\   'python': ['black', 'isort'],
\   'sh': ['shfmt'],
\   'terraform': ['terraform'],
\   'yaml': ['yamlfix'],
\}
let g:ale_linters = {
\   'ansible': ['ansible-lint'],
\   'dockerfile': ['hadolint'],
\   'python': ['mypy', 'pylint'],
\   'sh': ['shellcheck'],
\   'terraform': ['tflint'],
\   'yaml': ['yamllint'],
\}
let g:ale_python_black_options = '--skip-string-normalization'

" Airline: status line and buffer tab line.
let g:airline_theme = 'onedark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#close_symbol = '×'

" Ansible
let g:ansible_unindent_after_newline = 1
let g:ansible_attribute_highlight = 'ob'
let g:ansible_name_highlight = 'd'

" Goyo: distraction-free mode.
let g:goyo_width = '90%'
let g:goyo_height = '90%'

" Terraform/HCL
" ALE runs `terraform fmt` on save; vim-terraform formatting stays off to
" avoid formatting the buffer twice.
let g:terraform_align = 1
let g:terraform_fmt_on_save = 0

" IndentLine
let g:indentLine_enabled = 0
let g:indentLine_char = '┊'
let g:indentLine_fileTypeExclude = ['help', 'markdown', 'nerdtree', 'terminal']

" Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1

" NERDTree
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 0
let g:NERDTreeShowHidden = 0
let g:NERDTreeWinSize = 30
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeIgnore = [
\   '\.git$', '\.svn$', '\.hg$', '\.DS_Store$',
\   '\.vscode$', '\.idea$', '__pycache__$',
\   '\.terraform$', '\.terragrunt-cache$', '\.pyc$',
\]

" WebDevIcons
if has('mac')
  let g:WebDevIconsOS = 'Darwin'
endif
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:WebDevIconsUnicodeDecorateFileNodes = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" vim-go: let CoC own `gd` in Go buffers.
let g:go_def_mapping_enabled = 0

" CoC: tab completion.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ exists('*coc#pum#visible') && coc#pum#visible() ? coc#pum#next(1) :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ exists('*coc#refresh') ? coc#refresh() : "\<TAB>"

inoremap <silent><expr> <S-TAB>
      \ exists('*coc#pum#visible') && coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <C-space>
      \ exists('*coc#refresh') ? coc#refresh() : "\<C-@>"

inoremap <silent><expr> <CR>
      \ exists('*coc#pum#visible') && coc#pum#visible() ? coc#pum#confirm() :
      \ exists('*coc#on_enter') ? "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>" : "\<CR>"

" CoC: documentation for `K`.
function! s:show_documentation()
  if index(['vim', 'help'], &filetype) >= 0
    execute 'help ' . expand('<cword>')
  elseif exists('*coc#rpc#ready') && coc#rpc#ready()
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . ' ' . expand('<cword>')
  endif
endfunction

"----------Autocommands----------"
augroup nerdtree_setup
  autocmd!
  " Open NERDTree when Vim starts with a directory argument.
  autocmd StdinReadPre * let s:std_in = 1
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
        \ execute 'NERDTree' fnameescape(argv()[0]) | wincmd p | enew |
        \ execute 'cd' fnameescape(argv()[0]) | endif

  " Quit when NERDTree is the only window left.
  autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 &&
        \ exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

  " Do not let the NERDTree buffer replace the buffer it was opened from.
  autocmd BufEnter * if bufname('#') =~# 'NERD_tree_\d\+' &&
        \ bufname('%') !~# 'NERD_tree_\d\+' && winnr('$') > 1 |
        \ let buf = bufnr() | buffer# | execute 'normal! \<C-W>w' |
        \ execute 'buffer' . buf | endif
augroup END

augroup devops_filetypes
  autocmd!
  " Two-space indentation is the convention for these formats.
  autocmd FileType yaml,yaml.ansible,yml,json,jsonc,hcl,terraform,helm
        \ setlocal shiftwidth=2 tabstop=2 softtabstop=2
  " Go requires tabs; Makefiles require a literal tab.
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType make setlocal noexpandtab
augroup END

augroup terminal_setup
  autocmd!
  if has('terminal')
    autocmd TerminalOpen * setlocal nonumber norelativenumber signcolumn=no
  endif
augroup END

augroup restore_cursor
  autocmd!
  " Reopen files where the cursor was left.
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line('$') |
        \   execute "normal! g`\"" |
        \ endif
augroup END

augroup vimrc_autoreload
  autocmd!
  " Apply changes as soon as ~/.vimrc is written.
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

"----------Key mappings----------"
" Basic file operations
nmap <C-s> :w<cr>
imap <C-s> <Esc>:w<cr>a
nmap <C-w> :bd<cr>
nmap <C-z> u
nmap <C-r> <C-r>

" File navigation
nmap <C-t> :NERDTreeToggle<cr>
nmap <C-e> :NERDTreeFind<cr>

" IDE mode toggles
nmap <C-i> :GitGutterEnable<cr>:NERDTreeFind<cr>
nmap <C-g> :GitGutterEnable<cr>
nmap <C-f> :Goyo<cr>
nmap <C-d> :below terminal<cr>

" Buffer/tab navigation
nmap <leader>t :tabnew<cr>
nmap <leader>n :bnext<cr>
nmap <leader>p :bprev<cr>

" CoC.nvim navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ca <Plug>(coc-codeaction)
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Git operations
nmap <leader>gs :Git<cr>
nmap <leader>gd :Gvdiffsplit<cr>
nmap <leader>gl :Gclog<cr>

" Quick toggles
nmap <leader>i :IndentLinesToggle<cr>

" NERDCommenter also claims <leader>ca. Plugin scripts are sourced after this
" file, so re-apply the CoC mapping once plugin loading has finished.
augroup coc_keymaps
  autocmd!
  autocmd VimEnter * nmap <leader>ca <Plug>(coc-codeaction)
augroup END

"----------Local overrides----------"
" Keep machine-specific settings in ~/.vimrc.local; this file stays clean.
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
