[[ -d ~/.zplug ]] || {
    curl -fLo ~/.zplug/zplug --create-dirs https://git.io/zplug
    source ~/.zplug/zplug && zplug update --self
}

source ~/.zplug/zplug

# zplug check return true if all plugins are installed
# Therefore, when it returns not true (thus false),
# run zplug install
# if ! zplug check --verbose; then
#     printf "Install? [y/N]: "
#     if read -q; then
#         echo; zplug install
#     fi
# fi


zplug "b4b4r07/zplug"

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"

# zplug "knu/z", of:z.sh, nice:10

zplug "b4b4r07/enhancd", of:enhancd.sh
# zplug check returns true if argument repository exists
if zplug check b4b4r07/enhancd; then
    # setting if enhancd is available
    export ENHANCD_FILTER=fzf
fi
# zplug "djui/alias-tips"

zplug "plugins/archlinux", from:oh-my-zsh
zplug "plugins/chruby", from:oh-my-zsh
zplug "plugins/copydir", from:oh-my-zsh
zplug "plugins/copyfile", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
# zplug "plugins/npm", from:oh-my-zsh
# zplug "plugins/postgres", from:oh-my-zsh
zplug "plugins/systemadmin", from:oh-my-zsh
zplug "plugins/systemd", from:oh-my-zsh
# zplug "plugins/fasd", from:oh-my-zsh
# zplug "jeebak/e13c209da18ef5981792", from:gist
# zplug "mkwmms/411a38ba19cb1d7b2baf", from:gist
zplug "~/.zsh/", from:local, ignore:node.zsh
zplug "mafredri/zsh-async", of:async.zsh
zplug "sindresorhus/pure"
zplug "junegunn/fzf"
zplug "junegunn/fzf", of:"shell/*.zsh"
zplug "atweiden/fzf-extras", of:fzf-extras.sh
zplug "mkwmms/411a38ba19cb1d7b2baf", from:gist
# source and add to the PATH
zplug load

