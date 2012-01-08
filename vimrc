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
set showcmd                       " Show selection size
set hidden                        " Allow hidden buffers
set visualbell t_vb=              " Disable vbell
set background=dark               " Light-on-dark
set guifont=Fixed\ 11
set number                        " Show line numbers
set colorcolumn=80                " Hilight the 80th column
set foldmethod=marker             " Fold on markers
set foldcolumn=1                  " Show folds
set list                          " Show whitespace
set listchars=tab:»·,trail:·,nbsp:%
set display=uhex                  " Show nonprintables as <xx>
set pastetoggle=<F2>              " Toggle :set paste/nopaste

set statusline =%n\               " Buffer number
set statusline+=%f\               " Path
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, " Encoding
set statusline+=%{&ff}]           " Line endings
set statusline+=%y                " Filetype
set statusline+=%m                " Modified?
set statusline+=%r                " Readonly?
set statusline+=%w                " Preview?
set statusline+=%{fugitive#statusline()} " Git branch
set statusline+=%=                " Separator
set statusline+=%c%V,%l/%L\       " Position, at least 14 chars wide
set statusline+=%P                " Percent through file

noremap  <F1> <ESC>
inoremap <F1> <ESC>

let mapleader = ","

syntax enable                     " Syntax higlighting
filetype plugin indent on         " Filetype-specific options

setlocal spell spelllang=en_ca
set nospell
nmap <silent> <leader>sp :set spell!<CR>

set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

" Spaces are good for indentation sometimes
autocmd! FileType lisp,racket setlocal expandtab

" Clear highlighting
nmap <silent> <c-h> :nohl<CR>:redraw<CR>

" Always cd to the current file's directory
autocmd! BufEnter * silent! lcd %:p:h:gs/ /\\ /

" Go back to the last position when opening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" }}}

" Plugin settings {{{

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
nmap <silent> <c-n> :NERDTreeToggle<CR>

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
let g:notes_directory = '~/notes.d/user'
let g:notes_shadowdir = '~/notes.d/shadow'
let g:notes_indexfile = '~/notes.d/index.sqlite3'
let g:notes_tagsindex = '~/notes.d/tags.txt'
" }}}

" taglist.vim {{{
nmap <silent> <c-l> :TlistToggle<CR>

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
nmap <leader>y :YRShow<cr>

let g:yankring_replace_n_pkey = '<leader>['
let g:yankring_replace_n_nkey = '<leader>]'
" }}}

" }}}
