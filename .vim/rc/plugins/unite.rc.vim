" === Basic Settings. {{{
let g:unite_enable_auto_select = 0
let g:unite_ignore_source_files = []
let g:unite_source_rec_max_cache_files = -1

" Grep engine.
if executable('hw')
  " hw(highway)
  " https://github.com/tkengo/highway
  let g:unite_source_grep_command = 'hw'
  let g:unite_source_grep_default_opts = '--no-group --no-color'
  let g:unite_source_grep_recursive_opt = ''
elseif executable('ag')
  " ag(the silver searcher)
  " https://github.com/ggreer/the_silver_searcher
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
        \ '-S --vimgrep --hidden' .
        \ '--ignore ''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
elseif executable('pt')
  " pt(the platinum searcher)
  " https://github.com/monochromegane/the_platinum_searcher
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
elseif executable('jvgrep')
  " jvgrep
  " https://github.com/mattn/jvgrep
  let g:unite_source_grep_command = 'jvgrep'
  let g:unite_source_grep_default_opts = '-i --exclude ''\.(git|svn|hg|bzr)'''
  let g:unite_source_grep_recursive_opt = '-R'
elseif executable('ack')
  " ack.
  let g:unite_source_grep_command = 'ack'
  let g:unite_source_grep_default_opts = '-i --no-heading --no-color -k -H'
  let g:unite_source_grep_recursive_opt = ''
else
  let g:unite_source_grep_default_opts = '-niE --color=never'
endif

" Unite menu.
if !exists('g:unite_source_menu_menus')
  let g:unite_source_menu_menus = {}
endif
" }}}

" === Custom Settings. {{{
" Default context.
let default_context = {
      \ 'vertical' : 0,
      \ 'short_source_names' : 0,
      \ }
call unite#custom#profile('default', 'context', default_context)
" Action context.
call unite#custom#profile('action', 'context', {
      \ 'start_insert' : 1,
      \ })

" Default file action.
call unite#custom#default_action('file', 'tabopen')

" message.
call unite#custom#source('message', 'sorters', 'sorter_reverse')

" migemo.
call unite#custom#source('line_migemo', 'matchers', 'matcher_migemo')

" Files.
call unite#custom#source(
      \ 'buffer,file_rec,file_rec/async,file_rec/git', 'matchers',
      \ ['converter_relative_word', 'matcher_default', 'matcher_fuzzy'])
call unite#custom#source(
      \ 'file_mru', 'matchers',
      \ ['matcher_default', 'matcher_fuzzy',
      \  'matcher_hide_hidden_files', 'matcher_hide_current_file'])
call unite#custom#source(
      \ 'file_rec,file_rec/async,file_rec/git,file_mru', 'converters',
      \ ['converter_uniq_word','converter_word_abbr'])
call unite#filters#sorter_default#use(['sorter_rank'])
" }}}

" === unite-alias. {{{
let g:unite_source_alias_aliases = {}
let g:unite_source_alias_aliases.test = {
      \ 'source' : 'file_rec',
      \ 'args'   : '~/',
      \ }

" Nominates executable files from $PATH as candidates.
let g:unite_source_alias_aliases.l = 'launcher'

" Nominates processes. Requires 'ps' command or 'tasklist' command(in Windows).
let g:unite_source_alias_aliases.kill = 'process'

" vim :message
let g:unite_source_alias_aliases.message = {
      \ 'source' : 'output',
      \ 'args'   : 'message',
      \ }
let g:unite_source_alias_aliases.mes = {
      \ 'source' : 'output',
      \ 'args'   : 'message',
      \ }
" vim :scriptnames
let g:unite_source_alias_aliases.scriptnames = {
      \ 'source' : 'output',
      \ 'args'   : 'scriptnames',
      \ }
" }}}

" === My settings in AutoCmd. {{{
autocmd MyAutoCmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings() abort
  " Directory partial match.
  call unite#custom#alias('file', 'h', 'left')
  call unite#custom#default_action('directory', 'narrow')

  " Overwrite settings.
  imap <buffer>  jj        <Plug>(unite_insert_leave)
  imap <buffer>  <Tab>     <Plug>(unite_complete)
  imap <buffer> '          <Plug>(unite_quick_match_default_action)
  nmap <buffer> '          <Plug>(unite_quick_match_default_action)
  nmap <buffer> x          <Plug>(unite_quick_match_jump)
  nmap <buffer> <C-z>      <Plug>(unite_toggle_transpose_window)
  imap <buffer> <C-z>      <Plug>(unite_toggle_transpose_window)
  imap <buffer> <C-w>      <Plug>(unite_delete_backward_path)
  nmap <buffer> <C-j>      <Plug>(unite_toggle_auto_preview)
  nmap <buffer> <C-c>      <Plug>(unite_exit)
  imap <buffer> <C-c>      <ESC><Plug>(unite_exit)
  nnoremap <silent><buffer> <Tab> <C-w>w
  nnoremap <silent><buffer><expr> l
        \ unite#smart_map('l', unite#do_action('default'))
  nnoremap <silent><buffer><expr> P
        \ unite#smart_map('P', unite#do_action('insert'))
  nnoremap <silent><buffer><expr> cd    unite#do_action('lcd')
  nnoremap <silent><buffer><expr> !     unite#do_action('start')

  " r: replce or rename.
  let unite = unite#get_current_unite()
  if unite.profile_name =~# '^search' || unite.profile_name =~# '^grep'
    nnoremap <silent><buffer><expr> r     unite#do_action('replace')
  else
    nnoremap <silent><buffer><expr> r     unite#do_action('rename')
  endif

  " Show line number in output/shellcmd.
  if has_key(unite, 'sources') && len(unite.sources) > 0
        \ && unite.sources[0].name =~# '^output/shellcmd'
    setl number
  endif

  " Change current sorters.
  nnoremap <buffer><expr> R
        \ unite#mappings#set_current_sorters(
        \ empty(unite#mappings#get_current_sorters()) ?
        \ ['sorter_reverse'] : [])
  nnoremap <buffer><expr> cof
        \ unite#mappings#set_current_matchers(
        \ empty(unite#mappings#get_current_matchers()) ?
        \ ['matcher_fuzzy'] : [])
  nnoremap <buffer><expr> <C-a>
        \ unite#mappings#set_current_matchers(
        \ empty(unite#mappings#get_current_matchers()) ?
        \ ['matcher_project_files'] : [])

  nmap <buffer> <C-m> <Plug>(unite_print_message_log)
endfunction
" }}}
