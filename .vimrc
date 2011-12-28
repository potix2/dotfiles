" Initial process. {{{1
if has('vim_starting') && has('reltime')
    let g:startuptime = reltime()
    augroup vimrc-startuptime
        autocmd! VimEnter * let g:startuptime = reltime(g:startuptime) | redraw
                    \ | echomsg 'startuptime: ' . reltimestr(g:startuptime)
    augroup END
endif

filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype on

" Behavior settings. {{{1
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
" TODO: define MakeStatusLine()
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

set history=1000

set helplang=ja,en

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
Bundle 'tsaleh/vim-matchit'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tyru/restart.vim'
Bundle 'tyru/caw.vim'
Bundle 'scrooloose/syntastic'
Bundle 'potix2/vim-mysqlrun'
Bundle 'kana/vim-metarw'
Bundle 'ujihisa/blogger.vim'
Bundle 'hallison/vim-markdown'
Bundle 'godlygeek/tabular'
Bundle 'jcf/rvm_ruby.vim'
Bundle 'mfumi/ProjectEuler.vim'
Bundle 'eagletmt/onlinejudge-vim'
Bundle 'violetyk/cake.vim'

"vim.org
Bundle 'sudo.vim'
Bundle 'taglist.vim'
" }
" }

filetype plugin on
filetype indent on

filetype on
let loaded_matchparen = 1

colorschem wombat

" Auto reload when changed by external.
set autoread

" Get character code on cursor with 'fileencoding'.
function! GetCharacterCode()
  let str = iconv(matchstr(getline('.'), '.', col('.') - 1), &enc, &fenc)
  let out = '0x'
  for i in range(strlen(str))
    let out .= printf('%02X', char2nr(str[i]))
  endfor
  if str ==# ''
    let out .= '00'
  endif
  return out
endfunction

" Return the current file size in human readable format.
function! GetFileSize()
  let size = &encoding ==# &fileencoding || &fileencoding ==# ''
  \        ? line2byte(line('$') + 1) - 1 : getfsize(expand('%'))

  if size < 0
    let size = 0
  endif
  for unit in ['B', 'KB', 'MB']
    if size < 1024
      return size . unit
    endif
    let size = size / 1024
  endfor
  return size . 'GB'
endfunction

" Backup.
set backup
set backupdir=./.backup,~/.backup
" Paths of swap file and backup file.
if $TMP !=# ''
  execute 'set backupdir+=' . escape(expand($TMP), ' \')
elseif has('unix')
  set backupdir+=/tmp
endif
let &directory = &backupdir
if has('persistent_undo')
  set undodir=~/.backup
  augroup vimrc-undofile
    autocmd!
    autocmd BufReadPre ~/* setlocal undofile
  augroup END
endif
set backupcopy=yes

"call s:mkdir(expand('~/.backup'))

" font settings. {{2
if has("gui_running")
    set guifont=Inconsolata:h14
endif

" for php {{2
augroup MyAutoPHPCmd
    autocmd!
    autocmd FileType php :set dictionary=~/.vim/dict/php.dict
    autocmd FileType php :set tags=tags;~/.pear.tags
augroup END
let g:ref_phpmanual_path = $HOME . '/manuals/php'

" for make {{2
augroup AutoMakeCmd
    autocmd!
    autocmd FileType make setlocal noexpandtab
augroup END

" setup tabline {{2
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

function! GetTagList(expr)"{{{
    let tl = taglist(a:expr)
endfunction"}}}

" Key mappings {{{1
"
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap ; :
noremap : ;
nnoremap <C-j> <C-^>
imap jj <ESC>

" tags
nnoremap t <Nop>
nnoremap tt <C-]>
nnoremap tj :<C-u>tag<CR>
nnoremap tk :<C-u>pop<CR>
nnoremap tl :<C-u>tags<CR>
nnoremap <silent> <Leader>cd :lcd %:h<CR>
nnoremap <silent> <Leader>md :!mkdir -p %:p:h<CR>
nnoremap <silent> <Leader>bd :bd<CR>

" vimrc
nnoremap <silent> <Leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <Leader>sv :so $MYVIMRC<CR>

" for codeforeces {{{2
nnoremap <C-l> :make %:r
nnoremap <C-l><C-l> :!./%:r

" Plugin settings. {{{1
" Unite {{2
let g:unite_enable_start_insert = 1
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    nmap <buffer> jj <Plug>(unite_exit)
    imap <buffer> jj <Plug>(unite_exit)
    nmap <silent> <buffer> <C-w> <Plug>(unite_delete_backward_path)
    imap <silent> <buffer> <C-w> <Plug>(unite_delete_backward_path)
endfunction
nnoremap <silent> <Leader>uf :Unite file file_mru buffer bookmark<CR>

" vim-redmine {{2
if filereadable(expand('~/.vim/redmine.vim'))
    source ~/.vim/redmine.vim
endif

" neocomplcache {{2
let g:neocomplcache_enable_at_startup = 1

" VimFiler {{2
let g:vimfiler_as_default_explorer = 1

" vimshell {{2
" let g:VimShell_EnableInteractive = 1

" tags {
set tags=tags;~/.tags


" mysqlrun.vim {{{2
if filereadable(expand('~/.vimrc.mysqlrun'))
    source ~/.vimrc.mysqlrun
endif
noremap <Leader>mr :MySQLRun

" Tabularize.vim {{{2
nmap <Leader>t= :Tabularize /=<CR>
vmap <Leader>t= :Tabularize /=<CR>
nmap <Leader>t: :Tabularize /:\zs<CR>
vmap <Leader>t: :Tabularize /:\zs<CR>

" quickrun.vim {{2
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
    \ 'command': 'pandoc',
    \ 'exec': ['%c -s -f markdown -t html -o %s:p:r.html %s', 'open %s:p:r.html', 'sleep 1', 'rm %s:p:r.html'],
    \ 'tempfile': '{tempname()}.md'
    \ }

" blogger.vim {{2
if filereadable(expand('~/.vim/blogger.vim'))
    source ~/.vim/blogger.vim
endif

" gist {{2
let g:gist_detect_filetype = 1
if filereadable(expand('~/.vimrc.gist'))
    source ~/.vimrc.gist
endif

" syntastic {{2
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 2

" local settings {{{1
if filereadable(expand('~/.local.vim'))
    source ~/.local.vim
endif


