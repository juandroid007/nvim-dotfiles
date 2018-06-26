" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'drewtempelmeyer/palenight.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'Yggdroot/indentLine'
call plug#end()

"*****************************************************************************

map <silent> <C-o> :NERDTreeToggle<CR>
let NERDTreeAutoDeleteBuffer = 1
tnoremap <Esc> <C-\><C-n>

set laststatus=2
set noshowmode

set number " Muestra los números de las líneas
set mouse=a " Permite la integración del mouse (seleccionar texto, mover el cursor)
set title

set showmatch

"set expandtab
set list lcs=tab:\┆\·

"****** Multi Cursor Parammeters *********************************************
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<C-m>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<C-m>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
"*****************************************************************************

set nowrap " No dividir la línea si es muy larga

set cursorline " Resalta la línea actual
set colorcolumn=79 " Muestra la columna límite a 79 caracteres

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
let g:lightline = { 'colorscheme': 'palenight' }
"*****************************************************************************
