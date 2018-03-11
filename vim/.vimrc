"General settings
set number
syntax on
set autoindent
"set foldmethod=syntax
"set foldcolumn=3
let mapleader=","
set undodir=~/.vim/undo//
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set ruler
set showcmd
set incsearch
set nojoinspaces
set textwidth=80
set numberwidth=4
set splitbelow
set splitright

"Key remappings
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
nnoremap ; :
nnoremap : ;
imap jk <esc>

"Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Plug
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'altercation/vim-colors-solarized'
Plug 'lervag/vimtex'
call plug#end()
set background=dark
colorscheme solarized

"Nerdtree
"Open on startup if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <F1> ;NERDTreeToggle<CR>
nnoremap <F2> ;NERDTreeFocus<CR>
let NERDTreeShowHidden=1
let g:NetrwIsOpen=0

"Close if only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"Lightline
set laststatus=2
set noshowmode
let g:lightline = {
	\ 'colorscheme': 'solarized', 
	\ 'active': {
	\ 	'left': [ [ 'mode', 'paste' ],
	\ 	    	[ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
	\	'right': [ 
	\		[ 'lineinfo' ],
	\		[ 'percent' ],
	\		[ 'filetype' ] ]
	\ },
	\ 'component_function': {
	\ 'gitbranch': 'fugitive#head'
	\ },
	\ }

"Syntasic
set statusline+=\ set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
