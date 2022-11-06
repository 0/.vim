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
set viminfo=                      " Don't use viminfo
set nobackup                      " Don't keep the backup file
set noswapfile                    " Don't make a swap file
set noundofile                    " Don't record persistent undo
set hlsearch                      " Highlight search results
set incsearch                     " Search as you type
set ignorecase                    " Ignore case when searching
set smartcase                     " But not always
set ttimeoutlen=100               " Don't wait for escape sequences
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
endif
if has("gui_running")
	set showtabline=2             " Always show the tab bar
	set guioptions-=T             " Don't show the toolbar
elseif has("mouse")
	set mouse=a                   " Enable mouse use in terminal
endif
set guioptions-=a                 " Don't clobber selection
set guioptions-=P
set guioptions-=A
set clipboard-=autoselect
set clipboard-=autoselectplus
set clipboard-=autoselectml
set number                        " Show line numbers
if exists('+colorcolumn')
	set colorcolumn=+1            " Highlight column to the right of textwidth
endif
set foldmethod=marker             " Fold on markers
set foldcolumn=1                  " Show folds
set formatoptions+=ro             " Insert the comment leader for new lines
set list                          " Show whitespace
set listchars=tab:»·,trail:·,nbsp:%
set display=uhex                  " Show nonprintables as <xx>
set pastetoggle=<F2>              " Toggle :set paste/nopaste
set spelllang=en_ca               " Canadian English
set tags+=tags;                   " Search parents for tags
set nrformats-=octal
" }}}

" Key mappings {{{
let mapleader = ","

noremap  <F1> <ESC>
inoremap <F1> <ESC>

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

noremap <C-n> :silent cnext<CR>
noremap <C-p> :silent cprevious<CR>

" Repeat for each line of the selection.
vnoremap . :normal .<CR>

" Prefer logical to Vi-compatible.
noremap Y y$
" }}}

" Autocommands {{{
augroup vimrc
	" Clear out existing autocommands, in case this file is re-sourced.
	autocmd!

	" Spaces are acceptable for indentation sometimes.
	autocmd FileType haskell,julia,lisp,markdown,pyrex,python,racket setlocal expandtab

	" .hsc files are Haskell. Elm files are Haskellesque.
	autocmd BufNewFile,BufRead *.hsc,*.elm set ft=haskell

	" ASDF files are Lisp.
	autocmd BufNewFile,BufRead *.asd set ft=lisp

	" PHP test files are mostly PHP.
	autocmd BufNewFile,BufRead *.phpt set ft=php
augroup END
" }}}

" Filetypes and highlighting {{{
syntax enable                     " Syntax higlighting
filetype plugin indent on         " Filetype-specific options

" Complain about trailing whitespace
match Error '\s\+$'
" }}}
" }}}

" Plugin settings {{{
" airline {{{
let g:airline_theme_patch_func = 'AirlineThemePatch'

function! AirlineThemePatch(palette)
  for colors in values(a:palette.inactive)
    let colors[0] = '#ffffff'
    let colors[1] = '#121212'
    let colors[2] = 255
    let colors[3] = 233
  endfor
  let a:palette.inactive_modified['airline_c'][0] = '#ff00af'
  let a:palette.inactive_modified['airline_c'][1] = ''
  let a:palette.inactive_modified['airline_c'][2] = 199
  let a:palette.inactive_modified['airline_c'][3] = ''
endfunction

let g:airline_symbols_ascii = 1

" Use the short mode labels given in the documentation.
let g:airline_mode_map = {
			\ '__'     : '-',
			\ 'c'      : 'C',
			\ 'i'      : 'I',
			\ 'ic'     : 'I',
			\ 'ix'     : 'I',
			\ 'n'      : 'N',
			\ 'multi'  : 'M',
			\ 'ni'     : 'N',
			\ 'no'     : 'N',
			\ 'R'      : 'R',
			\ 'Rv'     : 'R',
			\ 's'      : 'S',
			\ 'S'      : 'S',
			\ ''     : 'S',
			\ 't'      : 'T',
			\ 'v'      : 'V',
			\ 'V'      : 'V',
			\ ''     : 'V',
			\ }

" Hide most common case.
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" Disable searchcount.
let g:airline#extensions#searchcount#enabled = 0

" Use the airline tabline.
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#tab_min_count = 2
" }}}

" beancount {{{
let g:beancount_separator_col = 70
autocmd FileType beancount setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType beancount noremap <leader>. :AlignCommodity<CR>
" }}}

" ConflictMotions {{{
let g:ConflictMotions_MarkerMapping = ''
" }}}

" diffoffer {{{
map <leader>dod :DiffofferToggleDiff<CR>
map <leader>dof :DiffofferToggleFiller<CR>
map <leader>dou :diffupdate<CR>
" }}}

" extradite {{{
let g:extradite_showhash = 1
" }}}

" file-line {{{
let g:file_line_crosshairs = 0
" }}}

" matchit {{{
packadd! matchit
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

" netrw {{{
let g:netrw_dirhistmax = 0
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

" schlepp {{{
vmap <unique> <C-k> <Plug>SchleppUp
vmap <unique> <C-j> <Plug>SchleppDown
vmap <unique> <C-h> <Plug>SchleppLeft
vmap <unique> <C-l> <Plug>SchleppRight

let g:Schlepp#allowSquishingLines = 1
let g:Schlepp#allowSquishingBlock = 1
" }}}

" slime {{{
let g:slime_python_ipython = 1
let g:slime_target = "tmux"
" }}}

" ultisnips {{{
let g:UltiSnipsNoPythonWarning = 1
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "ulti_snippets"]
" }}}

" undotree {{{
nnoremap <leader>u :UndotreeToggle<cr>
" }}}
" }}}
