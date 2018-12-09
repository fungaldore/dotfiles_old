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

# aliases and functions for chum docker, based on John's
#function dmeval {
  #eval "$(docker-machine env default)"
#}
#dmeval  # John has a cooler method to do this

# docker-compose zsh auto-complete (https://docs.docker.com/compose/completion/#zsh)
autoload -Uz compinit && compinit -i
fpath=(~/.zsh/completion $fpath)

alias d='docker'
alias dc='docker-compose'
alias dps='docker ps --format="table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Command}}\t{{.Ports}}"'
alias dcup='dc up'
alias dcs='dc start'
alias de='docker exec -it'
alias da='docker attach'

#alias dgw='docker exec -it lms_app_1 bash -c "cd client; gulp dev"'
#alias dcon='docker exec -it lms_app_1 rails c'
#alias dzcon='docker exec -it lms_app_1 bash -c "RAILS_ENV= zeus c"'
#alias dsh='docker exec -it lms_app_1 bash'
#alias drake='docker exec -it lms_app_1 rake'
#alias dz='docker exec -it lms_app_1 bash -c "zeus start"'
#alias dm='docker-machine'

#function dbb {
  #docker exec -it $@ byebug -R 5005
#}

#function zspec {
  #docker exec -it lms_app_1 bash -c "unset RAILS_ENV; zeus rspec $@"
#}

# don't forget to run this after `dc up`, otherwise chum and canvas can't talk
#function init_dns {
  #docker exec -it lms_app_1 bash -c "echo '172.16.240.128 canvas.chum.dev mail.chum.dev' >> /etc/hosts"
  #docker exec -it lms_canvas_1 bash -c "echo '172.16.240.128 chum.dev mail.chum.dev' >> /etc/hosts"
#}

[[ -a ~/.zshrc_after ]] && source ~/.zshrc_after

#function export_ci_compose_vars {
  #export COMPOSE_FILE=./config/docker/compose-ci.yml
  #export COMPOSE_PROJECT_NAME=nad/datarolluptest
  #export image_env=feature
#}

#function export_production_compose_vars {
  #export SERVER_ENV=production
  #export VIRTUAL_HOST=dashboardprod.dev
  #export CERT_NAME=$VIRTUAL_HOST
  #export mailname=$VIRTUAL_HOST
  #export MAIL_HOST=mail
  #export LETSENCRYPT_HOST=$VIRTUAL_HOST
  #export LETSENCRYPT_EMAIL=caleb.pope+letsencrypt-$VIRTUAL_HOST@k3integrations.com
  #export MAIL_HOST=mail
  #export MAIL_SSL_VERIFY_MODE=none
  #export NADE_AUTH_SERVER=https://dashboardprod.dev
  #export nad_dashboard_url=https://dashboardprod.dev
  #export nad_data_rollup_url=https://datarollupprod.dev
  #export nad_student_ids_url=https://studentidsprod.dev
  #export eadventist_pull_time=$eadventist_pull_time_staging
  #export COMPOSE_FILE=config/docker/compose-production.yml
  #export MYSQL_PASSWORD=dev
  #export eadventist_pull_time=
  #export WEB_CONCURRENCY=8
#}

alias clean_docker_containers='docker ps -aq --no-trunc | xargs docker rm'
alias clean_docker_images='docker images -qf dangling=true | xargs docker rmi'
alias clean_docker_volumes='docker volume ls -qf dangling=true | xargs docker volume rm'

function clean_docker {
  clean_docker_containers || true
  clean_docker_images || true
  clean_docker_volumes || true
  # need to clean networks too
}

function push_screeps_code {
  cp ~/workspace/sandbox/screeps/*.js ~/Library/Application\ Support/Screeps/scripts/screeps.com/default/
}
function pull_screeps_code {
  cp ~/Library/Application\ Support/Screeps/scripts/screeps.com/default/*.js ~/workspace/sandbox/screeps/
}

# git aliases
alias gls='git log --color --graph --pretty=format:"%Cred%h %Cgreen%ai %Cblue%an%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset" --abbrev-commit --date=relative'
alias glc='git log --color --graph --pretty=format:"%Cred%h%Creset %Cgreen%ai %Cblue%an -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset" --abbrev-commit --date=relative'  # end with commits (feature..master) to see what master has over feature


###-tns-completion-start-###
if [ -f /Users/caleb/.tnsrc ]; then
    source /Users/caleb/.tnsrc
fi
###-tns-completion-end-###


# for osX Mojave - use macvim instead of default vim
alias vim='/usr/local/Cellar/macvim/8.1-151/MacVim.app/Contents/bin/vim'
alias vi='vim'
alias python='python3'
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/Users/caleb/Library/Python/2.7/bin:$PATH"
