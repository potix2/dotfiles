" Initial process. {{{1
if has('vim_starting') && has('reltime')
    let g:startuptime = reltime()
    augroup vimrc-startuptime
        autocmd! VimEnter * let g:startuptime = reltime(g:startuptime) | redraw
                    \ | echomsg 'startuptime: ' . reltimestr(g:startuptime)
    augroup END
endif

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
set hidden
set background=dark
set autowrite
set completeopt=menuone
set spelllang=en,cjk
set t_Co=256

" Make command line two lines high
set ch=2

" set visual bell
set vb t_vb=

" set statusline
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
let g:maplocalleader = ","

" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20 : up to 20 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

if &compatible
  set nocompatible
endif

packadd minpac
if exists('*minpac#init')
  " minpac is loaded.
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Additional plugins here.
  call minpac#add('vim-jp/syntax-vim-ex')
  call minpac#add('Shougo/unite.vim')
  call minpac#add('Shougo/neocomplcache')
  call minpac#add('Shougo/vimfiler')
  call minpac#add('Shougo/vimproc')
  call minpac#add('Shougo/vimshell')
  call minpac#add('Shougo/neomru.vim')
  call minpac#add('thinca/vim-ref')
  call minpac#add('thinca/vim-quickrun')
  call minpac#add('mattn/gist-vim')
  call minpac#add('mattn/webapi-vim')
  call minpac#add('Lokaltog/vim-easymotion')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-repeat')
  call minpac#add('tpope/vim-abolish')
  call minpac#add('tpope/vim-endwise')
  call minpac#add('tpope/vim-dispatch')
  call minpac#add('tyru/restart.vim')
  call minpac#add('tyru/caw.vim')
  call minpac#add('tyru/open-browser.vim')
  call minpac#add('scrooloose/syntastic')
  call minpac#add('kana/vim-metarw')
  call minpac#add('kana/mduem')
  call minpac#add('ujihisa/blogger.vim')
  call minpac#add('ujihisa/neco-ghc')
  call minpac#add('hallison/vim-markdown')
  call minpac#add('eagletmt/ghcmod-vim')
  call minpac#add('jelera/vim-javascript-syntax')
  call minpac#add('mjbrownie/pythoncomplete.vim')
  call minpac#add('derekwyatt/vim-scala')
  call minpac#add('fatih/vim-hclfmt')
  call minpac#add('fatih/vim-go')
  call minpac#add('alfredodeza/pytest.vim')
  call minpac#add('neovimhaskell/haskell-vim')
  call minpac#add('whatyouhide/vim-gotham')
  call minpac#add('vim-scripts/emmet.vim')
  call minpac#add('vim-scripts/sudo.vim')
  call minpac#add('vim-scripts/taglist.vim')
  call minpac#add('vim-scripts/nginx.vim')
  call minpac#add('vim-scripts/groovy.vim')
  call minpac#add('vim-scripts/sql.vim')
  call minpac#add('vim-scripts/matchit.zip')
  call minpac#add('itchyny/lightline.vim')
  call minpac#add('lambdalisue/gina.vim')
endif

" Plugin settings here.

" Define user commands for updating/cleaning the plugins.
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

filetype plugin on
filetype indent on
filetype on
let loaded_matchparen = 1

colorschem gotham256

" Auto reload when changed by external.
set autoread

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

" for make {{2
augroup AutoMakeCmd
    autocmd!
    autocmd FileType make setlocal noexpandtab
augroup END

" for ruby {{2
augroup MyRubyCmd
    autocmd!
    autocmd BufWinEnter,BufNewFile *.gemspec set filetype=ruby
    autocmd BufWinEnter,BufNewFile *.cap set filetype=ruby
    autocmd BufWinEnter,BufNewFile Gemfile set filetype=ruby
    autocmd BufWinEnter,BufNewFile Rakefile set filetype=ruby
    autocmd BufWinEnter,BufNewFile Vagrantfile set filetype=ruby
    autocmd FileType ruby set tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END

