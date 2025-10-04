# Env vars
export PATH=~/.local/bin:$PATH
export LESS="dMqifR"

# Local vars
zsh_syntax_highlight=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ll="ls -lh"
alias lla="ls -alh"
alias rl="source ~/.zshrc"
alias vi=vim

# Keybinds
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Source work related stuff
[ -f .workrc ] && source .workrc

# Starship
type starship &> /dev/null && eval "$(starship init zsh)"

# Neovim
type nvim &> /dev/null && alias vim=nvim

# FZF
if type fzf &> /dev/null; then
    source <(fzf --zsh)
    export FZF_CTRL_T_OPTS="
    --walker file,hidden
    --walker-skip .git,node_modules,target
    --preview 'cat -n {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"
fi

# Bat
if type bat &> /dev/null; then
    alias cat=bat
    export BAT_THEME=Nord
    export FZF_CTRL_T_OPTS="
    --walker file,hidden
    --walker-skip .git,node_modules,target
    --preview 'bat -n --color always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"
fi

# Eza
if type eza &> /dev/null; then
    alias ls="eza"
    alias ll="eza -lh"
    alias lla="eza -alh"
    alias tree="eza --tree -I .git -a"
fi

# Syntax highlighting
[ -f $zsh_syntax_highlight ] && source $zsh_syntax_highlight
