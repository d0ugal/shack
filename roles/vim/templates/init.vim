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

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

nnoremap <esc> :noh<return>

call plug#begin('~/.config/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'tag': 'v1.21'}
Plug 'gregsexton/MatchTag'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install() } }
Plug 'nathanaelkane/vim-indent-guides', {'tag': '1.6'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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

" Command search
nnoremap <C-S-p> :Commands<Cr>
" File search
nnoremap <C-p> :Files<Cr>
" Git commit search
nnoremap <C-g> :Commits<Cr>

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

let $FZF_DEFAULT_COMMAND = 'ag -g ""'
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






" --- The following are suggested configs from coc ---

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Don't add to the end of the file! Add news things above coc.
