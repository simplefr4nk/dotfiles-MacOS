# ~/.zshrc

# open the Starship Prompt
eval "$(starship init zsh)"

# add the autosuggestion
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

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

# add syntax highlighting
source /Users/enricofranco/Scripts/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#alias
alias ls="exa"
alias ll="exa -lh"
alias move-rename="/Users/enricofranco/Scripts/move_and_rename"

alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias rng='ranger'

# to update packages of sketchybar with brew()
function brew() {
  command brew "$@" 

  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_update
  fi
}

# command to copy all dotfiles in the local repo
function copy-dotfiles(){

  cp ~/.zshrc ~/myrepo/dotfiles-MacOS/
  cp -r ~/.config/alacritty  ~/myrepo/dotfiles-MacOS/
  cp -r ~/.config/fastfetch ~/myrepo/dotfiles-MacOS/
  cp -r ~/.config/kitty  ~/myrepo/dotfiles-MacOS/
  cp -r ~/.config/neofetch  ~/myrepo/dotfiles-MacOS/
  cp -r ~/.config/ranger  ~/myrepo/dotfiles-MacOS/
  cp -r ~/.config/starship.toml  ~/myrepo/dotfiles-MacOS/
  cp -r ~/.config/nvim ~/myrepo/dotfiles-MacOS/
  
}
