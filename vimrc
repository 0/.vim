set nocompatible
scriptencoding utf-8

runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()

" General options {{{
" Vim settings {{{
set modelines=0                   " Don't look at modelines
set shortmess=aIO                 " Abbr. all; no intro; reads squash
set wildmode=longest,list         " Better file tab completion
set backspace=indent,eol,start    " Backspace over everything
set tabstop=4                     " A 4-space tab seems reasonable
set shiftwidth=4
set copyindent                    " Keep existing indentation
set preserveindent
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
noremap Y y$

" Unite prefix key.
nnoremap [unite] <Nop>
nmap <Space> [unite]
" }}}

" Autocommands {{{
augroup vimrc
	" Clear out existing autocommands, in case this file is re-sourced.
	autocmd!

	" Spaces are good for indentation sometimes
	autocmd FileType haskell,lisp,markdown,racket setlocal expandtab

	" .hsc files are Haskell. Elm files are Haskellesque.
	autocmd BufNewFile,BufRead *.hsc,*.elm set ft=haskell

	" ASDF files are Lisp.
	autocmd BufNewFile,BufRead *.asd set ft=lisp

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

" Complain about trailing whitespace
match Error '\s\+$'
" }}}
" }}}

" Plugin settings {{{
" airline {{{
" Use the short mode labels given in the documentation.
let g:airline_mode_map = {
			\ '__' : '-',
			\ 'n'  : 'N',
			\ 'i'  : 'I',
			\ 'R'  : 'R',
			\ 'c'  : 'C',
			\ 'v'  : 'V',
			\ 'V'  : 'V',
			\ '' : 'V',
			\ 's'  : 'S',
			\ 'S'  : 'S',
			\ '' : 'S',
			\ }

" Use the airline tabline.
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#tab_min_count = 2
" }}}

" diffoffer {{{
map <leader>dod :DiffofferToggleDiff<CR>
map <leader>dof :DiffofferToggleFiller<CR>
map <leader>dou :diffupdate<CR>
" }}}

" extradite {{{
let g:extradite_showhash = 1
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

" nerdtree {{{
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>N :NERDTreeClose <bar> :NERDTreeFind<CR>

let NERDTreeCaseSensitiveSort = 1
let NERDTreeChDirMode = 2
let NERDTreeIgnore  = ['^tags$']
let NERDTreeIgnore += ['\~$', '\.o$']
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
let g:notes_directories = [notes_dir . 'user']
let g:notes_indexfile = notes_dir . 'index'
let g:notes_tagsindex = notes_dir . 'tags'

let g:notes_smart_quotes = 0
" }}}

" NrrwRgn {{{
let g:nrrw_rgn_protect = 'n'
" }}}

" slime {{{
let g:slime_python_ipython = 1
" }}}

" ultisnips {{{
let g:UltiSnipsNoPythonWarning = 1
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "ulti_snippets"]
" }}}

" unite {{{
nnoremap <silent> [unite]<Space> :<C-u>Unite -start-insert source<CR>
nnoremap <silent> [unite]b :<C-u>Unite -quick-match buffer file_mru bookmark<CR>
nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>

" Current dir.
nnoremap <silent> [unite]j :<C-u>Unite -start-insert file_rec/async<CR>
" Project dir.
nnoremap <silent> [unite]k :<C-u>Unite -start-insert file_rec/async:!<CR>

let g:unite_data_directory = expand('~/.vim/unite')
let g:unite_source_file_mru_time_format = ''
let g:unite_source_history_yank_enable = 1
let g:unite_split_rule = "botright"

autocmd FileType unite call s:unite_custom_settings()

function! s:unite_custom_settings()
	imap <buffer> <C-j> <Plug>(unite_select_next_line)
	imap <buffer> <C-k> <Plug>(unite_select_previous_line)

	imap <buffer> <C-p> <Plug>(unite_toggle_auto_preview)
endfunction
" }}}

" unite-outline {{{
nnoremap <silent> [unite]o :<C-u>Unite -auto-highlight -vertical -winwidth=50 outline<CR>
" }}}

" vim2hs {{{
let g:haskell_conceal_enumerations = 0
" }}}
" }}}

" Post-plugin settings {{{
highlight VCSConflict ctermfg=0     ctermbg=208   cterm=bold
highlight VCSConflict guifg=#000000 guibg=#ff8700 gui=bold
" }}}
