# zsh powerlevel10k
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
# zsh syntax highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# zsh auto suggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# zsh history substring
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias notes="python ~/trentos/notes.py"