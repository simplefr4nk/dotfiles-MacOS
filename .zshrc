# ~/.zshrc

# open the Starship Prompt
eval "$(starship init zsh)"

# add the autosuggestion, syntax highlighting and completions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh

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
alias pokemon-icat="/Users/enricofranco/Scripts/pokemon-icat/pokemon-icat.sh"

if [ $TERM = 'xterm-kitty' ]; then
  pokemon-icat # do pokemon-icat on kitty terminal
else
  krabby random # do krabby random only if the terminal is alacritty
fi

#alias
alias ls="exa -1 --icons"
alias lsg="exa -a1 --icons | grep $1"
alias ll="exa -lh --icons"
alias llg="exa -alh --icons | grep $1"
alias lt="exa --tree --level=2 --icons"
alias move-rename="/Users/enricofranco/Scripts/move_and_rename"
alias reddit-scrape="/Users/enricofranco/Scripts/reddit-scrape"

alias ranger='ranger --choosedir=/tmp/$USER/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias rng='ranger'
alias joshuto='joshuto --output-file /tmp/$USER/.joshuto ; DIR=`cat /tmp/$USER/.joshuto` ; cd "$DIR"'
alias js='joshuto'

# alias git
alias lg='lazygit'

# to update packages of sketchybar with brew()
function brew() {
  command brew "$@" 

  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_update
  fi
}
export PATH="/usr/local/opt/qt@5/bin:$PATH"
