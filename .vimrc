" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

set ignorecase          " 大文字小文字を区別しない
set smartcase           " 検索文字に大文字がある場合は大文字小文字を区別
set incsearch           " インクリメンタルサーチ
set hlsearch            " 検索マッチテキストをハイライト (2013-07-03 14:30 修正）

" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする
set display=uhex        " 印字不可能文字を16進数で表示

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start
imap ^H <Left><Del>
imap ^D <Right><Del>

" クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
" 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
if has('unnamedplus')
    " set clipboard& clipboard+=unnamedplus " 2013-07-03 14:30 unnamed 追加
    set clipboard& clipboard+=unnamedplus,unnamed 
else
    " set clipboard& clipboard+=unnamed,autoselect 2013-06-24 10:00 autoselect 削除
    set clipboard& clipboard+=unnamed
endif

" Swapファイル？Backupファイル？前時代的すぎ
" なので全て無効化する
set nowritebackup
set nobackup
set noswapfile

set list                " 不可視文字の可視化
set number              " 行番号の表示
set wrap                " 長いテキストの折り返し
set textwidth=0         " 自動的に改行が入るのを無効化
set colorcolumn=80      " その代わり80文字目にラインを入れる

" 前時代的スクリーンベルを無効化
set t_vb=
set novisualbell

" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
set tabstop=4           " tab幅4
set expandtab           " タブの代わりにスペースを挿入
set fileencoding=utf-8
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2
set cursorline

hi clear CursorLine
hi CursorLine gui=underline
syntax on

" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" insertモードのショートカット
" imap <c-e> <END>
" imap <c-a> <HOME>
" imap <c-h> <LEFT>
" imap <c-j> <DOWN>
" imap <c-k> <UP>
" imap <c-l> <Right>

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" Ctrl + hjkl でウィンドウ間を移動
"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" T + ? で各種設定をトグル
nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>

" make, grep などのコマンド後に自動的にQuickFixを開く
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)

" vim 起動時のみカレントディレクトリを開いたファイルの親ディレクトリに指定
autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" ~/.vimrc.localが存在する場合のみ設定を読み込む
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
    execute 'source ' . s:local_vimrc
endif

let s:noplugin = 0
let s:bundle_root = expand('~/.vim/bundle')
let s:neobundle_root = s:bundle_root . '/neobundle.vim'
if !isdirectory(s:neobundle_root) || v:version < 702
    " NeoBundleが存在しない、もしくはVimのバージョンが古い場合はプラグインを一切
    " 読み込まない
    let s:noplugin = 1
