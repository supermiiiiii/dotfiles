"=== Introduction ========================================================={{{
"
"  neocomplcache.rc.vim
"
"   neocomplcache.vim settings
"
"   https://github.com/Shougo/neocomplcache
"   http://www.karakaram.com/vim/neocomplcache/
"   http://d.hatena.ne.jp/thinca/20091026/1256569191
"   http://vim-users.jp/2010/11/hack185/
"   http://d.hatena.ne.jp/cooldaemon/20090807/1249644264
"
"   補完候補のPrefix
"     abbrev_complete            -> [A]
"     filename_complete          -> [F] {filename}
"     dictionary_complete        -> [D] {words}
"     member_complete            -> [M] member
"     buffer_complete            -> [B] {buffername}
"     syntax_complete            -> [S] {syntax-keyword}
"     include_complete           -> [FI] or [I]
"     snippets_complete          -> [Snip] (none placeholders) or
"                                          <Snip> (contains placeholders)
"     vim_complete               -> [vim] type
"     omni_complete              -> [O]
"     tags_complete              -> [T]
"     other plugin sources       -> [plugin-name-prefix]
"     other completefunc sources -> [plugin-name-prefix]
"     other ftplugin sources     -> [plugin-name-prefix]
"
"==========================================================================}}}


" === NeoComplCacheCache =================================================={{{

" j,k の移動を表示行単位にする
" スニペット展開後のプレースホルダ移動がうまく行かない場合に設定
"nnoremap j gj
"onoremap j gj
"xnoremap j gj
"nnoremap k gk
"onoremap k gk
"xnoremap k gk

" FileType毎のOmni補完を設定
autocmd MyAutoCmd FileType javascript setlocal omnifunc=tern#Complete
autocmd MyAutoCmd FileType coffee setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd MyAutoCmd FileType html,markdown  setlocal omnifunc=htmlcomplete#CompleteTags
autocmd MyAutoCmd FileType css            setlocal omnifunc=csscomplete#CompleteCSS
autocmd MyAutoCmd FileType xml            setlocal omnifunc=xmlcomplete#CompleteTags
autocmd MyAutoCmd FileType php            setlocal omnifunc=phpcomplete#CompletePHP
autocmd MyAutoCmd FileType c              setlocal omnifunc=ccomplete#Complete
autocmd MyAutoCmd FileType ruby           setlocal omnifunc=rubycomplete#Complete


" === Basic {{{2

" let g:neocomplcache_enable_prefetch = 0

" 補完候補の一番先頭を選択状態にする(AutoComplPop互換)
let g:neocomplcache_enable_auto_select = 0

" ポップアップメニューで表示される最大候補数 (default:100)
let g:neocomplcache_max_list = 100

" プレビューを自動で閉じる
let g:neocomplcache_enable_auto_close_preview = 1

" 補完候補検索時に大文字・小文字を無視する
"let g:neocomplcache_enable_ignore_case = 1
" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1
" CamelCase の補完を有効化
let g:neocomplcache_enable_camel_case_completion = 1
" _(アンダーバー)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1
" Fuzzy completion.
let g:neocomplcache_enable_fuzzy_completion = 1

" 自動補完が開始される文字数(default:2)
let g:neocomplcache_auto_completion_start_length = 2
" 手動補完が開始される文字数(default:0)
let g:neocomplcache_manual_completion_start_length = 0

" 補完キャッシュの対象となるキーワードの最小文字長 (default:4)
let g:neocomplcache_min_keyword_length = 4
" 補完キャッシュの対象となるシンタックスの最小文字長 (default:4)
let g:neocomplcache_min_syntax_length = 3

let g:neocomplcache_enable_cursor_hold_i = 0
let g:neocomplcache_cursor_hold_i_time = 300
let g:neocomplcache_enable_insert_char_pre = 0
let g:neocomplcache_skip_auto_completion_time = '0.6'

if !exists('g:neocomplcache_wildcard_characters')
  let g:neocomplcache_wildcard_characters = {}
endif
let g:neocomplcache_wildcard_characters._ = '-'

