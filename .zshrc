# If you come from bash you might have to change your $PATH.
export PATH=~/.local/bin/:$PATH

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

export BAT_THEME=Nord

export LESS="dMqifR"
#export LESS="FR"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias cat=bat
alias vim=nvim
alias vi=vim

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

eval "$(starship init zsh)"
eval "$(fzf --zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