" for python {{2
augroup MyPythonCmd
    autocmd!
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    nnoremap <silent><Leader>tt <Esc>:Pytest project verbose<CR>
    nnoremap <silent><Leader>tf <Esc>:Pytest file verbose<CR>
    nnoremap <silent><Leader>tc <Esc>:Pytest class verbose<CR>
    nnoremap <silent><Leader>tm <Esc>:Pytest method verbose<CR>
augroup END

" for json {{2
augroup MyJsonCmd
    autocmd!
    autocmd BufWinEnter,BufNewFile *.json set filetype=json
    autocmd FileType json vmap <Leader>f !python -m json.tool<CR>
augroup END

" for yaml {{2
augroup MyYamlCmd
    autocmd!
    autocmd BufWinEnter,BufNewFile *.yaml set filetype=yaml
    autocmd BufWinEnter,BufNewFile *.yml set filetype=yaml
    autocmd FileType yaml set tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" for golang {{2
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.go = '\h\w*\.\?'
let g:go_auto_type_info = 1
augroup MyGolang
    autocmd!
    autocmd FileType go nmap <leader>r <Plug>(go-run)
    autocmd FileType go nmap <leader>b <Plug>(go-build)
    autocmd FileType go nmap <leader>t <Plug>(go-test)
    autocmd FileType go nmap <leader>c <Plug>(go-coverage)
    autocmd FileType go nmap <leader>gd <Plug>(go-doc)
    nnoremap <leader>a ::cclose<CR>
    autocmd FileType go nnoremap <C-n> :cnext<CR>
    autocmd FileType go nnoremap <C-m> :cprevious<CR>
augroup END

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
nnoremap <silent> <Leader>uf :Unite file buffer file_mru<CR>
nnoremap <silent> <Leader>f :Unite buffer file_mru<CR>
nnoremap <silent> <Leader>ur :UniteResume<CR>
nnoremap <silent> <Leader>ub :Unite buffer<CR>
nnoremap <silent> <Leader>ug :Unite grep<CR><CR>

" vim-redmine {{2
if filereadable(expand('~/.vim/redmine.vim'))
    source ~/.vim/redmine.vim
endif

" neocomplcache {{2
let g:neocomplcache_enable_at_startup = 1

" VimFiler {{2
let g:vimfiler_as_default_explorer = 1

" tags {
set tags=tags;~/.tags

if filereadable(expand('~/.local.vim'))
    source ~/.local.vim
endif

" quickrun.vim {{2
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
    \ 'command': 'pandoc',
    \ 'exec': ['%c -s -f markdown -t html -o %s:p:r.html %s', 'open %s:p:r.html', 'sleep 1', 'rm %s:p:r.html'],
    \ 'tempfile': '{tempname()}.md'
    \ }

" for cpp {{{3
let g:quickrun_config['cpp'] = {
    \ "type": "cpp",
    \ "command": "g++",
    \ "cmdopt": "-Wall",
    \ "outputter": "compile"
    \ }

" for rspec {{{3
let g:quickrun_config['ruby.rspec'] = {
      \ 'command': 'rspec',
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

" for javascript
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['ruby', 'javascript', 'php'],
            \ 'passive_filetypes': [] }
let g:syntastic_javascript_jslint_conf = "--white --undef --nomen --regexp --plusplus --bitwise --newcap --sloppy --vars"
augroup MyJsCmd
    autocmd!
    autocmd FileType javascript set tabstop=2 softtabstop=2 shiftwidth=2
augroup end

augroup MyGradle
    autocmd!
    autocmd BufWinEnter,BufNewFile *.gradle set filetype=groovy
augroup END

" caw {{2
let g:caw_no_default_keymappings = 1
map <silent> <Leader>cc <Plug>(caw:i:toggle)

" local settings {{{1
if filereadable(expand('~/.local.vim'))
    source ~/.local.vim
endif
