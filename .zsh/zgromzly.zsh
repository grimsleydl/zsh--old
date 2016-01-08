export PATH="$HOME/.local/bin/:$PATH"
source /usr/share/chruby/chruby.sh
source /usr/share/chruby/auto.sh
# Load and execute the prompt theming system.
autoload -Uz promptinit && promptinit

#
# Smart URLs
#

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

#
# General
#

setopt BRACE_CCL          # Allow brace character class list expansion.
setopt COMBINING_CHARS    # Combine zero-length punctuation characters (accents)
# with the base character.
setopt RC_QUOTES          # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.

#
# Jobs
#

setopt LONG_LIST_JOBS     # List jobs in the long format by default.
setopt AUTO_RESUME        # Attempt to resume existing job before creating a new process.
setopt NOTIFY             # Report status of background jobs immediately.
unsetopt BG_NICE          # Don't run all background jobs at a lower priority.
unsetopt HUP              # Don't kill jobs on shell exit.
unsetopt CHECK_JOBS       # Don't report on jobs when shell exit.

setopt no_hist_verify


export GREP_COLOR='1;33'
unset GREP_OPTIONS

# . /etc/profile.d/vte.sh

function bcs() {
    aura -Ss $@; aura -As $@;
}

# ------------------------------------------------------------------------------
# Description
# -----------
#
# sudo will be inserted before the command
#
# ------------------------------------------------------------------------------
# Authors
# -------
#
# * Dongweiming <ciici123@gmail.com>
#
# ------------------------------------------------------------------------------

sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line

# Defined shortcut keys: [Esc] [Esc]
bindkey "\e\e" sudo-command-line

if [[ $- =~ i ]]; then

    # ALT-I - Paste the selected entry from locate output into the command line
    fzf-locate-widget() {
        local selected
        if selected=$(locate / | fzf -q "$LBUFFER"); then
            LBUFFER=$selected
        fi
        zle redisplay
    }
    zle     -N    fzf-locate-widget
    bindkey '\ei' fzf-locate-widget

fi
function peco_and_writeback() {
    BUFFER=$($LBUFFER | peco)
    CURSOR=$#BUFFER
    zle -R -c
}
zle -N peco_and_writeback
bindkey '^K' peco_and_writeback
# Search shell history with peco: https://github.com/peco/peco
# Adapted from: https://github.com/mooz/percol#zsh-history-search
if which peco &> /dev/null; then
    function peco_select_history() {
        local tac
        { which gtac &> /dev/null && tac="gtac" } || \
            { which tac &> /dev/null && tac="tac" } || \
            tac="tail -r"
        BUFFER=$(fc -l -n 1 | eval $tac | \
                        peco --layout=bottom-up --query "$LBUFFER")
        CURSOR=$#BUFFER # move cursor
        zle -R -c       # refresh
    }

    zle -N peco_select_history
    bindkey '^R' peco_select_history
fi
