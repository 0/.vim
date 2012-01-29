set nocompatible

" Load all plugins with Vundle
source ~/.vim/bundles.vim

" General options {{{
set exrc                          " Also search for vimrc in pwd
set shortmess=aI                  " Shorten all messages; don't show intro
set wildmode=longest,list         " Better file tab completion
set tabstop=4                     " A 4-space tab seems reasonable
set shiftwidth=4
set hlsearch                      " Highlight search results
set incsearch                     " Search as you type
set ignorecase                    " Ignore case when searching
set smartcase                     " But not always
set virtualedit=block             " Allow block selection to go anywhere
set scrolloff=5                   " Keep 5 lines when scrolling
set laststatus=2                  " Always show a statusline
set showcmd                       " Show command typed, selection size
set hidden                        " Allow hidden buffers
set visualbell t_vb=              " Disable vbell
set background=dark               " Light-on-dark
if has("gui_macvim")
	set guifont=Menlo\ Regular:h12
else
	set guifont=Fixed\ 11
endif
if has("gui_running")
	set showtabline=2             " Always show the tab bar
endif
set number                        " Show line numbers
if exists('+colorcolumn')
	set colorcolumn=80            " Hilight the 80th column
endif
set foldmethod=marker             " Fold on markers
set foldcolumn=1                  " Show folds
set list                          " Show whitespace
set listchars=tab:»·,trail:·,nbsp:%
set display=uhex                  " Show nonprintables as <xx>
set pastetoggle=<F2>              " Toggle :set paste/nopaste
if has("persistent_undo")
	set undodir=~/.vim/undodir
	set undofile
	set undolevels=1000
	set undoreload=10000
endif
set spelllang=en_ca               " Canadian English

syntax enable                     " Syntax higlighting
filetype plugin indent on         " Filetype-specific options

" Key mappings {{{
let mapleader = ","

noremap  <F1> <ESC>
inoremap <F1> <ESC>

" Toggle spell checking.
nnoremap <silent> <leader>sp :set spell!<CR>

" Clear highlighting
nnoremap <silent> <c-h> :nohl<CR>:redraw<CR>
" }}}

" Autocommands {{{
" Spaces are good for indentation sometimes
autocmd FileType lisp,racket setlocal expandtab

" Go back to the last position when opening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" }}}
" }}}

" Plugin settings {{{
" Command-T {{{
nnoremap <silent> <leader>j :CommandT<CR>

let g:CommandTMaxHeight = 15
let g:CommandTMatchWindowReverse = 1
" }}}

" Gundo {{{
nnoremap <leader>u :silent GundoToggle<CR>
" }}}

" LaTeX-Suite-aka-Vim-LaTeX {{{
set grepprg=grep\ -nH\ $*

let g:tex_flavor = "xetex"
let g:Tex_FormatDependency_pdf = 'pdf'
let g:Tex_CompileRule_pdf = 'xelatex $*'
let g:Tex_MultipleCompileFormats = 'pdf'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRule_pdf = 'evince $*.pdf'
" }}}

" The-NERD-tree {{{
nnoremap <silent> <c-n> :NERDTreeToggle<CR>

let NERDTreeCaseSensitiveSort = 1
let NERDTreeChDirMode = 2
let NERDTreeIgnore  = ['\.o$', '\~$']
let NERDTreeIgnore += ['\.aux$', '\.bbl$', '\.blg$']
let NERDTreeIgnore += ['\.pyc$', '\.pyo$']
let NERDTreeIgnore += ['\.class$']
let NERDTreeQuitOnOpen = 1
" }}}

" neverland-vim-theme {{{
colorscheme neverland-darker
" }}}

" notes.vim {{{
let g:notes_shadowdir = '~/.vim/notes-shadow'

let notes_dir = '~/notes.d/'
let g:notes_directory = notes_dir . 'user'
let g:notes_indexfile = notes_dir . 'index'
let g:notes_tagsindex = notes_dir . 'tags'
" }}}

" statline {{{
let g:statline_fugitive = 1
let g:statline_show_n_buffers = 0
let g:statline_filename_relative = 1
let g:statline_show_charcode = 1
" }}}

" taglist.vim {{{
nnoremap <silent> <c-l> :TlistToggle<CR>

let Tlist_Use_Horiz_Window=0
let Tlist_Use_Right_Window = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Inc_Winwidth = 0
let Tlist_Close_On_Select = 1
let Tlist_Process_File_Always = 1
" }}}

" YankRing {{{
nnoremap <leader>y :YRShow<cr>

let g:yankring_replace_n_pkey = '<leader>['
let g:yankring_replace_n_nkey = '<leader>]'
" }}}
" }}}
