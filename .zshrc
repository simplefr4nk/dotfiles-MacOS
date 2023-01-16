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
alias ll="exa -lh --icons"
alias lt="exa --tree --level=2 --icons"
alias move-rename="/Users/enricofranco/Scripts/move_and_rename"
alias reddit-scrape="/Users/enricofranco/Scripts/reddit-scrape"

alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias rng='ranger'

# alias git
alias lg='lazygit'

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
source /Users/enricofranco/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
