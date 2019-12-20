" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')
Plug 'ntpeters/vim-better-whitespace'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'ciaranm/inkpot'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'romainl/Apprentice'
Plug 'nanotech/jellybeans.vim'

Plug 'jiangmiao/auto-pairs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'itchyny/lightline.vim'
"Plug 'juandroid007/vim-multiple-cursors'
Plug 'vim-scripts/redcode.vim'
Plug 'vim-scripts/BufOnly.vim'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/goyo.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'mhinz/vim-startify'

Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

Plug 'digitaltoad/vim-pug'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'rust-lang/rust.vim'
Plug 'zah/nim.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'posva/vim-vue'
Plug 'ron-rs/ron.vim'
Plug 'neovimhaskell/haskell-vim'
"Plug 'itchyny/vim-haskell-indent'

"Plug 'Valloric/YouCompleteMe', { 'do': ':!./install.py --all' }
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

"Plug 'roxma/nvim-yarp'
"Plug 'lifepillar/vim-mucomplete'

Plug 'Shougo/echodoc.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'honza/vim-snippets'

" LanguageServer client for NeoVim.
"Plug 'autozimu/LanguageClient-neovim', {
"  \ 'branch': 'next',
"  \ 'do': 'bash install.sh',
"  \ }

call plug#end()

let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
let g:instant_markdown_allow_unsafe_content = 1
let g:instant_markdown_mathjax = 1

"* ncm2 and LanguageClient configs *******************************************
"let g:LanguageClient_serverCommands = {
"  \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
"  \ 'javascript': ['javascript-typescript-stdio'],
"  \ 'typescript': ['javascript-typescript-stdio'],
"  \ 'ruby': ['solargraph', 'stdio'],
"  \ 'python': ['pyls'],
"  \ 'cpp': ['clangd'],
"  \ }
"
"let g:LanguageClient_autoStart = 1
"
"" Remove 'tag' type from c-n completion. Call it explicitly via mucomplete instead.
"set complete=.,w,b,u,k
"set completeopt=menuone,noselect
"" Shut off completion messages
"set shortmess+=c
"
"let g:mucomplete#enable_auto_at_startup = 1
"
"set signcolumn=no
"
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()

let g:coc_snippet_next = '<tab>'

inoremap <silent><expr> <c-space> coc#refresh()

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

"*****************************************************************************

func! WordProcessor()
	" movement changes
	map j gj
	map k gk
	map <Down> gj
	map <Up> gk
	imap <Down> <C-o>gj
	imap <Up> <C-o>gk
	" formatting text
	setlocal formatoptions=1
	setlocal noexpandtab
	setlocal wrap
	setlocal linebreak
	" spelling and thesaurus
	:Goyo
	setlocal nonumber norelativenumber
endfu
com! WP call WordProcessor()

func! MarkdownProcessor()
	" formatting text
	setlocal formatoptions+=a
	setlocal noexpandtab
	setlocal wrap
	setlocal linebreak
	:Goyo
	setlocal nonumber norelativenumber
	let b:coc_suggest_disable = 1
endfu
com! MD call MarkdownProcessor()

"*****************************************************************************
" With this function you can reuse the same terminal in neovim.
" You can toggle the terminal and also send a command to the same terminal.

let s:split_terminal_window = -1
let s:split_terminal_buffer = -1
let s:split_terminal_job_id = -1

function! SplitTerminalOpen()
	" Check if buffer exists, if not create a window and a buffer
	if !bufexists(s:split_terminal_buffer)
		" Creates a window call split_terminal
		new split_terminal
		" Moves to the window the right the current one
		wincmd J
		resize 12
		let s:split_terminal_job_id = termopen($SHELL, { 'detach': 1 })

		" Change the name of the buffer to "Terminal"
		silent file Terminal
		" Gets the id of the terminal window
		let s:split_terminal_window = win_getid()
		let s:split_terminal_buffer = bufnr('%')

		setlocal nonumber norelativenumber

		" The buffer of the terminal won't appear in the list of the buffers
		" when calling :buffers command
		set nobuflisted
	else
		if !win_gotoid(s:split_terminal_window)
			sp
			" Moves to the window below the current one
			wincmd J
			resize 12
			buffer Terminal
			" Gets the id of the terminal window
			let s:split_terminal_window = win_getid()
		endif
	endif
endfunction

function! SplitTerminalToggle()
	if win_gotoid(s:split_terminal_window)
		call SplitTerminalClose()
	else
		call SplitTerminalOpen()
	endif
endfunction

function! SplitTerminalClose()
	if win_gotoid(s:split_terminal_window)
		" close the current window
		hide
	endif
endfunction

function! SplitTerminalExec(cmd)
	if !win_gotoid(s:split_terminal_window)
		call SplitTerminalOpen()
	endif

	" clear current input
	call jobsend(s:split_terminal_job_id, "clear\n")

	" run cmd
	call jobsend(s:split_terminal_job_id, a:cmd . "\n")
	normal! G
	wincmd p
endfunction

nnoremap <silent> <F7> :call SplitTerminalToggle()<CR>

"*****************************************************************************

let mapleader = ","

nnoremap <leader>w :w <CR>
nnoremap <leader>W :wa <CR>
nnoremap <leader>x :x <CR>
nnoremap <leader>X :xa <CR>
nnoremap <leader>q :q <CR>
nnoremap <leader>Q :qa! <CR>

nnoremap <leader>goyo :Goyo <CR>

nnoremap <leader>p :CtrlPTag <CR>

nnoremap <leader>m :make
nnoremap <leader>M :make -B
nnoremap <leader>r :make run

com! Bear :!make

map <silent> <C-o> :NERDTreeToggle<CR>
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
tnoremap <Esc> <C-\><C-n>

"******* Highligh trailing spaces ********************************************
"highlight ExtraWhitespace ctermbg=red guibg=red
"
"autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
"autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"autocmd InsertLeave * match ExtraWhitespace /\s\+$/
"autocmd BufWinLeave * call clearmatches()
"*****************************************************************************

set laststatus=2
set noshowmode

autocmd FileType haskell setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType vue setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

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

" set expandtab
set list lcs=tab:\┆\·

" Startify
autocmd User Startified setlocal cursorline
let g:startify_change_to_dir = 0
let g:startify_bookmarks = [ { 'c': '~/.config/nvim/init.vim' } ]

" CtrlP
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/]\.(git|hg|svn)$',
			\ 'file': '\v\.(o|d)$'
			\ }

if executable('fd')
	let g:ctrlp_user_command = 'fd --type f --color never "" %s'
	let g:ctrlp_use_caching = 0
endif

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

"YCM preview window autoclose
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"let g:ycm_confirm_extra_conf = 0
"
"let g:ycm_language_server =
"  \ [
"  \   {
"  \     'name': 'ruby',
"  \     'cmdline': [ expand( '$HOME/.lsp/ruby/bin/solargraph' ), 'stdio' ],
"  \     'filetypes': [ 'ruby' ],
"  \   }
"  \ ]

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

" set background=light  " Fondo del tema: light o dark
let g:palenight_terminal_italics=1
colorscheme palenight  " Nombre del tema


function! CocCurrentFunction()
	return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
			\ 'colorscheme': 'palenight',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ],
			\             [ 'neobimu' ] ]
			\ },
			\ 'component': {
			\   'neobimu': 'ネオビム'
			\ },
			\ 'component_function': {
			\   'cocstatus': 'coc#status',
			\   'currentfunction': 'CocCurrentFunction'
			\ },
			\ }

"*****************************************************************************
