#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
alias vi=/usr/local/bin/vim
alias vim=/usr/local/bin/vim
# Source zsh autocomplete
# source '/Users/lunyanghuang/Dropbox (Personal)/Projects/Terminal/custom_package/zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh'


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/lunyanghuang/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/lunyanghuang/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/lunyanghuang/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/lunyanghuang/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# <<< conda initialize <<<

# export PS1='%n-%1~:'

# eval "$(starship init zsh)"


# why would you type 'cd dir' if you could just type 'dir'?
setopt AUTO_CD

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
