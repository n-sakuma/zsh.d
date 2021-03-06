# vim: ft=zsh
# -*- mode: shell-script -*-
#
# Google による検索
function ggl() {
    if [[ $(uname) = "Darwin" ]]; then
        local str opt
        if [ $# != 0 ]; then
            for i in $*; do
                str="$str+$i"
            done
            str=`echo $str | sed 's/^¥+//'`
            opt='search?num=50&hl=ja&lr=lang_ja'
            opt="${opt}&q=${str}"
        fi
        open http://www.google.co.jp/$opt
    else
        echo "not supported"
    fi
}

# "Control-^" で parent directory へ移動
function cdup() {
    echo
    cd ..
    zle reset-prompt
}
zle -N cdup
bindkey '^\^' cdup


function ls_abbrev() {
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-aCF' '--color=always')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type gls > /dev/null 2>&1; then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-aCFG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo
        echo "$ls_result" | head -n 5
        echo "\n...\n"
        echo "$ls_result" | tail -n 5
        echo -n "\n... "
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "\n"
        echo "$ls_result"
        echo
    fi
    zle reset-prompt
    return 0
}
zle -N ls_abbrev
# bindkey '^l' ls_abbrev


function get_git_status() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    # echo
    # ls or ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        echo
        git status #-sb
        echo
    fi
    zle reset-prompt
    return 0
}
zle -N get_git_status
# Ctrl+Space
bindkey '^@' get_git_status

HARDCOPYFILE=/tmp/tmux-hardcopy
touch $HARDCOPYFILE

dabbrev-complete () {
  local reply lines=80
  tmux capture-pane && tmux save-buffer -b 0 $HARDCOPYFILE && tmux delete-buffer -b 0
  reply=($(sed '/^$/d' $HARDCOPYFILE | sed '$ d' | tail -$lines))

  compadd -Q - "${reply[@]%[*/=@|]}"
}

zle -C dabbrev-complete menu-complete dabbrev-complete
bindkey '^o' dabbrev-complete
bindkey '^o^_' reverse-menu-complete

function check_ghq () {
  if which ghq > /dev/null; then
    return 0
  else
    echo "Not found 'ghq'\n"
    echo "\ninstalling...\n"
    go get github.com/motemen/ghq
  fi
}

function peco-src() {
  check_ghq
  # local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER") # 絶対パス
  local selected_dir=$(ghq list | sed -e "s/^/~\/work\/src\//" | peco --query "$LBUFFER") #相対パス
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# NOTE: replace zaw-ssh-hosts
function s() {
  ssh $(awk '
    tolower($1)=="host" {
      for (i=2; i<=NF; i++) {
        if ($i !~ "[*?]") {
          print $i
        }
      }
    }
  ' ~/.ssh/config | sort | peco)
}

# function git_checkout_peco () {
#   git checkout $(git branch | sort | peco)
# }
# bindkey '^g' git_checkout_peco

function peco-git-branch-checkout () {
    local selected_branch_name="$(git branch -a | peco | tr -d ' ')"
    case "$selected_branch_name" in
        *-\>* )
            selected_branch_name="$(echo ${selected_branch_name} | perl -ne 's/^.*->(.*?)\/(.*)$/\2/;print')";;
        remotes* )
            selected_branch_name="$(echo ${selected_branch_name} | perl -ne 's/^.*?remotes\/(.*?)\/(.*)$/\2/;print')";;
    esac
    if [ -n "$selected_branch_name" ]; then
        BUFFER="git checkout ${selected_branch_name}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-git-branch-checkout

# NOTE: replace zaw-git-branches
# bindkey '^g' peco-git-branch-checkout

## img tools
if ! which imgcat > /dev/null; then
  go get -u github.com/olivere/iterm2-imagetools/cmd/imgcat
fi
if ! which imgls > /dev/null; then
  go get -u github.com/olivere/iterm2-imagetools/cmd/imgls
fi
