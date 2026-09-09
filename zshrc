# Histfile support for command reverse search (ctrl+r)
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt INC_APPEND_HISTORY_TIME
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Load zsh plugins (installed by install.sh)
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit -v'
alias gco='git checkout'
alias gp='git push'
alias gb='git branch'
alias gd='git diff'
alias gl='git pull'
alias gr='git remote'
alias grv='git remote -v'
alias gst='git status'
alias gsta='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'
alias gpsup='git push --set-upstream origin $(git branch --show-current)'

# Add DIRs to the path
export PATH="$PATH:/snap/bin"
export PATH="$HOME/.local/bin:$PATH"

# Load NVM if installed
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# Use fzf for command reverse search (ctrl+r), file search (ctrl+t) and cd (alt+c)
if (( $+commands[fzf] )); then
  # Sets up file search, history and cd search
  eval "$(fzf --zsh)"

  fzf-history-widget() {
    local selected
    # Run fzf into the variable without combining with 'local' declaration
    selected=$(fc -rl 1 | fzf --height=40% --layout=reverse --scheme=history +m --query="$LBUFFER")
    local ret=$?

    # Only modify LBUFFER if an actual selection was made
    if [[ $ret -eq 0 && -n "$selected" ]]; then
      LBUFFER="${selected#*[0-9]  }"
    fi

    # Always redraw the prompt cleanly on both selection and escape/abort
    zle reset-prompt
    return $ret
  }
  zle -N fzf-history-widget
  bindkey '^R' fzf-history-widget
fi

# Initialize Starship prompt
eval "$(starship init zsh)"

# Initialize Zoxide
eval "$(zoxide init zsh)"
eval "$(zoxide init zsh --cmd cd)"

export SOPS_AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt"
