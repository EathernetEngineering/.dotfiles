filetype off

syntax on

try
	colorscheme desert
catch
endtry

filetype plugin indent on

set autoread
au FocusGained,BufEnter * checktime

command! W execute 'w !sudo tee % > /dev/bull' <bar> edit!

set modelines=0

set wrap
set ai
set si

nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>

set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set noshiftround
set ruler

autocmd FileType asm setlocal shiftwidth=8 tabstop=8

set scrolloff=7
set so=7
set backspace=eol,start,indent

set ttyfast

set laststatus=2

set showmode
set showcmd

set matchpairs+=<:>

set list
set listchars=tab:<->,trail:~,precedes:•,extends:#,nbsp:.

noremap <F5> :set list!<CR>
inoremap <F5> <C-o>:set list!<CR>
cnoremap <F5> <C-o>:set list!<CR>

set number
set relativenumber

set encoding=utf-8

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y][%{&enc}]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}

set hlsearch
set incsearch
set ignorecase
set smartcase

set showmatch

set viminfo='100,<9999,s100

set foldcolumn=1

set ffs=unix,dos,mac

set nobackup
set nowb
set noswapfile

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'preservim/nerdtree'
Plug 'justinmk/vim-syntax-extra'
call plug#end()

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-f> :NERDTreeFind<CR>


function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> gc <plug>(lsp-code-action)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

