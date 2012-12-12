#*******************************************************************************
#
# .bashrc
#   シェル起動時に毎回読み込まれる
#
#*******************************************************************************

# If not running interactively, don't do anything
test -z "$PS1" && return

if [ "${SHELL##*/}" = 'zsh' ]; then
    SHELL=$(which bash)
fi

#
# Completionファイルの読み込み
#
if [ -f "$USER_LOCAL/etc/bash_completion" ]; then
    source $USER_LOCAL/etc/bash_completion
fi
if [ -f $USER_LOCAL/Library/Contributions/brew_bash_completion.sh ]; then
    source $USER_LOCAL/Library/Contributions/brew_bash_completion.sh
fi

## プロンプトの設定
#  \u  : ユーザ名
#  \h  : マシン名
#  \W  : カレントディレクトリ  \w : カレントディレクトリもフルパス
#  \\$ : スーパーユーザは「#」一般ユーザは「$」で表示
#  \t  :  the current time in 24-hour HH:MM:SS format
#  \T  :  the current time in 12-hour HH:MM:SS format
#  \@  :  the current time in 12-hour am/pm format
#  \A  :  the current time in 24-hour HH:MM format
#  __git_ps1 : gitブランチ
#    http://d.hatena.ne.jp/ruedap/20110706/mac_terminal_git_branch_name

PS1='\e[0;32m[\u\e[0;33m@\e[0;32m\h:\e[0;36m\w'
# Load git-prompt.sh
if [ -f ~/dotfiles/etc/git/git-prompt.sh ]; then
    source ~/dotfiles/etc/git/git-prompt.sh \
        && PS1="$PS1"'$(__git_ps1 "\e[1;31m(%s)")'
fi
if [ $? -ne 0 ] && type __git_ps1 >/dev/null 2>&1; then
    PS1="$PS1"'\e[1;35m$(__git_ps1)'
fi

PS1="$PS1"'\e[0;m]\$ '

# For tmux-powerline
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
export PS1


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
