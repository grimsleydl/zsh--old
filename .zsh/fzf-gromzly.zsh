fzf-history-search-backward() {
    local buffer="$BUFFER"
    buffer="${buffer#"${buffer%%[![:space:]]*}"}"
    buffer="${buffer%"${buffer##*[![:space:]]}"}"
    # http://unix.stackexchange.com/a/11941
    LBUFFER=$(fc -l -n 1 | sed "s/ *[0-9*]* *//" | awk '!seen[$0]++' | grep "^$buffer" | fzf +s +m -n2..,..)
    zle redisplay
}

zle     -N    fzf-history-search-backward
bindkey '\ep' fzf-history-search-backward

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
    local selected num
    selected=( $(fc -l -n 1 | $(__fzfcmd) +s --tac +m -n2..,.. --tiebreak=index --toggle-sort=ctrl-r -q "${LBUFFER//$/\\$}") )
    if [ -n "$selected" ]; then
        num=$selected[1]
        if [ -n "$num" ]; then
            zle vi-fetch-history -n $num
        fi
    fi
    zle redisplay
}
zle     -N   fzf-history-widget
bindkey '\er' fzf-history-widget