let g:neocomplcache_enable_auto_delimiter = 1
"let g:neocomplcache_disable_caching_buffer_name_pattern = '[\[*]\%(unite\)[\]*]'
let g:neocomplcache_disable_auto_select_buffer_name_pattern = '\[Command Line\]'
"let g:neocomplcache_disable_auto_complete = 0
let g:neocomplcache_force_overwrite_completefunc = 1

" 補完キャッシュ対象となる最大ファイルサイズ (default:500000)
"   それ以上のファイルは :NeoComplCacheCachingBuffer で手動実行する必要がる
"let g:neocomplcache_caching_limit_file_size = 1000000

" let g:neocomplcache_source_look_dictionary_path = $HOME . '/words'
let g:neocomplcache_source_look_dictionary_path = ''

" source毎の補完呼び出し文字数
"   buffer_complete
"   member_complete
"   tags_complete
"   syntax_complete
"   include_complete
"   vim_complete
"   dictionary_complete
"   filename_complete
"   omni_complete
"   abbrev_complete
let g:neocomplcache_source_completion_length = {
  \ 'snippets_complete' : 2,
  \ 'look' : 4,
  \ }

" -入力による候補番号の表示
let g:neocomplcache_enable_quick_match = 1

" neocomplcacheを自動的にロックするバッファ名のパターン
" ku.vimやfuzzyfinderなど、neocomplcacheと相性が悪いプラグインを使用する場合に設定
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" 関数を補完するための区切り文字パターン
if !exists('g:neocomplcache_delimiter_patterns')
  let g:neocomplcache_delimiter_patterns = {}
