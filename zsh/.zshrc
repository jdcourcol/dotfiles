# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="frisk"

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
plugins=(mvn git-prompt)

source $ZSH/oh-my-zsh.sh

#source /home/courcol/git-prompt/zshrc.sh
#PROMPT='%{$fg[cyan]%}%B%m %{$reset_color%}%~%b%{$fg_bold[blue]%} $(git_super_status)%{$fg_bold[blue]%} % %{$reset_color%} %# '
#PROMPT='%{$fg[cyan]%}%B%d %{$reset_color%}'
# Customize to your needs...
export PATH=/home/courcol/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

va () {
   source `find . -name activate`
}

viz(){
 klist || kinit
 ssh -Yt bbplinsrv2.epfl.ch $'salloc -n1 -p interactive /bin/bash -c \' ssh -Y `srun -p interactive hostname`\' '
}

alias ta='tmux -2 attach -t'
alias tn='tmux -2 new-session -s'
alias ec='/usr/bin/emacsclient -ct'
alias es='/usr/bin/emacs --daemon'
