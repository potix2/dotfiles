filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype on

set nocompatible
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set showmatch
set wrapscan
set ruler
set nohls
set incsearch
set clipboard+=unnamed

" Make command line two lines high
set ch=2

" set visual bell
set vb t_vb=

" set statusline
set stl=%f\ %m\ %r%{fugitive#statusline()}\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]
set laststatus=2

" Show the current mode
set showmode

syntax on

" use wildmenu
set wildmenu
set wildignore=

set hlsearch
set incsearch
set autoread

set history=100

set number
" set relativenumber

set foldenable
set foldmarker={,}
set foldmethod=marker
set foldlevel=99
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

set grepprg=grep\ -nH\ $*
let mapleader = ","

" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20 : up to 20 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" for Vundle {
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" managed plugins by Vundle {
Bundle 'gmarik/vundle'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/vimfiler'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'
Bundle 'thinca/vim-ref'
Bundle 'thinca/vim-quickrun'
Bundle 'mattn/gist-vim'
Bundle 'mattn/zencoding-vim'
Bundle 'mattn/webapi-vim'
Bundle 'tsaleh/vim-matchit'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tyru/restart.vim'
Bundle 'tyru/caw.vim'
Bundle 'tyru/open-browser.vim'
Bundle 'scrooloose/syntastic'
Bundle 'potix2/vim-mysqlrun'
Bundle 'violetyk/cake.vim'

"vim.org
Bundle 'sudo.vim'
"Bundle 'Simple-Javascript-Indenter'
"Bundle 'JavaScript-syntax'
" }
" }

filetype plugin on
filetype indent on

filetype on
let loaded_matchparen = 1

colorschem wombat

" neocomplcache {
let g:neocomplcache_enable_at_startup = 1
" }

" VimFiler {
let g:vimfiler_as_default_explorer = 1
" }

" vimshell {
" let g:VimShell_EnableInteractive = 1
" }

" tags {
set tags=tags;/
" }

" for php {
autocmd FileType php :set dictionary=~/.vim/dict/php.dict
let g:ref_phpmanual_path = $HOME . '/manuals/php'
" }

" for make {
autocmd FileType make setlocal noexpandtab
" }

" for gist-vim {
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
if filereadable(expand('~/.vimrc.gist'))
    source ~/.vimrc.gist
endif
" }

" for vim-easymotion {
" }

" for mysqlrun-vim {
if filereadable(expand('~/.vimrc.mysqlrun'))
    source ~/.vimrc.mysqlrun
endif
" }

" setup tabline {
function! s:tabpage_label(n)"{{{
    let title = gettabvar(a:n, 'title')
    if title !=# ''
        return title
    endif

    let bufnrs = tabpagebuflist(a:n)
    let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

    let no = len(bufnrs)
    if no is 1
        let no = ''
    endif

    let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '+' : ''
    let sp = (no.mod) ==# '' ? '' : ' '
    let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]
    let fname = pathshorten(bufname(curbufnr))

    let label = no.mod.sp.fname
    return '%' . a:n .'T'.hi.label.'%T%#TabLineFill#'
endfunction"}}}

function! MakeTabLine()"{{{
    let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
    let sep = '|'
    let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
    let info = fnamemodify(getcwd(),":~").''
    return tabpages . '%=' .info
endfunction"}}}
set showtabline=2
set tabline=%!MakeTabLine()
" }

" for syntastic {
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 2
" }

" for Unite {
let g:unite_enable_start_insert = 1
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    nmap <buffer> <ESC> <Plug>(unite_exit)
    imap <buffer> jj <Plug>(unite_exit)
    nmap <silent> <buffer> <C-w> <Plug>(unite_delete_backward_path)
    imap <silent> <buffer> <C-w> <Plug>(unite_delete_backward_path)
endfunction
" }

if has("gui_running")
    set guifont=Inconsolata:h14
endif

" setup mapping {
nnoremap <C-m> 20j
nnoremap <silent> <Leader>cd :lcd %:h<CR>
nnoremap <silent> <Leader>md :!mkdir -p %:p:h<CR>
nnoremap <silent> <Leader>bd :bd<CR>

nnoremap <C-j> <C-^>
nnoremap <silent> <Leader>uf :Unite file file_mru buffer bookmark<CR>
nmap <Leader>w <Plug>(openbrowser-smart-search)

" vimrc
nnoremap <silent> <Leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <Leader>sv :so $MYVIMRC<CR>

imap jj <ESC>

" for codeforeces
nnoremap <C-l> :make %:r
nnoremap <C-l><C-l> :!./%:r

" for mysqlrun
noremap <Leader>mr :MySQLRun
" 

if filereadable(expand('~/.local.vim'))
    source ~/.local.vim
endif
