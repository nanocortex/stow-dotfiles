#config/shell/ Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

POWERLEVEL9K_CONFIG_FILE=$HOME/.config/shell/p10k.zsh

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Create a cache folder if it isn't exists
if [ ! -d "$HOME/.cache/zsh" ]; then
    mkdir -p $HOME/.cache/zsh
fi

# Define a custom file for compdump
export ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump-$HOST-$ZSH_VERSION"

### ============================= CONFIGURATION ============================= ###
zle -N edit-command-line
bindkey '^[[111;14u' edit-command-line

autoload -Uz compinit
compinit

# Ignoring commands started with space in history
HISTSIZE=1000000000
SAVEHIST=$HISTSIZE
HISTFILE="$HOME/.local/share/history"
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
# Immediately append to history file:
setopt INC_APPEND_HISTORY

# Record timestamp in history:
setopt EXTENDED_HISTORY

# Expire duplicate entries first when trimming history:
setopt HIST_EXPIRE_DUPS_FIRST

# Dont record an entry that was just recorded again:
setopt HIST_IGNORE_DUPS

# Delete old recorded entry if new entry is a duplicate:
setopt HIST_IGNORE_ALL_DUPS

# Do not display a line previously found:
setopt HIST_FIND_NO_DUPS

# Dont write duplicate entries in the history file:
setopt HIST_SAVE_NO_DUPS


# nnn config
nfunc ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    nnn "$@"
    # -P p

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}
export NNN_PLUG='f:fzcd;o:fzopen;p:preview-tui;z:autojump;c:cbcopy-mac;P:cbpaste-mac;1:ipinfo;b:nbak;C:!cp -rv "$nnn" "$nnn".cp;e:-!sudo -E vim "$nnn"*'
export NNN_FIFO='/tmp/nnn.fifo'


### ============================= EXPORTS ============================= ###

export LANG=en_US.UTF-8
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less -R'
export TERM="xterm-256color"
export COLORTERM=xterm-256color
export LANG=en_US.UTF-8
export DOCKER_DATA_DIR="/var/lib/docker-data/"

source ~/.aliases.zsh

### ============================= OTHER ============================= ###
#
# [ -f ~/.config/fzf/fzf.zsh ] && source ~/.config/fzf/fzf.zsh
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh
source ~/.local/share/shell/fzf-tab/fzf-tab.plugin.zsh


bindkey -e
bindkey '^ ' autosuggest-accept

source $HOME/.local/share/shell/p10k/powerlevel10k.zsh-theme
eval "$(zoxide init zsh)"

source $HOME/.local/share/shell/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.local/share/shell/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/shell/p10k.zsh ]] || source ~/.config/shell/p10k.zsh

for al in `git --list-cmds=alias`; do
    alias g$al="git $al"
done



source .secrets
