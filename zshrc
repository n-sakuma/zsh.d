# -*- mode:shell-script -*-

##
# PATH

source $HOME/.zsh.d/paths


# function gemdir {
#   if [[ -z "$1" ]] ; then
#     echo "gemdir expects a parameter, which should be a valid RVM Ruby selector"
#   else
#     rvm "$1"
#     cd $(rvm gemdir)
#     pwd
#   fi
# }

function cd_gem_dir {
  if [[ -z "$1" ]] ; then
    echo "gemdir expects a parameter, which should be a valid RVM Ruby selector"
  else
    cd $(rvm gemdir $1)
    pwd
  fi
}

# function rvm_use {
#     if [ -z "$1" ]; then
#         echo "Ruby interpreter expects a parameter, which should be a valid RVM Ruby selector"
#         echo "ex) % ru jruby"
#     elif rvm use $1 ;then
#         RUBY_VER=$(~/.rvm/bin/rvm-prompt)
#     else
#         echo "or 'rvm list' "
#     fi
# }


# EDITOR
if [[ -x $( which vim ) ]]; then
    export EDITOR=vim
else
    export EDITOR=vi
fi


###
# Alias
source $HOME/.zsh.d/aliases

# grep config
export GREP_COLOR='1;37' # 白
export GREP_OPTIONS='--color=auto'
# パイプでも表示するが Git表示でおかしくなる
# export GREP_OPTIONS='--color=always'

# alias grep='grep --colour'
# 環境変数 GREP_COLORに ANSIエスケープシーケンスで定義される色指定を
# 置くことにより、任意の色でカラー出力できます。

# 色指定の例:
#     Black       0;30     Dark Gray     1;30
#     Blue        0;34     Light Blue    1;34
#     Green       0;32     Light Green   1;32
#     Cyan        0;36     Light Cyan    1;36
#     Red         0;31     Light Red     1;31
#     Purple      0;35     Light Purple  1;35
#     Brown       0;33     Yellow        1;33
#     Light Gray  0;37     White         1;37

# セミコロンの前の0は通常輝度を指示し、1は高輝度を指示します。
# 3xの代わりに4xと指定すると反転表示の指示です。たとえば
#   set GREP_COLOR=1;41;37
# のようにすると、マッチした部分を赤い背景に白い文字で表示します。


##
# コード補完

# 拡張用の補完パス
fpath=($HOME/.zsh.d/completions $fpath)

autoload -U compinit
compinit -u

# フォーマット
zstyle ':completion:*' list-colors 'di=36' 'ln=35'
zstyle ':completion:*:default' menu select=1

export LSCOLORS=gxfxcbdxbxegedabagacad
    # position: 1   5    0    5    0

    # * 01: ディレクトリ前景色
    # * 02: ディレクトリ背景色
    # * 03: シンボリックリンク前景色
    # * 04: シンボリックリンク背景色
    # * 05: ソケットファイル前景色
    # * 06: ソケットファイル背景色
    # * 07: FIFOファイル前景色
    # * 08: FIFOファイル背景色
    # * 09: 実行ファイル前景色
    # * 10: 実行ファイル背景色
    # * 11: ブロックスペシャルファイル前景色
    # * 12: ブロックスペシャルファイル背景色
    # * 13: キャラクタスペシャルファイル前景色
    # * 14: キャラクタスペシャルファイル背景色
    # * 15: setuidつき実行ファイル前景色
    # * 16: setuidつき実行ファイル背景色
    # * 17: setgidつき実行ファイル前景色
    # * 18: setgidつき実行ファイル背景色
    # * 19: スティッキビットありother書き込み権限つきディレクトリ前景色
    # * 20: スティッキビットありother書き込み権限つきディレクトリ背景色
    # * 21: スティッキビットなしother書き込み権限つきディレクトリ前景色
    # * 22: スティッキビットなしother書き込み権限つきディレクトリ背景色

    # * a: 黒
    # * b: 赤
    # * c: 緑
    # * d: 茶
    # * e: 青
    # * f: マゼンタ
    # * g: シアン
    # * h: 白
    # * A: 黒(太字)
    # * B: 赤(太字)
    # * C: 緑(太字)
    # * D: 茶(太字)
    # * E: 青(太字)
    # * F: マゼンタ(太字)
    # * G: シアン(太字)
    # * H: 白(太字)
    # * x: デフォルト色


# 文字列
export LANG=ja_JP.UTF-8
# export LANG=ja_JP.eucJP

## auto change directory
setopt auto_cd

## cd -[tab] で過去の移動したディレクトリを番号付きで表示する
setopt auto_pushd

## auto_pushdで重複するディレクトリは記録しないようにする
setopt pushd_ignore_dups

# コマンドのスペルミスを指摘して予想される正しいコマンドを提示
# このときのプロンプトはSPROMPT
setopt correct

# 補完候補を詰めて表示する設定
setopt list_packed

# aliasを補完候補に含める
setopt complete_aliases

# 補完リストが多いときに尋ねる数
# -1 : 尋ねない
#  0 : ウィンドウから溢れるときは尋ねる
LISTMAX=0
export LISTMAX


# Don't beep
setopt nolistbeep

# 補完候補一覧でファイルの種別を識別マーク表示(ls -F の記号)
setopt list_types

# 補完候補リストの日本語を正しく表示
setopt print_eight_bit

# シングルクォート内にシングルクォートを使えるようにする
setopt rc_quotes

# 補完で末尾に補われた / が自動的に 削除される
setopt auto_remove_slash

# lsコマンドの補完候補にも色付き表示
# eval `dircolors`
# zstyle ':completion:*:default' list-colors ${LS_COLORS}

# kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

# 大文字・小文字を区別しないで補完出来るようにするが、大文字を入力した場合は区別する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 単語境界にならない記号
# デフォルト => '*?_-.[]~=/&;!#$%^(){}<>'
export WORDCHARS='*?[]~=&;!#$%^(){}<>'

# # 通常
# PROMPT="%/ %% "
# # 複数行
# PROMPT2="%_%% "
# # 入力ミスを確認する場合に表示されるプロンプト
# SPROMPT="%r is correct? [n,y,a,e]: "

# set prompt
#
autoload colors
colors

# color

# red
# blue
# green
# cyan
# yellow
# white
# black

# PROMPT, SPROMPT
case ${UID} in
0) #root
  PROMPT="[%{${fg[red]}%}%n@%m%{${reset_color}%}] %{${fg[blue]}%}#%{${reset_color}%} "
  PROMPT2="%B%{${fg[blue]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[blue]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  ;;
*)

  # PROMPT="[%n@%m] %{${fg[blue]}%}#%{${reset_color}%} "
  PROMPT2="%B%{${fg[blue]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[white]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  #RPROMPT="%{${fg[blue]}%}[%/]%{${reset_color}%}"
  ;;
esac


# RPROMPT

# Gitのブランチ名をRPROMPTに表示する --- vcs_info(zshの組み込み関数)を使う

# vcs_infoを読み込む
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git cvs svn hg
zstyle ':vcs_info:*:prompt:*' formats "/%S:%b:%u:%c"
zstyle ':vcs_info:*' actionformats '/%S:%b|%a'
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
# zstyle ':vcs_info:*:prompt:*' unstagedstr 'u' #'¹'  # display ¹ if there are unstaged changes
# zstyle ':vcs_info:*:prompt:*' stagedstr  'c' #'²'    # display ² if there are staged changes
# zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}//" "${FMT_PATH}"
# zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}//"              "${FMT_PATH}"
# zstyle ':vcs_info:*:prompt:*' nvcsformats   ""                             "%~"



_git_info(){
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# ブランチの表示色の変更
_check_git_status() {
    GIT_STATUS=$( git status 2>/dev/null )
    if [[ -n $( echo $GIT_STATUS | grep "^nothing to commit (working directory clean)$" ) ]] ;then
        # on "zsh 4.3.10"
        # GIT_LINE=$( echo $GIT_STATUS | wc -l)
        if [[ -n $( uname -a | grep -i "linux" ) ]] ;then
            GIT_LINE=$( echo $GIT_STATUS | wc -l )
        else
            GIT_LINE=$( echo $GIT_STATUS | wc -l | cut -c 8 )
        fi

        if [[ $GIT_LINE == "2" ]]; then
             # ワーキングディレクトリがcleanな状態
            BRANCH_CLOR=green
        else
             # cleanだが、pushしてない or remoteとの差分コミットあり
            BRANCH_CLOR=yellow
        fi
    else
        BRANCH_CLOR=red
    fi
}

_current_ruby_ver() {
    if [[ -s $HOME/.rvm/scripts/rvm ]]; then
        RUBY_VER=$(~/.rvm/bin/rvm-prompt)
    else
        RUBY_VER=""
    fi
}

_org_pwd() {
    GIT_DIR=$(pwd | xargs dirname)
}

_update_prompt () {
    # server用
    PROMPT="%{${fg[cyan]}%}%n@%{${fg[white]}%}%m%{${fg[cyan]}%} $ %{${reset_color}%}"
    # client用
    # PROMPT="%{${fg[green]}%}$RUBY_VER$%{${reset_color}%} "
    if [ ${vcs_info_msg_0_} ]; then
        if [[ -z $( git status 2>/dev/null | grep "fatal" ) ]]; then
            _check_git_status
        fi
        RPROMPT="%{${fg[white]}%}[%~%1(v|%F{$BRANCH_CLOR}%1v%f|)%{${fg[white]}%}]%{${reset_color}%}"
    else
        RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
    fi
}

# プロンプトを再評価
# setopt prompt_subst

# カーソル位置は保持したままファ イル名一覧を順次その場で表示
# setopt always_last_prompt


precmd() {
    vcs_info 'prompt'
    _current_ruby_ver
    _git_info
    _update_prompt
}

chpwd() {
    vcs_info 'prompt'
    _current_ruby_ver
    _git_info
    _update_prompt
}



## Command history configuration
#
HISTFILE=~/.zsh.d/history
HISTSIZE=10000
SAVEHIST=10000

# 履歴を複数端末間で共有する
setopt share_history

# 重複するコマンドが記憶されるとき、古い方を削除する
setopt hist_ignore_all_dups

# 直前のコマンドと同じ場合履歴に追加しない
setopt hist_ignore_dups

# 重複するコマンドが保存されるとき、古い方を削除する
setopt hist_save_no_dups

## Emacs Like keybind
#
bindkey -e

## Vi like
#
# bindkey -v


compinit -d $HOME/.zsh.d/.zcompdump

## historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# Google による検索
function ggl() {
    local str opt
    if [ $# != 0 ]; then
            for i in $*; do
                str="$str+$i"
            done
            str=`echo $str | sed 's/^¥+//'`
            opt='search?num=50&hl=ja&lr=lang_ja'
            opt="${opt}&q=${str}"
    fi
    open http://www.google.com/$opt
}

# "Control-^" で parent directory へ移動
function cdup() {
    echo
    cd ..
    zle reset-prompt
}
zle -N cdup
bindkey '^\^' cdup

unsetopt extended_glob
