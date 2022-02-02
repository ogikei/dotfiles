" ========== General ==========
set display=uhex
set hidden
set hlsearch
set ignorecase
set incsearch
set infercase
set matchtime=3
set shiftround
set showmatch
set switchbuf=useopen
set smartcase
set virtualedit=all
set encoding=utf-8
set t_Co=256

set backspace=indent,eol,start
imap ^H <Left><Del>
imap ^D <Right><Del>

set nowritebackup
set nobackup
set noswapfile

set number
set wrap
set textwidth=0
set colorcolumn=80

set t_vb=
set novisualbell

set tabstop=2
set expandtab
set fileencoding=utf-8
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2
set cursorline
set guifont=MyFont\ for\ Powerline

hi clear CursorLine
hi CursorLine gui=underline
" syntax on

scriptencoding utf-8

inoremap jj <Esc>

cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

nnoremap j gj
nnoremap k gk

vnoremap v $h
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

nmap <silent> <Esc><Esc> :nohlsearch<CR>

" plugin
call plug#begin('~/.vim/plugged')

Plug 'ayu-theme/ayu-vim'
set termguicolors     " enable true colors support
let ayucolor = "light"  " for light version of theme
colorscheme ayu

Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='ayu'

call plug#end()
