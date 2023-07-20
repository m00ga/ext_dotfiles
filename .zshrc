export GOPATH=/home/mooger/Apps/go

path+=($GOPATH/bin)
path+=(/home/mooger/.local/bin)

alias tmc="$HOME/.tmux-control.sh"

bindkey -v
bindkey '^/' history-incremental-search-backward

#source $HOME/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
#zstyle ':autocomplete:*' ignored-input '..##'
#zstyle ':autocomplete:*' min-delay 0.05  # seconds (float)

fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
autoload compinit && compinit
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
