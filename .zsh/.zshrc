### Introduction {{{
#
#  .zshrc
#
#  (in $ZDOTDIR : default $HOME)
#
#  initial setup file for only interective zsh
#  This file is read after .zprofile file is read.
#
#   zshマニュアル(日本語)
#    http://www.ayu.ics.keio.ac.jp/~mukai/translate/zshoptions.html
#
#   autoload
#    -U : ファイルロード中にaliasを展開しない(予期せぬaliasの書き換えを防止)
#    -z : 関数をzsh-styleで読み込む
#
#   typeset
#    -U 重複パスを登録しない
#    -x exportも同時に行う
#    -T 環境変数へ紐付け
#
#   path=xxxx(N-/)
#     (N-/): 存在しないディレクトリは登録しない。
#     パス(...): ...という条件にマッチするパスのみ残す。
#        N: NULL_GLOBオプションを設定。
#           globがマッチしなかったり存在しないパスを無視する
#        -: シンボリックリンク先のパスを評価
#        /: ディレクトリのみ残す
#        .: 通常のファイルのみ残す
#
#************************************************************************** }}}


### The prompt settings {{{
#

# Theme.
ZSH_THEME='yonchu'
#ZSH_THEME='yonchu-2lines'

# Remove any right prompt from display when accepting a command line.
# This may be useful with terminals with other cut/paste methods.
#setopt transient_rprompt

# Certain escape sequences may be recognised in the prompt string.
# e.g. Environmental variables $WINDOW
setopt prompt_subst

# Certain escape sequences that start with `%' are expanded.
#setopt prompt_percent

# Initialize colors.
# Could use `$fg[red]' to get the code for foreground color red.
autoload -Uz colors
colors

# hook
#  http://d.hatena.ne.jp/kiririmode/20120327/p1
autoload -Uz add-zsh-hook

## Set prompt.
if [ ${UID} -eq 0 ]; then
    # Prompt for "root" user (all red characters).
    # Note: su - or sudo -s を行った場合は環境変数が引き継がれない
    PROMPT="${reset_color}${fg[red]}[%n@%m:%~]%#${reset_color} "
    PROMPT2="${reset_color}${fg[red]}%_>${reset_color} "
    SPROMPT="${reset_color}${fg[red]}%r is correct? [n,y,a,e]:${reset_color} "
else
    # Prompt for "normal" user.
    # Loading theme
    if [ -f ~/.zsh/themes/"$ZSH_THEME".zsh-theme ]; then
        echo "Loading theme: $ZSH_THEME"
        source ~/.zsh/themes/"$ZSH_THEME".zsh-theme
    else
        echo "Error: could not load the theme '$ZSH_THEME'"
    fi
fi

# }}}


### Default shell configuration {{{
#
# core抑制
limit coredumpsize 0
# 新しく作られたファイルのパーミッションを 644 に
umask 022
# 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する
setopt auto_cd
# cd でTabを押すとdir list を表示
# cd - <tab>で履歴表示->表示された番号を押してReturn
setopt auto_pushd
# ディレクトリスタックに同じディレクトリを追加しないようになる
setopt pushd_ignore_dups
# pushd 引数ナシ == pushd $HOME
setopt pushd_to_home
# コマンドのスペルチェックをする
setopt correct
# コマンドライン全てのスペルチェックをする
setopt correct_all
# 上書きリダイレクトの禁止
setopt no_clobber
# {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl
# 8ビットクリーン表示
#  補完候補リストの日本語表示対応
setopt print_eight_bit
# "~$var" でディレクトリにアクセス
#setopt auto_name_dirs
# 先頭に "~" を付けたもので展開
#setopt cdable_vars
# 変数内の文字列分解のデリミタ
setopt sh_word_split

# 複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる
#  $ < file1  # cat
#  $ < file1 < file2  # 2ファイル同時cat
#  $ < file1 > file3  # file1をfile3へコピー
#  $ < file1 > file3 | cat  # コピーしつつ標準出力にも表示
#  $ cat file1 > file3 > /dev/stdin  # tee
setopt multios

