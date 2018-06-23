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
call plug#end()

"**********************************************************************************************************************

"NERDTreeToggle
"autocmd vimenter * NERDTree
map <silent> <C-n> :NERDTreeToggle<CR>
let NERDTreeAutoDeleteBuffer = 1
tnoremap <Esc> <C-\><C-n>

set number " Muestra los números de las líneas
set mouse=a " Permite la integración del mouse (seleccionar texto, mover el cursor)
set title

set showmatch

set nowrap " No dividir la línea si es muy larga

set cursorline " Resalta la línea actual
set colorcolumn=120  " Muestra la columna límite a 120 caracteres

set hidden  " Permitir cambiar de buffers sin tener que guardarlos

set termguicolors  " Activa true colors en la terminal
set background=dark  " Fondo del tema: light o dark
let g:palenight_terminal_italics=1
colorscheme palenight  " Nombre del tema
let g:lightline = { 'colorscheme': 'palenight' }
"let g:lightline.colorscheme = 'palenight'
