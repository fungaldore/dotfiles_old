[[ -a ~/.zshrc_before ]] && source ~/.zshrc_before

export ZSH=$HOME/.oh-my-zsh
export EDITOR='vim'

export PATH=/usr/local/share/npm/bin:$PATH

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
plugins=(fasd osx git brew zsh-syntax-highlighting)

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

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

[[ -a ~/.zshrc_after ]] && source ~/.zshrc_after

