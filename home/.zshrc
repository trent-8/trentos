# Set the directory we want to store zinit and plugins
export EDITOR='nano'
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"
# Add in zsh plugins
zinit ice depth=1
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit
autoload -Uz vcs_info
precmd() { vcs_info }

zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt autocd
setopt prompt_subst

# Completion styling
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle :compinstall filename '/home/trent/.zshrc'
zstyle ':vcs_info:git:*' formats '(%b) '
# Add Git branch info to your prompt
PROMPT='%F{yellow}${vcs_info_msg_0_}%F{white}%n@%m%F{#888888}: %F{green}%~ %F{yellow}%(#.#.$) '
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias c='clear'
alias startwl="hyprland"


# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
# setup key accordingly
bindkey -e
bindkey '^[[H' beginning-of-line # home
bindkey '^[[F' end-of-line # end
bindkey "^[[2~" overwrite-mode # insert
bindkey '^?' backward-delete-char # backspace
bindkey '^H' backward-delete-word # ctrl+backspace
bindkey '^[[3~' delete-char # delete
bindkey '^[[3;5~' delete-word # ctrl+delete
bindkey '^[[1;5A' history-search-backward # up
bindkey '^[[1;5B' history-search-forward # down
bindkey '^[[D' backward-char
bindkey '^[[C' forward-char
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[5~' beginning-of-buffer-or-history
bindkey '^[[6~' end-of-buffer-or-history
bindkey '^[[Z' reverse-menu-complete # shift+tab
bindkey '^[w' kill-region
