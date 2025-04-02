export ZSH=$HOME/.oh-my-zsh
export EDITOR='nvim'
#export EDITOR="zed --wait" # doesn't work
#export EDITOR="zed" # doesn't save crontab file
export LESS='-FINR'

export PATH=/snap/bin:~/bin:/usr/local/share/npm/bin:$PATH

#Setup go
export GOPATH=$HOME/.go

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
# ZSH_T+# Favorite themes
# ZSH_THEME=agnoster
# ZSH_THEME=arrow
# ZSH_THEME=gnzh
# ZSH_THEME=jonathan
# ZSH_THEME=kardan
# ZSH_THEME=nicoulaj
# ZSH_THEME=refined
# ZSH_THEME=simonoffHEME="agnoster"

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
#plugins=(git fasd brew zsh-syntax-highlighting zsh-autocomplete docker docker docker-compose)
plugins=(git fasd brew zsh-syntax-highlighting zsh-autosuggestions docker docker docker-compose)

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
#eval "$(fasd --init auto)"
#source <(fzf --zsh)

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
# Using /opt/homebrew for apple silicon based macs
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh" # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# Using /usr/local/opt for intel based macs
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# docker-compose zsh auto-complete (https://docs.docker.com/compose/completion/#zsh)
autoload -Uz compinit && compinit -i
fpath=(~/.zsh/completion $fpath)

###-tns-completion-start-###
if [ -f /Users/caleb/.tnsrc ]; then
    source /Users/caleb/.tnsrc
fi
###-tns-completion-end-###

### Add openjdk (from homebrew) to PATH
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

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
### Make skyrim run in the background (for arrow farming)
# edit /home/caleb/.local/share/Steam/steamapps/compatdata/489830/pfx/drive_c/users/steamuser/My Documents/My Games/Skyrim Special Edition/Skyrim.ini
# Append bAlwaysActive=1 to [General]
#
### Disable alt opening menu on firefox
# https://www.reddit.com/r/firefox/comments/6l5ioi/how_can_i_disable_pressing_alt_bringing_up_menu/
#
### Hide/Show menu bar via defaults read/write
# Doesn't seem to be working in Ventura, but killall Finder was supposed to work in El Cap.
# `defaults write "Apple Global Domain" _HIHideMenuBar 1`
# or
# `defaults write "Apple Global Domain" _HIHideMenuBar -bool true`
# and
# `killall Finder`
# Always hide: AppleMenuBarVisibleInFullscreen = 0, _HIHideMenuBar = 1
# Hide in desktop only: AppleMenuBarVisibleInFullscreen = 1, _HIHideMenuBar = 1
# Hide in fullscreen only: AppleMenuBarVisibleInFullscreen = 0, _HIHideMenuBar = 0
# Never hide: AppleMenuBarVisibleInFullscreen = 1, _HIHideMenuBar = 0
#

if [ -f /Users/caleb/.docker/init-zsh.sh ]; then
  source /Users/caleb/.docker/init-zsh.sh || true # Added by Docker Desktop
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

