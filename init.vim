" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'drewtempelmeyer/palenight.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'itchyny/lightline.vim'
Plug 'juandroid007/vim-multiple-cursors'
Plug 'vim-scripts/redcode.vim'
Plug 'vim-scripts/BufOnly.vim'
Plug 'sakhnik/nvim-gdb', { 'do': './install.sh' }
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/goyo.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'mhinz/vim-startify'
call plug#end()

"*****************************************************************************

let mapleader = ","

nnoremap <leader>w :w <CR>
nnoremap <leader>W :wa <CR>
nnoremap <leader>x :x <CR>
nnoremap <leader>X :xa <CR>
nnoremap <leader>q :q <CR>
nnoremap <leader>Q :qa! <CR>

nnoremap <leader>goyo :Goyo <CR>

nnoremap <leader>m :make
nnoremap <leader>M :make -B
nnoremap <leader>r :make run

map <silent> <C-o> :NERDTreeToggle<CR>
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
tnoremap <Esc> <C-\><C-n>

set laststatus=2
set noshowmode

set showcmd

set number relativenumber

function! s:goyo_enter()
   set number relativenumber
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()

set mouse=a " Permite la integración del mouse (seleccionar texto, mover el cursor)
set title

set showmatch

au BufRead,BufNewFile *.redcode,*.red set filetype=redcode

"set expandtab
set list lcs=tab:\┆\·

let g:startify_change_to_dir = 0

set nowrap " No dividir la línea si es muy larga

set cursorline " Resalta la línea actual
set colorcolumn=80 " Muestra la columna límite a 79 caracteres

set hidden  " Permitir cambiar de buffers sin tener que guardarlos

let g:clipboard = {
  \   'name': 'xclip-xfce4-clipman',
  \   'copy': {
  \      '+': 'xclip -selection clipboard',
  \      '*': 'xclip -selection clipboard',
  \    },
  \   'paste': {
  \      '+': 'xclip -selection clipboard -o',
  \      '*': 'xclip -selection clipboard -o',
  \   },
  \   'cache_enabled': 1,
  \ }

"******* Colorscheme *********************************************************
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if(has("termguicolors"))
	set termguicolors  " Activa true colors en la terminal
endif

set t_ut=
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

set background=light  " Fondo del tema: light o dark
let g:palenight_terminal_italics=1
colorscheme palenight  " Nombre del tema
let g:lightline = {
      \ 'colorscheme': 'palenight',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ],
      \             [ 'neobimu' ] ]
      \ },
      \ 'component': {
      \   'neobimu': 'ネオビム'
      \ },
      \ }
"*****************************************************************************
