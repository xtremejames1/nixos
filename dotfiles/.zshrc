# If you come from bash you might have to change your $PATH.
path+=('/home/xtremejames1/bin')
path+=('/home/xtremejames1/.local/bin')
path+=('/usr/local/bin')
export PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(git zsh-autosuggestions ubuntu zsh-syntax-highlighting zsh-vim-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
export OPEN_WEATHER_API_KEY="150c62809890af23fa63a826b87b4ced"

alias vim=nvim
alias grep=rg
alias ls=exa
alias cat=bat

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(atuin init zsh)"
eval $(thefuck --alias)

source /home/xtremejames1/.config/broot/launcher/bash/br

bindkey -v

# zsh-vim-mode settings
MODE_CURSOR_VIINS="#dce0b1 blinking bar"
MODE_CURSOR_REPLACE="blinking underline #8a3129"
MODE_CURSOR_VICMD="#5c7a38 blinking block"
MODE_CURSOR_SEARCH="#ff00ff steady underline"
MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
