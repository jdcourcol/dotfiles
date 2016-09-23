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
plugins=(git-prompt copybuffer)

source $ZSH/oh-my-zsh.sh

#source /home/courcol/git-prompt/zshrc.sh
#PROMPT='%{$fg[cyan]%}%B%m %{$reset_color%}%~%b%{$fg_bold[blue]%} $(git_super_status)%{$fg_bold[blue]%} % %{$reset_color%} %# '
#PROMPT='%{$fg[cyan]%}%B%d %{$reset_color%}'
# Customize to your needs...

unamestr=`uname`

if [[ "$unamestr" != "Darwin" ]]; then
export PATH=/home/courcol/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:
else
export PATH=/Users/courcol/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/opt/coreutils/libexec/gnubin
fi

va () {
   source `find . -name activate`
}

# iterm2 shell integration
source ~/.iterm2_shell_integration.`basename $SHELL`


viz(){
 klist || kinit
 ssh -Yt bbplxviz1.epfl.ch $'salloc -n1 -p interactive /bin/bash -c \' ssh -Y `srun -p interactive hostname`\' '
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