# 最後がディレクトリ名で終わっている場合末尾の / を自動的に取り除かない
setopt noautoremoveslash
# beepを鳴らさない
setopt no_beep
# beepを鳴らさない
setopt nolistbeep
# =command を command のパス名に展開する
setopt equals
# Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt no_flow_control
# コマンド名に / が含まれているとき PATH 中のサブディレクトリを探す
setopt path_dirs
# 戻り値が 0 以外の場合終了コードを表示する
setopt print_exit_value
# コマンドラインがどのように展開され実行されたかを表示するようになる
#setopt xtrace
# rm * 時に確認する
setopt rm_star_wait
# バックグラウンドジョブが終了したら(プロンプトの表示を待たずに)すぐに知らせる
setopt notify
# jobsでプロセスIDも出力
setopt long_list_jobs
# サスペンド中のプロセスと同じコマンド名を実行した場合はリジュームする
setopt auto_resume
# Ctrl+D では終了しないようになる（exit, logout などを使う）
#setopt ignore_eof
#
# 実行したプロセスの消費時間が3秒以上かかったら
# 自動的に消費時間の統計情報を表示
REPORTTIME=3

# *, ~, ^ の 3 文字を正規表現として扱う
# Match without pattern
#  ex. > rm *~398
#  remove * without a file "398". For test, use "echo *~398"
setopt extended_glob

# globでパスを生成したときに、パスがディレクトリだったら最後に「/」をつける。
setopt mark_dirs

# URLをコピペしたときに自動でエスケープ
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# 改行のない出力をプロンプトで上書きするのを防ぐ
unsetopt promptcr

# 全てのユーザのログイン・ログアウトを監視
watch="all"

## zsh editor
#
#autoload zed

# }}}


### Keybind configuration {{{
# $ bindkey で現在の割り当てを確認
#
# emacs like keybind
bindkey -e
# fn + delete の有効
bindkey "^[[3~" delete-char
# delete
bindkey '^D' delete-char
# Backspace
bindkey '^T' backward-delete-char
bindkey '^Q' backward-delete-char
# カーソル位置から後方全削除
# override kill-whole-line
bindkey '^U' backward-kill-line
# カーソル位置から前方全削除
bindkey '^Y' kill-line
# 単語移動
bindkey "^F" forward-word
bindkey "^B" backward-word
# 後方単語削除
bindkey "^W" backward-kill-word
# コマンド入力を実行せずに無視して次の行へ
bindkey "^C" send-break
# クリアスクリーン
#bindkey "^Q" clear-screen
# screenのエスケープとかぶるので割り当てなし
bindkey -r "^O"

# back-wordでの単語境界の設定
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /@*?_-.[]~=&;!#$%^(){}<>"
zstyle ':zle:*' word-style unspecified

# コマンド履歴
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
#bindkey "\\ep" history-beginning-search-backward-end
#bindkey "\\en" history-beginning-search-forward-end

# glob(*)によるインクリメンタルサーチ
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

# Command Line Stack [Esc]-[q]  -a: viins
bindkey -a 'q' push-line

# HELP読み出し
# run-helpはデフォルトではmanがaliasとして設定されているためaliasを削除
[ $(alias run-help) ] && unalias run-help
autoload run-help
bindkey '^@' run-help

# 右プロンプトの表示/非表示
unsetopt-transient-rprompt(){ unsetopt transient_rprompt; }
zle -N unsetopt-transient-rprompt
bindkey '^XR' unsetopt-transient-rprompt
setopt-transient-rprompt(){ setopt transient_rprompt; }
zle -N setopt-transient-rprompt
bindkey '^Xr' setopt-transient-rprompt


# Command Line Stack の改良版
push_line_and_show_buffer_stack() {
    POSTDISPLAY="
stack: $LBUFFER"
    zle push-line-or-edit
}
zle -N push_line_and_show_buffer_stack
bindkey '^[Q' push_line_and_show_buffer_stack
bindkey '^[q' push_line_and_show_buffer_stack


# ^でcd ..する
# http://shakenbu.org/yanagi/d/?date=20120301
cdup() {
    if [ -z "$BUFFER" ]; then
        echo
        cd ..
        if type precmd > /dev/null 2>&1; then
            precmd
        fi
        local precmd_func
        for precmd_func in $precmd_functions; do
            $precmd_func
        done
        zle reset-prompt
    else
        zle self-insert '^'
    fi
}
zle -N cdup
bindkey '\^' cdup


