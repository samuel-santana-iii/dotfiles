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

# Initialize Starship prompt
eval "$(starship init zsh)"

# Initialize Zoxide
eval "$(zoxide init zsh)"
eval "$(zoxide init zsh --cmd cd)"

export SOPS_AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt"
