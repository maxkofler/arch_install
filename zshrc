export PATH=$PATH:$HOME/.local/bin

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec startx
fi
if [ -f $HOME/.local/lib/python3.8/site-packages/powerline/bindings/bash/powerline.sh ]; then
    $HOME/.local/bin/powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
    source $HOME/.local/lib/python3.8/site-packages/powerline/bindings/bash/powerline.sh
fi

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

setopt autocd
setopt interactivecomments
setopt extended_glob

bindkey ";5C" forward-word
bindkey ";5D" backward-word
bindkey '\e[H' beginning-of-line
bindkey ";5H" beginning-of-line
bindkey '\e[F' end-of-line
bindkey ";5F" end-of-line
bindkey "\e[3~" delete-char

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

echo 1/4: Loading zstyle, compinit...

zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit && compinit
#if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
#  compinit
#else
#  compinit -C
#fi

echo 2/4: Initializing dependencies with zplug...

if [[ ! -d ~/.zplug ]];then
    git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

zplug "mafredri/zsh-async", from:github
zplug "lib/completion", from:oh-my-zsh
zplug "themes/agnoster", use:agnoster.zsh, from:oh-my-zsh, as:theme
zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:3
zplug "MichaelAquilina/zsh-you-should-use"
zplug "zsh-users/zsh-autosuggestions", from:github
#zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

echo 3/4: Loading zplug dependencies...

zplug load

if ! zplug check --verbose; then
    printf "Install zplug plugins? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

echo 4/4: Setting aliases...

#
# Aliases
#

#
# Files

alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias ..6='cd ../../../../../..'

alias chgrp='chgrp --preserve-root'
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'

alias rm='rm -f'
alias mv='mv -f'
alias cp='cp -f'
alias df='df -h'
alias size='du -hs'

alias trash='sudo fstrim -v /'

alias md='mkdir -p'
alias mkdirs='mkdir -pv'
alias rd='rmdir'

alias tree='find . -print | sed -e '\''s;[^/]*/;|____;g;s;____|; |;g'\'''

alias coronastat='curl "https://corona-stats.online?top=20"'
alias mouse='sudo modprobe -r psmouse'
# List

alias ls='ls --color=auto -h --group-directories-first'
alias la='ls --color=auto -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" -F'
alias ll='ls --color=auto -lh --group-directories-first --time-style=+"%d.%m.%Y %H:%M" -F'

#
# Package management
#

alias dblock='sudo rm -f /var/lib/pacman/db.lck'
alias update='sudo pacman -Syyu'
alias syncp='sudo pacman -Sy'

#
#KEY MANAGEMENT
#
alias key_server="eval\"$(ssh-agent)\" && ssh-add ~/ssh-keys/server/server"
alias key_github="eval\"$(ssh-agent)\" && ssh-add ~/ssh-keys/github/gitkey"

#
# git commands
#

alias gaa="git add ."
alias gaap="git add -p ."
alias ga="git add"
alias gap="git add -p"
alias gc="git commit"
alias gch="git checkout"
alias gbr="git branch"
alias gcm="git commit -m"
alias gps="git push"
alias gpu="git pull"
alias gs="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias gst="git stash"
alias gstp="git stash pop"

alias please="sudo !!"

#
# Systemd (systemctl)
alias sdst='sudo systemctl start'
alias sds='sudo systemctl status'
alias sdsp='sudo systemctl stop'
alias sdr='sudo systemctl restart'

#
# Grep
#

alias grep='grep --color=auto'
alias g='grep --color=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

#
# Interpreters

alias py='python'
alias jv='java'

#
# Misc
#

alias genpw='pwgen -c -n -y 48 1'
alias genpws='pwgen -c -n 48 1'
alias mp3dl='youtube-dl -x --audio-format mp3 --metadata-from-title "%(artist)s - %(title)s" -o "%(title)s.%(ext)s"'
alias _='sudo'
alias free='free -m'
alias h='history'
alias genpws='pwgen -c -n 36 1'
alias q='exit'
alias reload='source ~/.zshrc'
alias nv='nvim'
alias :q="quit"
if [ $UID -ne 0 ]; then
         alias reboot='sudo reboot'
fi

#
## Fixes
alias sudo='sudo '

#
# # ex - archive extractor
# # usage: ex <file>
ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.jar)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
   fi
}

transfer () {
    # write to output to tmpfile because of progress bar
    tmpfile=$( mktemp -t transferXXX )
    curl --progress-bar --upload-file $1 https://transfer.sh/$(basename $1) >> $tmpfile;
    cat $tmpfile;
    rm -f $tmpfile;
}

#alias transfer=transfer

export TERM=xterm-256color
export EDITOR=/usr/bin/nvim # TODO
export BROWSER=/usr/bin/qutebrowser # TODO
export PAGER=/usr/bin/vimpager # TODO
export LANG=en_US.utf8
export SCRIPT_DIR=$HOME/scripts
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=setting'

clear
