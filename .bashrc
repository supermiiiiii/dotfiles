#*******************************************************************************
#
# .bashrc
#   シェル起動時に毎回読み込まれる
#
#*******************************************************************************

# If not running interactively, don't do anything
test -z "$PS1" && return

#
# completionファイルの読み込み
#
if type brew >/dev/null 2>&1; then
    BREW_PREFIX=$(brew --prefix)
    if [ -e $BREW_PREFIX/Library/Contributions/brew_bash_completion.sh ]; then
        source $BREW_PREFIX/Library/Contributions/brew_bash_completion.sh >/dev/null 2>&1
    fi
fi
if [ -d /usr/local/etc/bash_completion.d ]; then
    source /usr/local/etc/bash_completion.d/*.sh >/dev/null 2>&1
    source /usr/local/etc/bash_completion.d/*.bash >/dev/null 2>&1
fi

#
# プロンプトの設定
#  \u  : ユーザ名
#  \h  : マシン名
#  \W  : カレントディレクトリ  \w : カレントディレクトリもフルパス
#  \\$ : スーパーユーザは「#」一般ユーザは「$」で表示
#  __git_ps1 : gitブランチ
#    http://d.hatena.ne.jp/ruedap/20110706/mac_terminal_git_branch_name
#
if type __git_ps1 >/dev/null 2>&1; then
    export PS1='[\[\033[032m\]\u@\h\[\033[00m\]:\[\033[36m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]]\$ '
else
    export PS1='[\[\033[032m\]\u@\h\[\033[00m\]:\[\033[36m\]\w\[\033[00m\]]\$ '
fi


#
# その他
#

# 新しく作られたファイルのパーミッションを 644 に
umask 022

# core ファイルを作らせない
#ulimit -c 0

# リダイレクションによるファイルの上書きを禁止
set -o noclobber

# cdコマンドの補完ではディレクトリのみを対象にする
complete -d cd


#
# history setting
#  ヒストリにサーチ機能を付加
bind '"\e[A": history-search-backward'
bind '"\e[0A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[0B": history-search-forward'


#
# alias設定(共通)
#
if [ -f ~/dotfiles/.alias ]; then
    source ~/dotfiles/.alias
fi

#
# local固有設定
#
if [ -f ~/dotfiles.local/.shrc.local ]; then
    source ~/dotfiles.local/.shrc.local
fi


## complete message
echo ".bashrc load completed..."
echo "Now bash version $BASH_VERSION start!"