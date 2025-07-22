"----------Plugins----------"
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Theme/Visual Plugins
Plug 'joshdick/onedark.vim'

" UI/Interface Plugins
Plug 'preservim/nerdtree', {'on':['NERDTree','NERDTreeToggle','NERDTreeFind','NERDTreeFocus']}
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', {'on':['NERDTree','NERDTreeToggle','NERDTreeFind','NERDTreeFocus']}
Plug 'xuyuanp/nerdtree-git-plugin', {'on':['NERDTree','NERDTreeToggle','NERDTreeFind','NERDTreeFocus']}
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
"" Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine', {'on': 'IndentLinesToggle'}

" Code Intelligence/LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Code Quality/Linting
Plug 'dense-analysis/ale'
Plug 'cappyzawa/trim.nvim'

" Editing Enhancement
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'

" Git Integration
Plug 'airblade/vim-gitgutter', {'on':'GitGutterEnable'}
Plug 'tpope/vim-fugitive'

" Language Support
Plug 'andrewstuart/vim-kubernetes', {'for': ['yaml', 'yml']}
Plug 'cespare/vim-toml', {'for':'toml'}
Plug 'chr4/nginx.vim', {'for':'nginx'}
Plug 'ekalinin/Dockerfile.vim', {'for':'dockerfile'}
Plug 'fatih/vim-go', {'for':'go'}
Plug 'hashivim/vim-terraform', {'for':['hcl','terraform','tf']}
Plug 'hashivim/vim-vagrant', {'for':['vagrant','Vagrantfile']}
Plug 'pearofducks/ansible-vim', {'for': 'ansible'}
Plug 'plasticboy/vim-markdown', {'for':['markdown','md']}
Plug 'stephpy/vim-yaml', {'for':['yaml', 'yml']}
Plug 'towolf/vim-helm', {'for': 'helm'}
Plug 'vim-scripts/JSON.vim', {'for': 'json'}

" Utilities
Plug 'junegunn/goyo.vim', {'on':'Goyo'}
Plug 'mattn/webapi-vim'

call plug#end()

"----------Theme-----------"
set termguicolors
set background=dark
colorscheme onedark
let g:onedark_termcolors=256
let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1

"----------Basic Configs----------"
syntax on
filetype plugin indent on
set nocompatible
set encoding=UTF-8
set fileformat=unix

" Display settings
set number
set cursorline
set ruler
set showmatch
set laststatus=2

" Search settings
set hlsearch incsearch

" Indentation settings
set tabstop=4 shiftwidth=4 softtabstop=4
set expandtab autoindent smartindent

" File handling
set nobackup noswapfile nowritebackup
set backspace=indent,eol,start

" Performance settings
set complete=.,w,b,u
set updatetime=100
set lazyredraw
set ttyfast

"----------Status Line--------------"
set statusline=
set statusline+=\ %Y\ %F\ %M\ %R
set statusline+=%=
set statusline+=\ row:\ %l\ col:\ %c\ percent:\ %p%%

"----------Plugin Configs----------"
" ALE (Asynchronous Lint Engine)
let g:ale_fix_on_save = 1
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
\   'terraform': ['terraform', 'tflint'],
\   'yaml': ['yamllint'],
\}
let g:ale_python_black_executable = '/opt/homebrew/bin/black'
let g:ale_python_black_options = '--skip-string-normalization'
let g:ale_python_mypy_executable = '/opt/homebrew/bin/mypy'
let g:ale_python_mypy_options = ''

" Airline (Status/tabline)
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#close_symbol = '×'
let g:airline#extensions#tabline#buffer_idx_mode = 1

" Ansible
let g:ansible_unindent_after_newline = 1
let g:ansible_attribute_highlight = "ob"
let g:ansible_name_highlight = 'd'

" Goyo (Distraction-free writing)
let g:goyo_width='100%'
let g:goyo_height='100%'

" HCL/Terraform
let g:hcl_align=1
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" IndentLine
let g:indentLine_enabled = 0
let g:indentLine_char = '┊'

" Markdown
let g:vim_markdown_folding_disabled=1

" NERDTree (File explorer)
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=0
let g:NERDTreeShowHidden=0
let g:NERDTreeWinSize=30
let g:NERDTreeShowBookmarks=1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeRespectWildIgnore=1
let g:NERDTreeIgnore=['\.git$', '\.svn$', '\.hg$', '\.DS_Store$', '\.devcontainer$', '\.vscode$', '__pycache__$', '\.terraform$', '\.terraform\.lock\.hcl$', '\.terragrunt-cache$', '\.pyc$']

" WebDevIcons (File type icons)
let g:WebDevIconsOS='Darwin'
let g:webdevicons_enable=1
let g:webdevicons_enable_nerdtree=1
let g:WebDevIconsUnicodeDecorateFileNodes=1
let g:webdevicons_conceal_nerdtree_brackets=1
let g:WebDevIconsUnicodeDecorateFolderNodes=1

" CoC.nvim: Tab completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" CoC.nvim: Trigger completion and confirm selection
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" CoC.nvim: Documentation function
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"----------Auto Commands----------"
" Start NERDTree when Vim starts with a directory argument
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" NERDTree buffer management
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Exit Vim if NERDTree is the only window remaining
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Auto-source vimrc on save
augroup autosourcing
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup END

"----------Key Mappings----------"
let mapleader = ','

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