# 表示されているコマンドをクリップボードへ
#  http://d.hatena.ne.jp/hiboma/20120315/1331821642
pbcopy-buffer(){
    # -r エスケープシーケンスを解釈しない
    # -n 最後に改行を入力しない
    print -rn $BUFFER | pbcopy
    zle -M "pbcopy: ${BUFFER}"
}
zle -N pbcopy-buffer
bindkey '^x^p' pbcopy-buffer

# }}}


### History configuration {{{
#
HISTFILE=~/.zsh_history
HISTSIZE=10000   # メモリ内の履歴の数
SAVEHIST=100000  # 保存される履歴の数
LISTMAX=50       # 補完リストを尋ねる数(0=ウィンドウから溢れる時は尋ねる)
# rootのコマンドはヒストリに追加しない
if [ $UID = 0 ]; then
    unset HISTFILE
    SAVEHIST=0
fi

# 登録済コマンド行は古い方を削除
setopt hist_ignore_all_dups
# historyの共有 (悩みどころ)
setopt share_history
#unsetopt share_history
# 余分な空白は詰める
setopt hist_reduce_blanks
# add history when command executed.
setopt inc_append_history
# history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store
# ヒストリから関数定義を取り除く
setopt hist_no_functions
# zsh の開始・終了時刻をヒストリファイルに書き込む
setopt extended_history
# スペースで始まるコマンドはヒストリに追加しない
setopt hist_ignore_space
# 履歴を追加 (毎回 .zhistory を作らない)
setopt append_history
# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space
# ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_verify
# !を使ったヒストリ展開を行う
setopt bang_hist

# }}}


### Completion configuration {{{
#
# 補完関数のパス(fpath)を登録
#
# 重複パスを登録しない
typeset -U fpath
#  zsh-completions
#   https://github.com/zsh-users/zsh-completions.git
fpath=(~/.zsh/functions/Completion/zsh-completions(N-/) ${fpath})
# /usr/local 配下
#fpath=(/usr/local/share/zsh/functions(N-/) /usr/local/share/zsh/site-functions(N-/) ${fpath})
# homebrewでインストールしたコマンドの補完関数
#if type brew >/dev/null 2>&1; then
    #BREW_PREFIX=$(brew --prefix)
    #fpath=($BREW_PREFIX/share/zsh/functions(N-/) $BREW_PREFIX/share/zsh/site-functions(N-/) ${fpath})
#fi
# ユーザ固有の補完関数
fpath=(~/.zsh/functions/Completion(N-/) ${fpath})

autoload -U compinit
# -u : 安全ではないファイルを補完しようとした場合に警告を表示しない
# -d : .zcompdumpの場所
compinit -u -d ~/.zcompdump

# 補完候補リストを詰めて表示
setopt list_packed
# auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示
setopt list_types
# 補完候補が複数ある時に、一覧表示する
setopt auto_list
# 一覧表示せずに、すぐに最初の候補を補完
#setopt menu_complete
# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst
# カッコの対応などを自動的に補完する
setopt auto_param_keys
# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
# 移動先がシンボリックリンクならば実際のディレクトリに移動する
setopt chase_links
# パスに..が含まれる場合実際のディレクトリに移動?
#setopt chase_dots
# 補完キー（Tab,  Ctrl+I) を連打するだけで順に補完候補を自動で補完する
setopt auto_menu
# カーソル位置で補完する。
setopt complete_in_word
# プロンプトを保持したままファイル名一覧を順次その場で表示(default=on)
setopt always_last_prompt
# globを展開しないで候補の一覧から補完する。
#  Ctrl+x g glob展開
setopt glob_complete
# 補完時にヒストリを自動的に展開する。
setopt hist_expand
# 補完候補がないときなどにビープ音を鳴らさない。
setopt no_beep
# 辞書順ではなく数字順に並べる。
setopt numeric_glob_sort
# 補完で末尾に補われた / をスペース挿入で自動的に削除
setopt auto_remove_slash

# sudo用pathを設定
# typeset -T は重複実行できないため一度環境変数を削除する
# (Reloadで失敗しないようにするため)
unset SUDO_PATH
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({/usr/local,/usr,}/sbin(N-/))
export SUDO_PATH
# sudo時の補完対象の設定
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"

# 補完候補がない場合の曖昧検索
#  m:{a-z}={A-Z}: 大文字小文字無視
#  r:|[._-]=*: 「.」「_」「-」の前にワイルドカード「*」があるものとして補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'

