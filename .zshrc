# ~/.zshrc

# open the Starship Prompt
eval "$(starship init zsh)"

# add the autosuggestion
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# do pfetch everytime a terminal windows is opened
#pfetch

# do fastfetch everytime a terminal windows is opened
#fastfetch --load-config ~/.config/fastfetch/myconfig.conf

# do pokeshell everytime a new terminal windows is opened
#pokeshell random

# do pokemon-icat similar to krabby but smaller
alias pokemon-icat="/Users/enricofranco/Scripts/pokemon-icat/pokemon-icat.sh"
pokemon-icat

# add syntax highlighting
source /Users/enricofranco/Scripts/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#alias
alias ls="exa"
alias ll="exa -lh"
alias move-rename="/Users/enricofranco/Scripts/move_and_rename"

# function to close ranger and keep the shell on the directory chosen
function ranger_func {
    ranger $*
    local quit_cd_wd_file="$HOME/.ranger_quit_cd_wd"
    if [ -s "$quit_cd_wd_file" ]; then
        cd "$(cat $quit_cd_wd_file)"
        true > "$quit_cd_wd_file"
    fi
}

# to use the function just created with the alias
alias ranger='ranger_func'

# to update packages of sketchybar with brew()
function brew() {
  command brew "$@" 

  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_update
  fi
}
