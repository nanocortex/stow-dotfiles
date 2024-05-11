# NeoVim
alias vim='nvim'
alias rg='rg -i'

# Configs
alias zrc='vim ~/.zshrc; source ~/.zshrc'
alias 10rc='vim ~/.p10k.zsh; source ~/.zshrc'
alias als="vim ~/.aliases.zsh; source ~/.zshrc"
alias vrc='vim ~/.config/lvim/config.lua'
alias sshc="vim $HOME/.ssh/config"


alias lg='lazygit'
alias v='vim'
alias brclr="git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D"
alias mv='mv -vi'
alias cp='cp -vir'
alias mkdir='mkdir -pv'
alias n='nfunc -e'

_fdvim() { 
  fd "$@" -1 | xargs -I {} "/Users/dave/.local/bin/nvim" {}
}
alias f='_fdvim';
alias ls='ls -lah --color=auto'
alias l='ls'
alias 1="ping 1.1.1.1"

# TMUX
alias tma='tmux attach || tmux new-session'
alias tmn='tmux new-session'
alias tmd='tmux detach'
alias tml='tmux attach-session -t $(tmux list-sessions -F "#S" | fzf --height 50% --reverse)'

alias df="duf -only-mp '/'"
alias diff="diff --color=always -b"


