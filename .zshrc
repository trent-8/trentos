[[ $- != *i* ]] && return
HISTFILE=$HOME/.zhistfile
HISTSIE=5000
SAVEHIST=1000
setopt autocd extendedglob
unsetopt beep
bindkey -v
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PROMPT='%n@%m %F{166}%~%f%F{15}$%f '
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh