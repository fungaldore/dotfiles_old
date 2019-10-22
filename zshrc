[[ -a ~/.zshrc.before ]] && source ~/.zshrc.before

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
plugins=(fasd osx git brew zsh-syntax-highlighting docker)

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

[[ -a ~/.zshrc.after ]] && source ~/.zshrc.after



# initialize rvm
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# initialize rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# docker-compose zsh auto-complete (https://docs.docker.com/compose/completion/#zsh)
autoload -Uz compinit && compinit -i
fpath=(~/.zsh/completion $fpath)


function push_screeps_code {
  cp ~/workspace/sandbox/screeps/*.js ~/Library/Application\ Support/Screeps/scripts/screeps.com/default/
}
function pull_screeps_code {
  cp ~/Library/Application\ Support/Screeps/scripts/screeps.com/default/*.js ~/workspace/sandbox/screeps/
}


###-tns-completion-start-###
if [ -f /Users/caleb/.tnsrc ]; then
    source /Users/caleb/.tnsrc
fi
###-tns-completion-end-###


export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/Users/caleb/Library/Python/2.7/bin:$PATH"
