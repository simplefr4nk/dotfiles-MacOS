# ~/.zshrc

# open the Starship Prompt
eval "$(starship init zsh)"

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

# do pfetch everytime a terminal windows is opened
#pfetch

# do fastfetch everytime a terminal windows is opened
#fastfetch --load-config ~/.config/fastfetch/myconfig.conf

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
alias ranger='ranger --choosedir=/tmp/.rsangerdir; LASTDIR=`cat /tmp/.rangerdir`; cd "$LASTDIR"'
alias rng='ranger'
alias joshuto='joshuto --output-file /tmp/.joshuto ; DIR=`cat /tmp/.joshuto` ; cd "$DIR"'
alias js='joshuto'

# alias git
alias lg='lazygit'

# alias for sherlock - lestrade
#alias sherlock="tmux new -A -s sherlock 'clear ; ssh sherlock'"
#alias lestrade="tmux new -A -s lestraed 'clear ; ssh lestrade'"

# to update packages of sketchybar with brew()
function brew() {
  command brew "$@" 

  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_update
  fi
}

# Alias youtube downloader
alias youtube="yt-dlp -f 'bv*+ba' -S ext:mp4:m4a $1"

# rsync command to backup Lestrade
alias rsync-lestrade="rsync -avzhe 'ssh -p 34567' lestrade:headsec . --stats"

# bat aliases to use the light theme
alias bat="bat --theme=gruvbox-dark"

# alias to jump on my repositories
alias pro="cd $HOME/project"

# change GOPATH to remove it from the home folder
export GOPATH=/Users/enricofranco/.local/go
export GOBIN=$GOPATH/bin
export PATH=$GOBIN:$PATH

# export PATH for python (?)
export PATH="/usr/local/sbin:$PATH"
