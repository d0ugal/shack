if &compatible
  set nocompatible
endif

let mapleader=","

set mouse=""
set encoding=utf-8

set title
set nowrap

set tabstop=8
set shiftwidth=4
set shiftround
set softtabstop=4
set expandtab

set backspace=indent,eol,start

set autoindent
set copyindent

set showmatch
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch

"
set wildmenu

" Stop creating backup and swap files
set noswapfile
set nobackup
set nowb

set listchars=tab:▸\ ,eol:¬,trail:~,extends:>,precedes:<

nnoremap <esc> :noh<return>

call plug#begin('~/.config/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'tag': 'v1.21'}
Plug 'gregsexton/MatchTag'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install() } }
Plug 'nathanaelkane/vim-indent-guides', {'tag': '1.6'}
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'psf/black'
Plug 'ruanyl/vim-gh-line'
Plug 'scrooloose/nerdtree', {'tag': '6.3.0'}
Plug 'tommcdo/vim-fugitive-blame-ext'
Plug 'tpope/vim-eunuch', {'tag': 'v1.2'}
Plug 'tpope/vim-fugitive', {'tag': 'v3.1'}
Plug 'tpope/vim-sensible', {'tag': 'v1.2'}
Plug 'vim-scripts/taglist.vim', {'tag': '4.5'}
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'rhysd/git-messenger.vim'
Plug 'APZelos/blamer.nvim'
Plug 'majutsushi/tagbar'

call plug#end()

" File search
nnoremap <C-o> :Files<Cr>
" Git File search
nnoremap <C-p> :GFiles<Cr>
" Git commit search
nnoremap <C-g> :BCommits<Cr>
" File history search
nnoremap <C-h> :History<Cr>
" Ag search
nnoremap <C-a> :Ag<Cr>
" Buffer search
nnoremap <C-l> :Lines<Cr>

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

let $FZF_DEFAULT_COMMAND = 'ag --ignore .tox -g ""'
let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:14,fg+:0,bg:0,hl:9,bg+:8,hl+:9 --color=info:1,prompt:9,pointer:12,marker:4,spinner:11,header:0 --layout=reverse  --margin=1,2'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
   let width = float2nr(&columns * 0.8)
   let height = float2nr(&lines * 0.6)
   let opts = { 'relative': 'editor',
              \ 'row': (&lines - height) / 2,
              \ 'col': (&columns - width) / 2,
              \ 'width': width,
              \ 'height': height }

    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
endfunction

nnoremap <C-b> :GitMessenger<Cr>

" Toggle invisible characters
noremap <leader>l :set list!<CR>

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Add line numbers
set number

" Use the system clipboard
set clipboard=unnamedplus

" Fix the statusline with lightline
set laststatus=2

nmap <Leader>cp :let @+=expand("%")<CR>

" Git messenger. Disable default bind
let g:git_messenger_no_default_mappings = 1

" Include the git diff
let g:git_messenger_include_diff = "current"

" Limit the popup size
let g:git_messenger_max_popup_height = 50

hi gitmessengerPopupNormal term=None ctermbg=16

" show git blame with leader b
nmap <Leader>b <Plug>(git-messenger)

" Show tag bar and jump to item with leader t
nmap <Leader>t :TagbarToggle<Cr>
let g:tagbar_width = 50

" Sort the tagbar by the filename
let g:tagbar_sort = 0

let g:blamer_enabled = 1
let g:blamer_show_in_insert_modes = 0
let g:blamer_prefix = '        '
let g:blamer_template = '<committer-time> - <committer> - <summary>'

let g:black_fast = 1
autocmd BufWritePost *.py silent! execute ':Black'
let g:python_host_prog  = '~/.pyenv/versions/vim_py2/bin/python'
let g:python3_host_prog  = '~/.pyenv/versions/vim_py3/bin/python'

" Automatically reload files if they are changed but have not beed edited
set autoread

" Add a 80 char margin
set colorcolumn=80

" Strip trailing whitespace when saving Python files
autocmd BufWritePre *.py %s/\s\+$//e

" Allow split navigation with just ctrl+h/j/k/l
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Open new splits below and to the right, which seems more sensible
set splitbelow
set splitright

function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <leader>nt :call NumberToggle()<cr>


" Jenkinsfile VIM syntax highlighting
au BufNewFile,BufRead Jenkinsfile setf groovy