# 補完候補を矢印キーで選択
#  select=n: 補完候補がn以上なければすぐに補完
zstyle ':completion:*:default' menu select=1

# 詳細な情報を使う。
zstyle ':completion:*' verbose true

## cd
# カレントディレクトリに候補がない場合のみ cdpath 上のディレクトリを候補にする
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
# 親ディレクトリから補完時にカレントディレクトリ表示しない (e.g. cd ../<TAB>):
zstyle ':completion:*:cd:*' ignore-parents parent pwd ..
# 重複パスを登録しない
typeset -U cdpath
cdpath=($HOME{,/links}(N-/))

# 補完方法毎にグループ化し、グループ名に説明を付加
#  %F...%f : カラー
#  %B...%b : 太字
#  %U...%u : 下線
#  %d      : 補完候補の説明(ラベル)
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B%d:%b'
zstyle ':completion:*:options' description 'yes'

# manのセクション番号を表示
zstyle ':completion:*:manuals' separate-sections true

# 補完方法の設定:指定した順番に実行
#  _oldlist 前回の補完結果を再利用
#  _complete: 補完
#  _match: globを展開しないで候補の一覧から補完
#  _history: ヒストリのコマンドから補完
#  _ignored: 補完候補にださないと指定したものもから補完
#  _approximate: 似ている候補を補完
#  _correct: 綴り修正(入力を終えた部分のみ修正)
#  _prefix: カーソル以降を無視してカーソル位置までで補完
#  _list, expand, etc
zstyle ':completion:*' completer \
    _oldlist _complete _match _history _ignored _approximate _prefix

## cdr <TAB> (最近移動したディレクトリ履歴からcd)
autoload -U chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ":chpwd:*" recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file ~/.chpwd-recent-dirs
zstyle ":chpwd:*" recent-dirs-max 500
zstyle ":completion:*" recent-dirs-insert both
zstyle ":completion:*:*:cdr:*:*" menu select=2

## 補完キャッシュの設定
# 一部のコマンドライン定義は、展開時に時間のかかる処理を行う
# apt-get, dpkg (Debian), rpm (Redhat), urpmi (Mandrake), perlの-Mオプション,
# bogofilter (zsh 4.2.1以降), fink, mac_apps (MacOS X)(zsh 4.2.2以降)
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zcompcache


## 補完候補の色分け
if [ -n "$LS_COLORS" ]; then
    # LS_COLORSの色と対応
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
elif [ -n "$LSCOLORS" ]; then
    # LSCOLORSの色と対応
    zstyle ':completion:*:default' list-colors ${(s.:.)LSCOLORS}
fi


## Prediction configuration
#   先方予測機能(学習機能付き)
#
#autoload -U predict-on
#predict-on

# }}}


## Alias configuration {{{
#
# aliasが補完される前に元のコマンドまで展開してチェック
setopt complete_aliases     # aliased ls needs if file/dir completions work

# ホームディレクトリ(~/)展開
expand-to-home-or-insert () {
    if [ "$LBUFFER" = "" -o "$LBUFFER[-1]" = " " ]; then
        LBUFFER+="~/"
    else
        zle self-insert
    fi
}

# ls alias setting
case "${OSTYPE}" in
    freebsd*|darwin*)
        # -F ファイルタイプを示す文字を表示
        if which gls > /dev/null 2>&1; then
            # -b 非印字文字を強制表示
            # -v natural sort of (version) numbers within text
            alias ls="gls -abhvF --color=auto"
        else
            # -v 非印字文字を強制表示
            # -G カラー表示
            alias ls="ls -avhFG"
        fi
        # ~/を別キーに割り当て
        # http://vim-users.jp/2010/01/hack118/
        #zle -N expand-to-home-or-insert
        #bindkey "@"  expand-to-home-or-insert
        ;;
    linux*)
        # -b 非印字文字を強制表示
        # -v natural sort of (version) numbers within text
        alias ls="ls -abhvF --color=auto"
        ;;
esac

# }}}


