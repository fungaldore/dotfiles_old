export ZSH=$HOME/.oh-my-zsh
export EDITOR='vim'

export PATH=/snap/bin:~/bin:/usr/local/share/npm/bin:$PATH

#Setup go
export GOPATH=$HOME/.go

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
# ZSH_THEME="agnoster"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

COMPLETION_WAITING_DOTS="true"

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails osx git textmate ruby lighthouse)
#plugins=(fasd osx git brew zsh-syntax-highlighting docker)
plugins=(git fasd zsh-syntax-highlighting docker)

source $ZSH/oh-my-zsh.sh

# Powerline path setup
export PYTHONPATH=$PYTHONPATH:~/.vim/bundle/powerline
export PATH=$PATH:~/.vim/bundle/powerline/scripts

# Wire in Powerline
powerline-daemon -q
. $HOME/.vim/bundle/powerline/powerline/bindings/zsh/powerline.zsh

# Customize to your needs...
unsetopt auto_name_dirs

[[ -a ~/.aliases ]] && source ~/.aliases

#Fasd
eval "$(fasd --init auto)"

# Direnv
eval "$(direnv hook zsh)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# initialize rvm
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# initialize rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# initialize node version manager
export NVM_DIR="$HOME/.nvm"
  # This loads nvm
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
  # This loads nvm bash_completion
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

# docker-compose zsh auto-complete (https://docs.docker.com/compose/completion/#zsh)
autoload -Uz compinit && compinit -i
fpath=(~/.zsh/completion $fpath)

###-tns-completion-start-###
if [ -f /Users/caleb/.tnsrc ]; then
    source /Users/caleb/.tnsrc
fi
###-tns-completion-end-###


###############################################################################
### Custom simple prompt
# inspiration: https://github.com/andrew8088/dotfiles/blob/master/zsh/zfunctions/prompt_pure_setup
###############################################################################

#PROMPT=' %F{yellow}%n%F{green}@%F{yellow}%m  %F{green}%~ %F{red}❯%f '

# sample prompt codes
# git:
# %b => current branch
# %a => current action (rebase/merge)
#
# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)
#
# terminal codes:
# \e7   => save cursor position
# \e[2A => move cursor 2 lines up
# \e[1G => go to position 1 in terminal
# \e8   => restore cursor position
# \e[K  => clears everything after the cursor on the current line
# \e[2K => clear everything on the current line

###############################################################################

# NOTES:
# to make skyrim run in the background (for arrow farming)
# edit /home/caleb/.local/share/Steam/steamapps/compatdata/489830/pfx/drive_c/users/steamuser/My Documents/My Games/Skyrim Special Edition/Skyrim.ini
# Append bAlwaysActive=1 to [General]
#
# Disable alt opening menu on firefox
# https://www.reddit.com/r/firefox/comments/6l5ioi/how_can_i_disable_pressing_alt_bringing_up_menu/
