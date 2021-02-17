set nocompatible
set hidden
" Filetype
filetype plugin indent on
syntax on " Still don't really understand this one
set timeoutlen=500
" Display
set rnu
set nu
set showcmd
set bg=dark
set ruler

" Text Rendering
set encoding=utf-8 " For funny characters
set linebreak

" Indentation
set autoindent
set expandtab
set shiftwidth=4
set smarttab
set tabstop=4

" Folding
set foldmethod=indent
set foldnestmax=3
set history=100

" Search
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

" MAPPINGS
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

let mapleader = " "
nnoremap <leader>w :w<CR>

" Search
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap <CR> :noh<CR>

" Plug vim: plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins 
call plug#begin('~/.vim/bundle')

Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround', {'branch': 'master'}
Plug 'tpope/vim-repeat', {'branch': 'master'}
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree', {'branch': 'master'}
Plug 'tpope/vim-fugitive', {'branch': 'master'}
Plug 'christoomey/vim-tmux-navigator', {'branch': 'master'}
Plug 'morhetz/gruvbox'
Plug 'janko-m/vim-test'
Plug 'iamcco/markdown-preview.nvim', {'do' : { ->  mkdp#util#install()}}
Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'psf/black'
Plug 'tranvansang/vim-close-pair'
Plug 'jpalardy/vim-slime'
Plug 'heavenshell/vim-pydocstring', {'do': 'make install'}

call plug#end()

" Python Interpreter
let g:python3_host_prog = '~/miniconda3/envs/nvim/bin/python'

" -------------------------------------------
" -------- End of non-plugin related settings 
" ------------------------------------------- 

if empty(glob("~/.vim/bundle"))
  echo "Please run :PlugInstall for plugin functionality"
  exit
endif

" ------------------------------------------- 
" -------- Start of plugin related settings 
" ------------------------------------------- 


" Vim Test
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" Disable arrow keys for learning
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Colors
set t_Co=256
colorscheme gruvbox

" NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" CTRL-P
let g:crtlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'


let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" Snippets
let g:UltiSnipsExpandTrigger="<tab>"
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Slime
if exists('$TMUX')
	let g:slime_target = "tmux"
	let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
endif
let g:slime_python_ipython = 1

" PyDocString
nmap <silent> <leader>i <Plug>(pydocstring)
let g:pydocstring_formatter = 'sphinx'
let g:pydocstring_enable_comment = 0

