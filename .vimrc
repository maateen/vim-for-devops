"----------Plugins----------"
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rakr/vim-one'
Plug 'airblade/vim-gitgutter'
Plug 'hdima/python-syntax'
Plug 'itchyny/lightline.vim'
Plug 'Shougo/neocomplete.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'davidhalter/jedi-vim'
Plug 'tpope/vim-vinegar'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'joshdick/onedark.vim'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'ervandew/supertab'
call plug#end()

"----------Basic configs----------"
retab
set nocompatible
filetype plugin indent on
syntax enable
set encoding=utf-8
set ruler
set showmatch
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autowriteall
set textwidth=79
set autoindent
set visualbell
set smartindent
set fileformat=unix
set backspace=indent,eol,start
set complete=.,w,b,u
set hlsearch
set incsearch

let mapleader = ','

"----------Special Configs----------"
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

" Do not keep a backup file, use versions instead
if has("vms")
    set nobackup
else
    set backup
endif
set history=50
set showcmd
set incsearch

" Automatically source the Vimrc file on save.
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END

" Enableing mouse
if has('mouse')
    set mouse=a
endif

" GVIM configs
set guifont=Monaco\ 14
if has('gui_running')
    set lines=999 columns=999
endif

"----------True color support----------"
if (empty($TMUX))
  if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

"----------Plugins Configs----------"
" Airline configs
let g:airline_theme='one'
let g:airline#extensions#tabline#enabled = 1

" GitGutter configs
let g:gitgutter_max_signs = 500

" Syntax configs
set t_CO=256
set background=dark
let g:one_allow_italics = 1
colorscheme one
set number
set laststatus=2
let python_highlight_all = 1

" Neocomplete configs
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

" YCM configs
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_min_num_identifier_candidate_chars = 0
let g:ycm_auto_trigger = 1
let g:ycm_filetype_whitelist = { '*': 1 }
let g:ycm_filetype_specific_completion_to_disable = {'gitcommit': 1}
let g:ycm_show_diagnostics_ui = 1
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>>'
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_echo_current_diagnostic = 1
let g:ycm_always_populate_location_list = 0
let g:ycm_open_loclist_on_ycm_diags = 1
let g:ycm_allow_changing_updatetime = 1
let g:ycm_complete_in_comments = 0
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_seed_identifiers_with_syntax = 0

let g:ctrlp_custom_ignore = 'node_modules\DS_Store\|git'
let NERDTreeHijackNetrw = 0

" Jedi configs
let g:jedi#popup_on_dot = 0
autocmd FileType python setlocal completeopt-=preview

"-------------Split Management---------------"
set splitbelow                      " set split below to the current one
set splitright                      " set vertical split right to the current one

"-------------Shortcut Mapping---------------"
" Basic shortcuts
:map <M-s> :w<kEnter>
:imap <M-s> <Esc>:w<kEnter>i
:map <M-w> :wq<kEnter>
:imap <M-s> <Esc>:wq<kEnter>

" Python3 dedicated shortcut
nmap <Leader><F5> :!clear;python3 %<CR>
nmap <Leader><F6> :!clear;autopep8 --in-place --aggressive --aggressive %<CR>

" We'll set simpler mappings to switch between splits.
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>

"Make it easy to edit the Vimrc file.
nmap <Leader>ev :tabedit $MYVIMRC<cr>

"Add simple highlight removal.
nmap <Leader><space> :nohlsearch<cr>

"make NERDTree easier to toggle
nmap <Leader><Bslash> :NERDTreeToggle<cr>

"search methods name on a file
nmap <C-r> :CtrlPBufTag<cr>

"browse most recently visited files
nmap <D-e> :CtrlPMRUFiles<cr>

"search ctags
nmap <Leader>f :tag<space>

" tabularize plugin for auto alignment
nmap <Leader>a :Tabularize /
vmap <Leader>a :Tabularize /