### Terminal configuration {{{
#
# ターミナル固有設定
case "${TERM}" in
    kterm*|xterm*|screen*)
        _change_terminal_title_preexec_hook() {
            if [ "$STY" ]; then
                # コマンド実行時にコマンド名をタイトルに設定(screen)
                echo -ne "\ek${1%% *}\e\\"
            fi
        }
        add-zsh-hook preexec _change_terminal_title_preexec_hook

        _change_terminal_title_precmd_hook() {
            if [ "$STY" ]; then
                echo -ne "\ek$(basename $(pwd))\e\\"
            else
                echo -ne "\033]0;$(basename $(pwd))\007"
            fi
            return 0
        }
        add-zsh-hook precmd _change_terminal_title_precmd_hook
        ;;
esac

# }}}


### Misc {{{
#
# cd後にls
chpwd() {
    local CMD_LS='ls -a -v -F'
    case "${OSTYPE}" in
        freebsd*|darwin*)
            # -F ファイルタイプを示す文字を表示
            if type gls > /dev/null 2>&1; then
                # -b 非印字文字を強制表示
                # -v natural sort of (version) numbers within text
                CMD_LS='gls -abvF --color=auto'
            else
                # -v 非印字文字を強制表示
                # -G カラー表示
                CMD_LS='ls -avFG'
            fi
            ;;
        linux*)
            # -b 非印字文字を強制表示
            # -v natural sort of (version) numbers within text
            CMD_LS='ls -abvF --color=auto'
            ;;
    esac
    # ファイル数が多い場合は表示するファイルを制限
    if [ 150 -le $(command ls -A |wc -l) ]; then
        command $CMD_LS -C | head -n 5
        echo '...'
        command $CMD_LS -C | tail -n 5
        echo "$(command ls -A | wc -l | tr -d ' ') files exist"
    else
        command $CMD_LS
    fi
    # cdd
    type _cdd_chpwd >/dev/null 2>&1 && _cdd_chpwd
}

# }}}


### Source configuration files {{{
#
# pluginの読み込み
#
if [ -d ~/.zsh/plugins ]; then
    for plugin in ~/.zsh/plugins/*.zsh; do
        if [ -f "$plugin" ]; then
            echo "Loading plugin: ${plugin##*/}"
            source "$plugin"
        fi
    done
fi

#
# alias設定(共通)
#
if [ -f ~/dotfiles/.alias ]; then
    source ~/dotfiles/.alias
fi

#
# alias設定(zsh固有)
#
if [ -f ~/.zsh/.zalias ]; then
    source ~/.zsh/.zalias
fi

#
# local固有設定
#
if [ -f ~/dotfiles.local/.shrc.local ]; then
    source ~/dotfiles.local/.shrc.local
fi

# }}}


### tmux/screen automatically running {{{
#
#  ログイン時にtmux または screenが起動してない場合は自動的に起動
#  デタッチ済みセッションが存在すればアタッチし、なければ新規セッションを生成
#  tmuxを優先して起動し、tmuxが使えなければscreenを起動する
#
if [ ${UID} -ne 0 -a -z "$TMUX" -a -z "$STY" ]; then
    if type tmuxx >/dev/null 2>&1; then
        tmuxx
    elif type tmux >/dev/null 2>&1; then
        if tmux has-session && tmux list-sessions | egrep -q '.*]$'; then
            # デタッチ済みセッションが存在する
            tmux attach && echo "tmux attached session "
        else
            tmux new-session && echo "tmux created new session"
        fi
    elif type screen >/dev/null 2>&1; then
        screen -rx || screen -D -RR
    fi
fi

# }}}


### pythonbrew {{{
#
# Note: Must set this settings after other PATH settings
#
# Source
[ -s $HOME/.pythonbrew/etc/bashrc ] && source $HOME/.pythonbrew/etc/bashrc
# Automatically running
if type pybrew > /dev/null 2>&1; then
    echo
    echo 'Pybrew automatically running...'
    echo "pybrew version: $(pybrew --version)"
    if [ -n "$DEFAULT_PYTHON_VERSION" -a "$DEFAULT_PYTHON_VENV" ]; then
        pybrew switch "$DEFAULT_PYTHON_VERSION" \
            && pybrew venv use "$DEFAULT_PYTHON_VENV"
    fi
    echo "Python: $(which python)"
    echo
fi

# }}}


# 重複パスを強制削除
path=($path)

### Complete Messages
echo "Loading .zshrc completed!! (ZDOTDIR=${ZDOTDIR})"
echo "Now zsh version $ZSH_VERSION starting!!"
echo '(」・ω・)」うー！(／・ω・)／にゃー！'

# Print log
log

# vim: fdm=marker fen fdl=0

