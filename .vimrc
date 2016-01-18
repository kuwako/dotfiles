" -------------------
" 色の設定
" -------------------
syntax on

highlight LineNr ctermfg=darkyellow    " 行番号
highlight NonText ctermfg=darkgrey
highlight Folded ctermfg=black
highlight SpecialKey cterm=underline ctermfg=darkgrey
hi Pmenu ctermbg=darkBlue
hi PmenuSel ctermbg=6
hi PmenuSbar ctermbg=2
hi PmenuThumb ctermfg=3
"highlight SpecialKey ctermfg=grey " 特殊記号

" 全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/

" タブ幅
set ts=4 sw=4
set softtabstop=4
set expandtab
" -------------------
" 日本語の設定
" -------------------
" 文字コードの自動認識

if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif

if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif

  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif

" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos

" -------------------" 検索
" -------------------
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する(noignorecase)
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する(nosmartcase)
set smartcase
" 検索文字のハイライトをしない
set nohlsearch
" インクリメンタルサーチ
set incsearch

set cursorline

" -------------------
" Explore
" -------------------
"let g:explHideFiles='^\.,\.gz$,\.exe$,\.zip$'  " 非表示の設定(aでトグル)
"let g:explDetailedHelp=0
"let g:explWinSize=''
"let g:explSplitBelow=1
"let g:explUseSeparators=1     " ディレクトリとファイルの間くらいにセパレータ表示

" -------------------
" バッファ関連
" -------------------
set hidden           " 切り替え時のundoの効果持続等
" -------------------
" その他
" -------------------
set title
set number
set list
set laststatus=2
set listchars=tab:\ \ ,extends:<,trail:\ 
set statusline=[%L]\ %t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L

let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Opsplorer
let s:split_width = 32

"helptags ~/.vim/doc

" for perl
set iskeyword+=:
filetype plugin on

set autoindent
set smartindent
set showmatch
set wrapscan
set backspace=start,eol,indent
set wildmenu wildmode=list:full

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_max_list = 30
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

" 挿入モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

inoremap <silent> <C-a> <Esc>^<Insert>
inoremap <silent> <C-e> <Esc>$<Insert><Right>
inoremap <silent> <C-l> <Esc>$<Insert><Right> ;<Left><BS><Right>

" 行頭・行末移動方向をキーの相対位置にあわせる
nnoremap 0 $

" カーソル後の文字削除
inoremap <silent> <C-d> <Del>

" 引用符, 括弧の設定
inoremap { {}<Left>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap <> <><Left>

filetype off "ファイルタイプ関連を無効化

if has('vim_starting')
	if &compatible
	 set nocompatible   " Be iMproved0 endif
	endif
	 set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('$HOME/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'davidoc/taskpaper.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'altercation/vim-colors-solarized'
" NeoBundle 'git://git.wincent.com/command-t.git'
NeoBundle 'surround.vim'
" NeoBundle 'http://svn.macports.org/repository/macports/contrib/mpvim/'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'yegappan/mru'
NeoBundle "tyru/caw.vim.gitfiletype"
" NeoBundle 'Townk/vim-autoclose'
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'L9'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'everzet/phpfolding.vim'
NeoBundle 'gregsexton/gitv.git'
NeoBundle 'FuzzyFinder'
NeoBundle 'fatih/vim-go'
NeoBundle 'tomasr/molokai'
NeoBundle 'ujihisa/unite-colorscheme'


filetype plugin on
filetype indent on

"vimproc自動アップデート
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
"vimproc自動アップデート

NeoBundleLazy 'fatih/vim-go', {
            \ 'autoload' : { 'filetypes' : 'go'  }
            \ }

"Fuzzyfinder

nnoremap <unique> <silent> <space>fb :FufBuffer!<CR>
nnoremap <unique> <silent> <space>ff :FufFile!<CR>
nnoremap <unique> <silent> <space>fm :FufMruFile!<CR>
nnoremap <unique> <silent> <space>fc :FufRenewCache<CR>
autocmd FileType fuf nmap <C-c> <ESC>
let g:fuf_patternSeparator = ' '
let g:fuf_modesDisable = ['mrucmd']
let g:fuf_mrufile_exclude = '\v\.DS_Store|\.git|\.swp|\.svn'
let g:fuf_mrufile_maxItem = 100
let g:fuf_enumeratingLimit = 20
let g:fuf_file_exclude = '\v\.DS_Store|\.git|\.swp|\.svn'
" end Fuzzyfinder

call neobundle#end()

" 行末以降の空白を削除
" autocmd BufWritePre * :%s/\s\+$//e

" 削除キーでyankしない
 nnoremap x "_x
 "nnoremap d "_d
 nnoremap D "_D

nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" phpunitを実行する
nmap ,t :!phpunit
set whichwrap=b,s,<,>,[,]
set viminfo='20,\"2000

nmap <C-K> <Plug>(caw:i:toggle)
vmap <C-K> <Plug>(caw:i:toggle)

" yankround.vim {{{
"" キーマップ
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
" nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-prev)
"" 履歴取得数
let g:yankround_max_history = 50
""履歴一覧(kien/ctrlp.vim)
nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>
" }}}
nnoremap s <C-w>

""vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
autocmd FileType go :highlight goErr cterm=bold ctermfg=214
autocmd FileType go :match goErr /\<err\>/

nmap ,c :Unite colorscheme -auto-preview<CR>

