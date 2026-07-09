# Zinit installation directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit if it doesn't exist
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load plugins
zinit snippet OMZP::git                                         # OMZ git plugin (aliases)
zinit light zsh-users/zsh-autosuggestions                       # Autosuggestions
zinit light zsh-users/zsh-syntax-highlighting                   # Syntax highlighting

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

# Bat aliases
alias bat='batcat'
alias cat='batcat'
export BAT_THEME="ansi"
