set nocompatible

runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

" General options {{{
" Vim settings {{{
set modelines=0                   " Don't look at modelines
set shortmess=aI                  " Shorten all messages; don't show intro
set wildmode=longest,list         " Better file tab completion
set tabstop=4                     " A 4-space tab seems reasonable
set shiftwidth=4
set hlsearch                      " Highlight search results
set incsearch                     " Search as you type
set ignorecase                    " Ignore case when searching
set smartcase                     " But not always
set nojoinspaces                  " Never insert two spaces
set cursorline                    " Highlight the current line
set virtualedit=block             " Allow block selection to go anywhere
set scrolloff=5                   " Keep 5 lines when scrolling
set laststatus=2                  " Always show a statusline
set showcmd                       " Show command typed, selection size
set lazyredraw                    " Redraw less frequently
set hidden                        " Allow hidden buffers
set visualbell t_vb=              " Disable vbell
set background=dark               " Light-on-dark
set title                         " Set the terminal title
if has("gui_macvim")
	set guifont=Menlo\ Regular:h12
else
	set guifont=Fixed\ 11
endif
if has("gui_running")
	set showtabline=2             " Always show the tab bar
	set guioptions-=T             " Don't show the toolbar
elseif has("mouse")
	set mouse=a                   " Enable mouse use in terminal
endif
set number                        " Show line numbers
if exists('+colorcolumn')
	set colorcolumn=80            " Hilight the 80th column
endif
set foldmethod=marker             " Fold on markers
set foldcolumn=1                  " Show folds
set formatoptions+=ro             " Insert the comment leader for new lines
set list                          " Show whitespace
set listchars=tab:»·,trail:·,nbsp:%
set display=uhex                  " Show nonprintables as <xx>
set pastetoggle=<F2>              " Toggle :set paste/nopaste
if has("persistent_undo")
	set undodir=~/.vim/undodir//
	set undofile
	set undolevels=1000
	set undoreload=10000
endif
set spelllang=en_ca               " Canadian English
set tags+=tags;                   " Search parents for tags
" }}}

" Key mappings {{{
let mapleader = ","

noremap  <F1> <ESC>
inoremap <F1> <ESC>

" Toggle spell checking.
nnoremap <silent> <leader>sp :set spell!<CR>

" Clear highlighting
nnoremap <silent> <c-h> :nohl<CR>:redraw<CR>

" Heresy
inoremap <c-a> <ESC>I
inoremap <c-e> <ESC>A

" Write the file with sudo
cnoremap w!! w !sudo tee % >/dev/null

" I want to leave, especially if I'm holding shift.
command! -bang Q    q<bang>
command! -bang Qall qall<bang>
command! -bang QALL qall<bang>

" These have only ever been a nuisance for me.
map K <nop>
map Q <nop>

" Unfold and center search results.
noremap N Nzvzz
noremap n nzvzz

noremap <C-n> :silent cnext<CR>
noremap <C-p> :silent cprevious<CR>

" Repeat for each line of the selection.
vnoremap . :normal .<CR>

" Prefer logical to Vi-compatible.
map Y y$

" Toggle diff.
map <leader>dt :DiffofferToggle<CR>
" }}}

" Autocommands {{{
augroup vimrc
	" Clear out existing autocommands, in case this file is re-sourced.
	autocmd!

	" Spaces are good for indentation sometimes
	autocmd FileType lisp,markdown,racket setlocal expandtab

	" PHP test files are mostly PHP.
	autocmd BufNewFile,BufRead *.phpt set ft=php

	" Go back to the last position when opening a file
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"zvzz" | endif
augroup END
" }}}

" Filetypes and highlighting {{{
syntax enable                     " Syntax higlighting
filetype plugin indent on         " Filetype-specific options

" Highlight VCS conflict markers
highlight VCSConflict NONE
match VCSConflict '^\([<|=>]\)\1\{6\}\1\@!'
" }}}
" }}}

" Plugin settings {{{
" Command-T {{{
nnoremap <silent> <leader>j :CommandT<CR>
nnoremap <silent> <leader>tf :CommandTFlush<CR>

let g:CommandTMaxHeight = 15
let g:CommandTMatchWindowReverse = 1
" }}}

" Gundo {{{
nnoremap <leader>u :silent GundoToggle<CR>
" }}}

" LaTeX-Suite {{{
set grepprg=grep\ -nH\ $*

let g:tex_flavor = "xetex"
let g:Tex_FormatDependency_pdf = 'pdf'
let g:Tex_CompileRule_pdf = 'xelatex $*'
let g:Tex_MultipleCompileFormats = 'pdf'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRule_pdf = 'evince $*.pdf'
" }}}

" NERD-tree {{{
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>N :NERDTreeClose <bar> :NERDTreeFind<CR>

let NERDTreeCaseSensitiveSort = 1
let NERDTreeChDirMode = 2
let NERDTreeIgnore  = ['\.o$', '\~$']
let NERDTreeIgnore += ['\.aux$', '\.bbl$', '\.blg$']
let NERDTreeIgnore += ['\.pyc$', '\.pyo$']
let NERDTreeIgnore += ['\.class$']
let NERDTreeQuitOnOpen = 1
" }}}

" neverland {{{
colorscheme neverland-darker
" }}}

" notes {{{
let g:notes_shadowdir = '~/.vim/notes-shadow'

let notes_dir = '~/notes.d/'
let g:notes_directory = notes_dir . 'user'
let g:notes_indexfile = notes_dir . 'index'
let g:notes_tagsindex = notes_dir . 'tags'
" }}}

" NrrwRgn {{{
let g:nrrw_rgn_protect = 'n'
" }}}

" slime {{{
let g:slime_python_ipython = 1
" }}}

" statline {{{
let g:statline_fugitive = 1
let g:statline_show_n_buffers = 0
let g:statline_filename_relative = 1
let g:statline_show_charcode = 1
" }}}

" taglist {{{
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

" ultisnips {{{
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "snippets"]

" Workaround for Python message.
if !has('python') && !has('python3')
	let did_UltiSnips_vim = 1
	let did_UltiSnips_vim_after=1
endif
" }}}

" YankRing {{{
nnoremap <leader>y :YRShow<cr>

let g:yankring_history_dir = '~/.vim'
let g:yankring_replace_n_pkey = '<leader>['
let g:yankring_replace_n_nkey = '<leader>]'
" }}}
" }}}

" Post-plugin settings {{{
highlight VCSConflict ctermfg=0     ctermbg=208   cterm=bold
highlight VCSConflict guifg=#000000 guibg=#ff8700 gui=bold
" }}}
