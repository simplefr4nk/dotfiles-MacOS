# ~/.zshrc

# open the Starship Prompt
eval "$(starship init zsh)"

# open fzf syggestion
eval "$(fzf --zsh)"

# add the autosuggestion, syntax highlighting, completions and history search
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# bind up and down arrow for substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# let me sign using GPG keys
export GPG_TTY=$(tty)

# let me mosh in other machines
export LANG=it_IT.UTF-8

# to use brew simpler without auto update
export HOMEBREW_NO_AUTO_UPDATE=1

# do pokemon-icat similar to krabby but smaller
alias pokemon-icat="$HOME/Scripts/pokemon-icat/pokemon-icat.sh"

if [ $TERM = 'xterm-kitty' ]; then
  pokemon-icat # do pokemon-icat on kitty terminal
else
  krabby random # do krabby random only if the terminal is alacritty
fi

#alias for eza
alias ls="eza -1 --icons"
alias lsa="eza -a1 --icons"
alias lsg="eza -a1 --icons | grep $1"

alias ll="eza -lh --icons"
alias lla="eza -alh --icons"
alias llg="eza -alh --icons | grep $1"

alias lt="eza --tree --level=2 --icons"

#alias for my scripts
alias move-rename="$HOME/Scripts/move_and_rename"
alias reddit-scrape="$HOME/Scripts/reddit-scrape"

#alias for ranger and joshuto
alias joshuto='joshuto --output-file /tmp/.joshuto ; DIR=`cat /tmp/.joshuto` ; cd "$DIR"'
alias js='joshuto'

# alias lazy~ programs 
alias lg='lazygit'
alias ld='lazydocker'

# alias for sherlock - lestrade
alias sherlock="ssh sherlock 'tmux -u new -A -s ssh'"
#alias lestrade="tmux new -A -s lestraed 'clear ; ssh lestrade'"

# to update packages of sketchybar with brew()
# function brew() {
#   command brew "$@" 
#
#   if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
#     sketchybar --trigger brew_update
#   fi
# }

# Alias youtube downloader
alias youtube="yt-dlp -f 'bv*+ba' -S ext:mp4:m4a $1"

# rsync command to backup Lestrade
alias rsync-lestrade="rsync -avzhe 'ssh -p 34567' lestrade:headsec . --stats"

# rsync to sherlock sherlock
function copyToSherlock() {
    if [ "$#" -ne 2 ]; then
        echo "Usage: copyToSherlock $FROM sherlock:$TO"
        return 1
    fi
    local FROM="$1"
    local TO="$2"
    rsync -avhze "ssh -p 53639" "$FROM" "sherlock:$TO" --stats
}

# alias for text editors
alias nv='nvim'
alias nn='nano'

# alias to jump on my repositories
alias pro="cd $HOME/project"

# change GOPATH to remove it from the home folder
export GOPATH=/Users/enricofranco/.local/go
export GOBIN=$GOPATH/bin
export PATH=$GOBIN:$PATH

# emacs (doomemacs)
export PATH="$PATH:/Users/enricofranco/.config/emacs/bin"

# export PATH for python (?)
export PATH="/Users/enricofranco/.local/bin:/usr/local/sbin:$PATH"
# and emacs
export PATH="/usr/local/opt/avr-gcc@8/bin:$PATH"
export PATH="/usr/local/opt/arm-none-eabi-gcc@8/bin:$PATH"
export PATH="/usr/local/opt/arm-none-eabi-binutils/bin:$PATH"