else
    " NeoBundleを'runtimepath'に追加し初期化を行う
    if has('vim_starting')
        execute "set runtimepath+=" . s:neobundle_root
    endif

    call neobundle#begin(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'
    call neobundle#end()

    NeoBundle 'w0ng/vim-hybrid'
    colorscheme hybrid

    " 非同期通信を可能にする
    " 'build'が指定されているのでインストール時に自動的に
    " 指定されたコマンドが実行され vimproc がコンパイルされる
    NeoBundle "Shougo/vimproc", {
        \ "build": {
        \   "windows"   : "make -f make_mingw32.mak",
        \   "cygwin"    : "make -f make_cygwin.mak",
        \   "mac"       : "make -f make_mac.mak",
        \   "unix"      : "make -f make_unix.mak",
        \ }}

    NeoBundle 'itchyny/lightline.vim'

    let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
        \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
        \ },
        \ 'component_function': {
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode',
        \   'ctrlpmark': 'CtrlPMark',
        \ },
        \ 'component_expand': {
        \   'syntastic': 'SyntasticStatuslineFlag',
        \ },
        \ 'component_type': {
        \   'syntastic': 'error',
        \ },
        \ 'separator': { 'left': '⮀', 'right': '⮂' },
        \ 'subseparator': { 'left': '⮁', 'right': '⮃'
        \ }
        \ }

    function! MyModified()
        return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction

    function! MyReadonly()
        return &ft !~? 'help' && &readonly ? '⭤' : ''
    endfunction

    function! MyFilename()
        let fname = expand('%:t')
        return fname == 'ControlP' ? g:lightline.ctrlp_item :
            \ fname == '__Tagbar__' ? g:lightline.fname :
            \ fname =~ '__Gundo\|NERD_tree' ? '' :
            \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
            \ &ft == 'unite' ? unite#get_status_string() :
            \ &ft == 'vimshell' ? vimshell#get_status_string() :
            \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
            \ ('' != fname ? fname : '[No Name]') .
            \ ('' != MyModified() ? ' ' . MyModified() : '')
    endfunction

    function! MyFugitive()
        try
            if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
                let mark = '⭠ '  " edit here for cool mark
                let _ = fugitive#head()
                return strlen(_) ? mark._ : ''
            endif
        catch
        endtry
        return ''
    endfunction

    function! MyFileformat()
        return winwidth(0) > 70 ? &fileformat : ''
        endfunction

        function! MyFiletype()
            return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
        endfunction

        function! MyFileencoding()
            return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
        endfunction

        function! MyMode()
            let fname = expand('%:t')
            return fname == '__Tagbar__' ? 'Tagbar' :
                \ fname == 'ControlP' ? 'CtrlP' :
                \ fname == '__Gundo__' ? 'Gundo' :
                \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
                \ fname =~ 'NERD_tree' ? 'NERDTree' :
                \ &ft == 'unite' ? 'Unite' :
                \ &ft == 'vimfiler' ? 'VimFiler' :
                \ &ft == 'vimshell' ? 'VimShell' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
            endfunction

            function! CtrlPMark()
                if expand('%:t') =~ 'ControlP'
                    call lightline#link('iR'[g:lightline.ctrlp_regex])
                    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
                        \ , g:lightline.ctrlp_next], 0)
                else
                    return ''
                endif
            endfunction

            let g:ctrlp_status_func = {
                \ 'main': 'CtrlPStatusFunc_1',
                \ 'prog': 'CtrlPStatusFunc_2',
                \ }

        function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
            let g:lightline.ctrlp_regex = a:regex
            let g:lightline.ctrlp_prev = a:prev
            let g:lightline.ctrlp_item = a:item
            let g:lightline.ctrlp_next = a:next
            return lightline#statusline(0)
        endfunction

        function! CtrlPStatusFunc_2(str)
            return lightline#statusline(0)
        endfunction

        let g:tagbar_status_func = 'TagbarStatusFunc'

        function! TagbarStatusFunc(current, sort, fname, ...) abort
            let g:lightline.fname = a:fname
            return lightline#statusline(0)
        endfunction

        augroup AutoSyntastic
            autocmd!
            autocmd BufWritePost *.c,*.cpp call s:syntastic()
        augroup END
        function! s:syntastic()
            SyntasticCheck
            call lightline#update()
        endfunction

        let g:unite_force_overwrite_statusline = 0
        let g:vimfiler_force_overwrite_statusline = 0
        let g:vimshell_force_overwrite_statusline = 0

    " ファイルタイププラグインおよびインデントを有効化
    " これはNeoBundleによる処理が終了したあとに呼ばなければならない
    filetype plugin indent on

    " 次に説明するがInsertモードに入るまではneocompleteはロードされない
    NeoBundleLazy 'Shougo/neocomplete.vim', {
        \ "autoload": {"insert": 1}}
    " neocompleteのhooksを取得
    let s:hooks = neobundle#get_hooks("neocomplete.vim")
    " neocomplete用の設定関数を定義。下記関数はneocompleteロード時に実行される
    function! s:hooks.on_source(bundle)
        let g:acp_enableAtStartup = 0
        let g:neocomplete#enable_smart_case = 1
        " NeoCompleteを有効化
        " NeoCompleteEnable
    endfunction
    
    " Insertモードに入るまでロードしない
    
    NeoBundleLazy 'Shougo/neosnippet.vim', {
        \ "autoload": {"insert": 1}}
    " 'GundoToggle'が呼ばれるまでロードしない
    NeoBundleLazy 'sjl/gundo.vim', {
        \ "autoload": {"commands": ["GundoToggle"]}}
    " '<Plug>TaskList'というマッピングが呼ばれるまでロードしない
    NeoBundleLazy 'vim-scripts/TaskList.vim', {
        \ "autoload": {"mappings": ['<Plug>TaskList']}}
    " HTMLが開かれるまでロードしない
    NeoBundleLazy 'mattn/zencoding-vim', {
        \ "autoload": {"filetypes": ['html']}}

    NeoBundle "thinca/vim-template"
    " テンプレート中に含まれる特定文字列を置き換える
    autocmd MyAutoCmd User plugin-template-loaded call s:template_keywords()
    function! s:template_keywords()
        silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
        silent! %s/<+FILENAME+>/\=expand('%:r')/g
    endfunction
    " テンプレート中に含まれる'<+CURSOR+>'にカーソルを移動
    autocmd MyAutoCmd User plugin-template-loaded
        \   if search('<+CURSOR+>')
        \ |   silent! execute 'normal! "_da>'
        \ | endif

    NeoBundleLazy "Shougo/unite.vim", {
          \ "autoload": {
          \   "commands": ["Unite", "UniteWithBufferDir"]
          \ }}
    NeoBundleLazy 'h1mesuke/unite-outline', {
          \ "autoload": {
          \   "unite_sources": ["outline"],
          \ }}
    nnoremap [unite] <Nop>
    nmap U [unite]
    nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
    nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
    nnoremap <silent> [unite]r :<C-u>Unite register<CR>
    nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
    nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
    nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
    nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
    nnoremap <silent> [unite]w :<C-u>Unite window<CR>
    let s:hooks = neobundle#get_hooks("unite.vim")
    function! s:hooks.on_source(bundle)
      " start unite in insert mode
      let g:unite_enable_start_insert = 1
      " use vimfiler to open directory
      call unite#custom_default_action("source/bookmark/directory", "vimfiler")
      call unite#custom_default_action("directory", "vimfiler")
      call unite#custom_default_action("directory_mru", "vimfiler")
      autocmd MyAutoCmd FileType unite call s:unite_settings()
      function! s:unite_settings()
        imap <buffer> <Esc><Esc> <Plug>(unite_exit)
        nmap <buffer> <Esc> <Plug>(unite_exit)
        nmap <buffer> <C-n> <Plug>(unite_select_next_line)
        nmap <buffer> <C-p> <Plug>(unite_select_previous_line)
      endfunction
    endfunction

    NeoBundleLazy "Shougo/vimfiler", {
          \ "depends": ["Shougo/unite.vim"],
          \ "autoload": {
          \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
          \   "mappings": ['<Plug>(vimfiler_switch)'],
          \   "explorer": 1,
          \ }}
    nnoremap <Leader>e :VimFilerExplorer<CR>
    " close vimfiler automatically when there are only vimfiler open
    autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
    let s:hooks = neobundle#get_hooks("vimfiler")
    function! s:hooks.on_source(bundle)
      let g:vimfiler_as_default_explorer = 1
      let g:vimfiler_enable_auto_cd = 1
      
      " .から始まるファイルおよび.pycで終わるファイルを不可視パターンに
      " 2013-08-14 追記
      let g:vimfiler_ignore_pattern = "\%(^\..*\|\.pyc$\)"
    
      " vimfiler specific key mappings
      autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()
      function! s:vimfiler_settings()
        " ^^ to go up
        nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
        " use R to refresh
        nmap <buffer> R <Plug>(vimfiler_redraw_screen)
        " overwrite C-l
        nmap <buffer> <C-l> <C-w>l
      endfunction
    endfunction

    NeoBundleLazy "mattn/gist-vim", {
          \ "depends": ["mattn/webapi-vim"],
          \ "autoload": {
          \   "commands": ["Gist"],
          \ }}

    " vim-fugitiveは'autocmd'多用してるっぽくて遅延ロード不可
    NeoBundle "tpope/vim-fugitive"
    NeoBundleLazy "gregsexton/gitv", {
          \ "depends": ["tpope/vim-fugitive"],
          \ "autoload": {
          \   "commands": ["Gitv"],
          \ }}

    NeoBundle 'tpope/vim-surround'
    NeoBundle 'vim-scripts/Align'
    NeoBundle 'vim-scripts/YankRing.vim'

    " if has('lua') && v:version > 703 && has('patch825') 2013-07-03 14:30 > から >= に修正
    " if has('lua') && v:version >= 703 && has('patch825') 2013-07-08 10:00 必要バージョンが885にアップデートされていました
    if has('lua') && v:version >= 703 && has('patch885')
        NeoBundleLazy "Shougo/neocomplete.vim", {
            \ "autoload": {
            \   "insert": 1,
            \ }}
        " 2013-07-03 14:30 NeoComplCacheに合わせた
        let g:neocomplete#enable_at_startup = 1
        let s:hooks = neobundle#get_hooks("neocomplete.vim")
        function! s:hooks.on_source(bundle)
            let g:acp_enableAtStartup = 0
            let g:neocomplet#enable_smart_case = 1
            " NeoCompleteを有効化
            " NeoCompleteEnable
        endfunction
    else
        NeoBundleLazy "Shougo/neocomplcache.vim", {
            \ "autoload": {
            \   "insert": 1,
            \ }}
        " 2013-07-03 14:30 原因不明だがNeoComplCacheEnableコマンドが見つからないので変更
        let g:neocomplcache_enable_at_startup = 1
        let s:hooks = neobundle#get_hooks("neocomplcache.vim")
        function! s:hooks.on_source(bundle)
            let g:acp_enableAtStartup = 0
            let g:neocomplcache_enable_smart_case = 1
            " NeoComplCacheを有効化
            " NeoComplCacheEnable 
        endfunction
    endif

    NeoBundleLazy 'Rip-Rip/clang_complete'
    let g:clang_periodic_quickfix = 1
    let g:clang_complete_copen = 1
    let g:clang_use_library = 1
    " this need to be updated on llvm update
    let g:clang_library_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/    XcodeDefault.xctoolchain/usr/lib'
    " specify compiler options
    let g:clang_user_options = '-std=c++11 -stdlib=libc++'

    NeoBundleLazy 'vim-scripts/javacomplete', {
        \   'build': {
        \       'cygwin': 'javac autoload/Reflection.java',
        \       'mac': 'javac autoload/Reflection.java',
        \       'unix': 'javac autoload/Reflection.java',
        \   },
        \}
    let g:java_highlight_all=1
    let g:java_highlight_debug=1
    let g:java_allow_cpp_keywords=1
    let g:java_space_errors=1
    let g:java_highlight_functions=1

    NeoBundleLazy "Shougo/neosnippet.vim", {
          \ "depends": ["honza/vim-snippets"],
          \ "autoload": {
          \   "insert": 1,
          \ }}
    let s:hooks = neobundle#get_hooks("neosnippet.vim")
    function! s:hooks.on_source(bundle)
      " Plugin key-mappings.
      imap <C-k>     <Plug>(neosnippet_expand_or_jump)
      smap <C-k>     <Plug>(neosnippet_expand_or_jump)
      xmap <C-k>     <Plug>(neosnippet_expand_target)
      " SuperTab like snippets behavior.
      imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: pumvisible() ? "\<C-n>" : "\<TAB>"
      smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"
      " For snippet_complete marker.
      if has('conceal')
        set conceallevel=2 concealcursor=i
      endif
      " Enable snipMate compatibility feature.
      let g:neosnippet#enable_snipmate_compatibility = 1
      " Tell Neosnippet about the other snippets
      let g:neosnippet#snippets_directory=s:bundle_root . '/vim-snippets/snippets'
    endfunction

    NeoBundle "nathanaelkane/vim-indent-guides"
    " let g:indent_guides_enable_on_vim_startup = 1 2013-06-24 10:00 削除
    let s:hooks = neobundle#get_hooks("vim-indent-guides")
    function! s:hooks.on_source(bundle)
      let g:indent_guides_guide_size = 1
      IndentGuidesEnable " 2013-06-24 10:00 追記
    endfunction

    NeoBundleLazy "sjl/gundo.vim", {
          \ "autoload": {
          \   "commands": ['GundoToggle'],
          \}}
    nnoremap <Leader>g :GundoToggle<CR>

    NeoBundleLazy "vim-scripts/TaskList.vim", {
          \ "autoload": {
          \   "mappings": ['<Plug>TaskList'],
          \}}
    nmap <Leader>T <plug>TaskList

    NeoBundleLazy "thinca/vim-quickrun", {
          \ "autoload": {
          \   "mappings": [['nxo', '<Plug>(quickrun)']]
          \ }}
    nmap <Leader>r <Plug>(quickrun)
    let s:hooks = neobundle#get_hooks("vim-quickrun")
    function! s:hooks.on_source(bundle)
      let g:quickrun_config = {
          \ "*": {"runner": "remote/vimproc"},
          \ }
    endfunction

    NeoBundle 'majutsushi/tagbar', {
          \ "autload": {
          \   "commands": ["TagbarToggle"],
          \ },
          \ "build": {
          \   "mac": "brew install ctags",
          \ }}
    nmap <Leader>t :TagbarToggle<CR>

    NeoBundle 'rking/ag.vim'
    " insert modeで開始
    let g:unite_enable_start_insert = 1
    " 大文字小文字を区別しない
    let g:unite_enable_ignore_case = 1
    let g:unite_enable_smart_case = 1
    " grep検索
    nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
    " カーソル位置の単語をgrep検索
    nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
    " grep検索結果の再呼出
    nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>
    " unite grep に ag(The Silver Searcher) を使う
    if executable('ag')
        let g:unite_source_grep_command = 'ag'
        let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
        let g:unite_source_grep_recursive_opt = ''
    endif

    NeoBundle 'scrooloose/syntastic'
    let g:syntastic_javascript_checker = "jshint"  "JavaScriptのSyntaxチェックはjshintで
    let g:syntastic_check_on_open = 0              "ファイルオープン時にはチェックをしない
    let g:syntastic_check_on_save = 1              "ファイル保存時にはチェックを実施

    " Djangoを正しくVimで読み込めるようにする
    NeoBundleLazy "lambdalisue/vim-django-support", {
          \ "autoload": {
          \   "filetypes": ["python", "python3", "djangohtml"]
          \ }}
    " Vimで正しくvirtualenvを処理できるようにする
    NeoBundleLazy "jmcantrell/vim-virtualenv", {
          \ "autoload": {
          \   "filetypes": ["python", "python3", "djangohtml"]
          \ }}

    NeoBundleLazy "davidhalter/jedi-vim", {
          \ "autoload": {
          \   "filetypes": ["python", "python3", "djangohtml"],
          \ },
          \ "build": {
          \   "mac": "pip install jedi",
          \   "unix": "pip install jedi",
          \ }}
    let s:hooks = neobundle#get_hooks("jedi-vim")
    function! s:hooks.on_source(bundle)
      " jediにvimの設定を任せると'completeopt+=preview'するので
      " 自動設定機能をOFFにし手動で設定を行う
      let g:jedi#auto_vim_configuration = 0
      " 補完の最初の項目が選択された状態だと使いにくいためオフにする
      let g:jedi#popup_select_first = 0
      " quickrunと被るため大文字に変更
      let g:jedi#rename_command = '<Leader>R'
    endfunction

    NeoBundleLazy "vim-pandoc/vim-pandoc", {
          \ "autoload": {
          \   "filetypes": ["text", "pandoc", "markdown", "rst", "textile"],
          \ }}

    NeoBundleLazy "lambdalisue/shareboard.vim", {
          \ "autoload": {
          \   "commands": ["ShareboardPreview", "ShareboardCompile"],
          \ },
          \ "build": {
          \   "mac": "pip install shareboard",
          \   "unix": "pip install shareboard",
          \ }}
    function! s:shareboard_settings()
      nnoremap <buffer>[shareboard] <Nop>
      nmap <buffer><Leader> [shareboard]
      nnoremap <buffer><silent> [shareboard]v :ShareboardPreview<CR>
      nnoremap <buffer><silent> [shareboard]c :ShareboardCompile<CR>
    endfunction
    autocmd MyAutoCmd FileType rst,text,pandoc,markdown,textile call s:shareboard_settings()
    let s:hooks = neobundle#get_hooks("shareboard.vim")
    function! s:hooks.on_source(bundle)
      " VimからPandocが見えないことが多々あるので念の為~/.cabal/binをPATHに追加
      let $PATH=expand("~/.cabal/bin:") . $PATH
    endfunction

    " インストールされていないプラグインのチェックおよびダウンロード
    NeoBundleCheck
endif

if has('gui_macvim')
    let $PYTHON3_DLL="/usr/local/Cellar/python3/3.4.2_1/Frameworks/Python.framework/Versions/3.4/Python"
endif
