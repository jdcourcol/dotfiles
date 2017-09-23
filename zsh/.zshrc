# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="jdc"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
#DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git-prompt copybuffer fasd vi-mode)

source $ZSH/oh-my-zsh.sh

#source /home/courcol/git-prompt/zshrc.sh
#PROMPT='%{$fg[cyan]%}%B%m %{$reset_color%}%~%b%{$fg_bold[blue]%} $(git_super_status)%{$fg_bold[blue]%} % %{$reset_color%} %# '
#PROMPT='%{$fg[cyan]%}%B%d %{$reset_color%}'
# Customize to your needs...

unamestr=`uname`


lock(){
    if [[ "$unamestr" != "Darwin" ]]; then
        xscreensaver-command -lock
    else
        pmset displaysleepnow
    fi
}

if [[ "$unamestr" != "Darwin" ]]; then
	zle -N lock
	bindkey "^[l" lock
  setxkbmap -option caps:escape
fi

va () {
   source `find . -name activate`
}

# iterm2 shell integration
# source ~/.iterm2_shell_integration.`basename $SHELL`


viz(){
 klist || kinit
 ssh -Yt bbplxviz1.epfl.ch $'salloc -n1 -p interactive /bin/bash -c \' ssh -Y `srun -p interactive hostname`\' '
}

# W: whole file (no delta)
# a archive
# P: show progress keep partially transfered files
# v: verbose
# human-readable : output number in human readable format

cp_p () {
  rsync -WavP --human-readable --progress $1 $2
}

gifify() {
  if [[ -n "$1" ]]; then
if [[ $2 == '--good' ]]; then
  ffmpeg -i "$1" -r 10 -vcodec png out-static-%05d.png
  time convert -verbose +dither -layers Optimize -resize 900x900\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > "$1.gif"
  rm out-static*.png
else
  ffmpeg -i "$1" -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > "$1.gif"
fi
  else
echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}



alias ta='tmux -2 attach -t'
alias tn='tmux -2 new-session -s'
alias tk='tmux kill-session -t'
alias em='set +m; env TERM=xterm-256color emacs -nw'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gap='git add -p'
alias gco='git checkout'
alias gr='git review'
alias gucf='git reset HEAD^'
alias gpom='git push origin master'
alias gcas='git commit --amend --no-edit'
alias readlink=greadlink
alias pipi='pip install -i http://localhost:3141/root/pypi'
alias v='set +m; env TERM=xterm-256colors f -e "emacs -nw" '

export HISTCONTROL=ignoredups
setopt HIST_IGNORE_DUPS
# Increase the maximum number of lines contained in the history file
# (default is 500)
export HISTFILESIZE=100000

# Increase the maximum number of commands to remember
# (default is 500)
export HISTSIZE=100000
function exists { which $1 &> /dev/null }

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi
function ppgrep() {
    if [[ $1 == "" ]]; then
        PERCOL=percol
    else
        PERCOL="percol --query $1"
    fi
    ps aux | eval $PERCOL | awk '{ print $2 }'
}

function ppkill() {
    if [[ $1 =~ "^-" ]]; then
        QUERY=""            # options only
    else
        QUERY=$1            # with a query
        [[ $# > 0 ]] && shift
    fi
    ppgrep $QUERY | xargs kill $*
}
