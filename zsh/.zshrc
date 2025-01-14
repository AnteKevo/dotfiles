# If you come from bash you might have to change your $PATH.
export PATH=~/.local/bin/:$PATH

export BAT_THEME=Nord

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
source ~/tools/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