endif
let g:neocomplcache_delimiter_patterns['php'] = ['->', '::', '\']
let g:neocomplcache_delimiter_patterns.vim = ['#']
let g:neocomplcache_delimiter_patterns.cpp = ['::']

" カーソルより後のキーワードパターンを認識
if !exists('g:neocomplcache_next_keyword_patterns')
  let g:neocomplcache_next_keyword_patterns = {}
endif
"let g:neocomplcache_next_keyword_patterns['php'] = '\h\w*>'

" zencoding連携
"let g:use_zen_complete_tag = 1

let g:neocomplcache_source_rank = {
  \ 'javascriptcomplete' : 500,
  \ 'jscomplete' : 500,
  \}

" }}}


" === Dictionary completion {{{2

" vimのデフォルト辞書を指定
"   neocomplcacheで "_" が指定されている場合は無視される
set dictionary&
      \ dictionary+=~/.vim/dict/_.dict,~/dotfiles.local/.vim/dict/_.dict

if !exists('g:neocomplcache_dictionary_patterns')
  let g:neocomplcache_dictionary_patterns = {}
endif
"let g:neocomplcache_dictionary_patterns.default = '\h\w\*'

" 辞書ファイルの指定
let g:neocomplcache_dictionary_filetype_lists = {
    \ '_'            : '$DOTVIM/dict/_.dict,'.expand('~/dotfiles.local/.vim/dict/_.dict'),
    \ 'default'      : '',
    \ 'scala'        : expand('$DOTVIM/bundle/vim-scala/dict/scala.dict'),
    \ 'java'         : expand('$DOTVIM/dict/java.dict'),
    \ 'c'            : expand('$DOTVIM/dict/c.dict'),
    \ 'cpp'          : expand('$DOTVIM/dict/cpp.dict'),
    \ 'javascript'   : expand('$DOTVIM/dict/javascript.dict'),
    \ 'ocaml'        : expand('$DOTVIM/dict/ocaml.dict'),
    \ 'perl'         : expand('$DOTVIM/dict/perl.dict'),
    \ 'php'          : expand('$DOTVIM/dict/php.dict'),
    \ 'scheme'       : expand('$DOTVIM/dict/scheme.dict'),
    \ 'vim'          : expand('$DOTVIM/dict/vim.dict'),
    \ 'vimshell'     : expand('~/.vimshell_hist'),
    \ 'int-termtter' : expand('~/.vimshell/int-history/int-termtter'),
    \ }

let g:neocomplcache_same_filetype_lists = {
  \ 'zsh'         : 'sh',
  \ 'bash'        : 'sh',
  \ 'perl'        : 'ref,man',
  \ 'erlang'      : 'man',
  \ 'objc'        : 'c',
  \ 'tt2html'     : 'html,perl',
  \ 'coffee'      : 'javascript,jquery',
  \ 'jquery'      : 'javascript',
  \ 'javascript'  : 'jquery',
  \ }

" }}}


" === Keyword completion {{{2

" 補完キーワードパターンを指定
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
" 日本語を補完候補として取得しないようにする
"let g:neocomplcache_keyword_patterns['default'] = '[\h,]\w*'
let g:neocomplcache_keyword_patterns['default'] = '[0-9a-zA-Z:#_]\+'
let g:neocomplcache_keyword_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplcache_keyword_patterns.coffee = '\h\w*@\h\w*'

" }}}


" === Include completion {{{2

" インクルードパスを指定
let g:neocomplcache_include_paths = {
  \ 'cpp'  : '.,/opt/local/include/gcc46/c++,/opt/local/include,/usr/include',
  \ 'c'    : '.,/usr/include',
  \ 'ruby' : '.,$HOME/.rvm/rubies/**/lib/ruby/1.8/',
  \ }

"インクルード文のパターンを指定
let g:neocomplcache_include_patterns = {
  \ 'cpp' : '^\s*#\s*include',
  \ 'ruby' : '^\s*require',
  \ 'perl' : '^\s*use',
  \ }

"インクルード先のファイル名の解析パターン
let g:neocomplcache_include_exprs = {
  \ 'ruby' : substitute(v:fname,'::','/','g')
  \ }

" ファイルを探す際に、この値を末尾に追加したファイルも探す。
let g:neocomplcache_include_suffixes = {
  \ 'ruby' : '.rb',
  \ 'haskell' : '.hs'
  \ }

" }}}


" === Omni completion {{{2

" オムニ補完の手動呼び出し
inoremap <expr><C-x><C-o> &filetype == 'vim' ? "\<C-x><C-v><C-p>" : neocomplcache#manual_omni_complete()

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.mail = '^\s*\w\+'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'

" autocmd MyAutoCmd FileType ruby let g:neocomplcache_source_disable = {
  " \ 'include_complete' : 1,
  " \ 'omni_complete' : 1
" \ }
" autocmd MyAutoCmd FileType ruby let g:neocomplcache_source_disable = {
  " \ 'include_complete' : 1
" \ }


if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
" let g:neocomplcache_force_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

" For clang_complete.
let g:neocomplcache_force_omni_patterns.c =
      \ '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library   = 1

" For jedi-vim.
let g:neocomplcache_force_omni_patterns.python = '[^. \t]\.\w*'

" Set $RSENSE_HOME path.
let g:neocomplcache#sources#rsense#home_directory = '/opt/rsense'

let g:neocomplcache_vim_completefuncs = {
      \ 'Ref' : 'ref#complete',
      \ 'Unite' : 'unite#complete_source',
      \ 'VimShellExecute' :
      \      'vimshell#vimshell_execute_complete',
      \ 'VimShellInteractive' :
      \      'vimshell#vimshell_execute_complete',
      \ 'VimShellTerminal' :
      \      'vimshell#vimshell_execute_complete',
      \ 'VimShell' : 'vimshell#complete',
      \ 'VimFiler' : 'vimfiler#complete',
      \ 'Vinarise' : 'vinarise#complete',
      \}

" }}}


" === Mappings {{{2

" NeoComplCacheを無効
nnoremap <Space>neod :NeoComplCacheDisable
" NeoComplCacheを有効
nnoremap <Space>neoe :NeoComplCacheEnable

" <C-l> : 補完候補の共通部分までを補完する
inoremap <expr><C-l> neocomplcache#complete_common_string()

" <C-h>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"

" <BS>: close popup and cancel completing.
"inoremap <expr><BS> pumvisible() ? neocomplcache#cancel_popup()."\<BS>" : "\<BS>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<BS>"

" undo
inoremap <expr><C-g> neocomplcache#undo_completion()

" C-nでneocomplcache補完
inoremap <expr><C-n> pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>"
" C-pでkeyword補完 (vim内蔵)
"inoremap <expr><C-p> pumvisible() ? "\<C-p>" : "\<C-p>\<C-n>"

" ファイル名補完
inoremap <expr><C-x><C-f>  neocomplcache#manual_filename_complete()

" C-kを押すと行末まで削除
" inoremap <C-k> <C-o>D

" For cursor moving in insert mode(Not recommended)
inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"

" }}}


" === Utility {{{2

" ファイル名を取得
"   http://d.hatena.ne.jp/cooldaemon/searchdiary?word=snippets
function! Filename(...)
  let filename = expand('%:t:r')
  if filename == '' | return a:0 == 2 ? a:2 : '' | endif
  return !a:0 || a:1 == '' ? filename : substitute(a:1, '$1', filename, 'g')
endf

" bufferを開いたらキャッシュ
autocmd MyAutoCmd BufReadPost,BufEnter,BufWritePost :NeoComplCacheCachingBuffer <buffer>

" manpageview のキーワードをキャッシュ
"autocmd MyAutoCmd BufFilePost Manpageview* silent execute ":NeoComplCacheCachingBuffer"

" Insertモードでキャッシュ
"  http://d.hatena.ne.jp/basyura/20120318/p1
"autocmd MyAutoCmd InsertEnter * call s:neco_pre_cache()
"function! s:neco_pre_cache()
  "if exists('b:neco_pre_cache')
    "return
  "endif
  "let b:neco_pre_cache = 1
  "if bufname('%') =~ g:neocomplcache_lock_buffer_name_pattern
    "return
  "endif
  ":NeoComplCacheCachingBuffer
  "":NeoComplCacheCachingDictionary
"endfunction

function! CompleteFiles(findstart, base)
  if a:findstart
    " Get cursor word.
    let cur_text = strpart(getline('.'), 0, col('.') - 1)

    return match(cur_text, '\f*$')
  endif

  let words = split(expand(a:base . '*'), '\n')
  let list = []
  let cnt = 0
  for word in words
    call add(list, {
          \ 'word' : word,
          \ 'abbr' : printf('%3d: %s', cnt, word),
          \ 'menu' : 'file_complete'
          \ })
    let cnt += 1
  endfor

  return { 'words' : list, 'refresh' : 'always' }
endfunction

" }}}

" }}}


" === Neosnippet =========================================================={{{

"   標準のスニペット群
"    ~/.vim/bundle/neosnippet/autoload/neosnippet/snippets

" ユーザー定義スニペット保存ディレクトリ
let g:neosnippet#snippets_directory =
      \ expand('~/dotfiles.local/.vim/snippets,').expand('~/.vim/snippets')

let g:neosnippet#enable_snipmate_compatibility = 1

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"### キーマッピング
" スニペット展開
imap <C-y> <Plug>(neosnippet_expand_or_jump)
smap <C-y> <Plug>(neosnippet_expand_or_jump)

" スニペット展開
" (スニペットが関係しないところでは行末まで削除)
"imap <expr><C-k> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<C-o>D"
"smap <expr><C-k> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<C-o>D"

" <Up><Down>キーにて補完候補を移動
inoremap <expr><Up> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"

" TAB
imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_jump_or_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" S-TAB
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Enter
" 補完候補が出ていたら確定、なければ改行
"inoremap <expr><CR>  pumvisible() ? neocomplcache#smart_close_popup() : "\<CR>"
" スニペット展開が可能なら展開、通常補完なら補完確定、それ以外は改行
imap <expr><CR> neosnippet#expandable() ?
      \ '<Plug>(neosnippet_expand_or_jump)' : pumvisible() ?
      \ neocomplcache#smart_close_popup() : '<CR>'

" Uniteでスニペットを表示
imap <C-s>  i_<Plug>(neosnippet_start_unite_snippet)

" ユーザ定義スニペットの編集
"   引数にfiletypeを渡すことで任意のファイルを編集可能
"   -runtime : Runtimeスニペットの編集
nnoremap <Space>nse :NeoSnippetEdit

xmap <silent>L     <Plug>(neosnippet_start_unite_snippet_target)
"imap <silent>S     <Plug>(neosnippet_start_unite_snippet)
xmap <silent>o     <Plug>(neosnippet_register_oneshot_snippet)

nnoremap <silent> [Window]f              :<C-u>Unite neosnippet/user neosnippet/runtime<CR>

" }}}


" vim: fdm=marker:
