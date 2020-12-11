
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/lunyanghuang/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
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

export PS1='\u:\d \W:'

# enable color for one dark theme
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# eval "$(starship init bash)"


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
