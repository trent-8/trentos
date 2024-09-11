# zsh powerlevel10k
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
# zsh syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# zsh auto suggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# zsh history substring
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias notes="python ~/trentos/notes.py"