#!/bin/sh


#
# set up initial functions
fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

brew_install_or_upgrade() {
  if brew_is_installed "$1"; then
    if brew_is_upgradable "$1"; then
      fancy_echo "Upgrading %s ..." "$1"
      brew upgrade "$@"
    else
      fancy_echo "Already using the latest version of %s. Skipping ..." "$1"
    fi
  else
    fancy_echo "Installing %s ..." "$1"
    brew install "$@"
  fi
}

brew_is_installed() {
  local name="$(brew_expand_alias "$1")"

  brew list -1 | grep -Fqx "$name"
}

brew_is_upgradable() {
  local name="$(brew_expand_alias "$1")"

  ! brew outdated --quiet "$name" >/dev/null
}

brew_tap() {
  brew tap "$1" 2> /dev/null
}

brew_expand_alias() {
  brew info "$1" 2>/dev/null | head -1 | awk '{gsub(/:/, ""); print $1}'
}

#
# Install Homebrew and dependencies
if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
    curl -fsS \
      'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
    export PATH="/usr/local/bin:$PATH"
else
  fancy_echo "Homebrew already installed. Skipping ..."
fi

brew_install_or_upgrade 'zsh'
brew_install_or_upgrade 'git'
brew_install_or_upgrade 'fasd'
brew_install_or_upgrade 'the_silver_searcher'
#TODO do we need macvim?
# yes because powerline fonts error otherwise
# or update python?
# Be sure to add alias to macvim from brew to zshrc.
# https://www.google.com/search?q=vim+An+error+occurred+while+importing+powerline+module.&oq=vim+An+error+occurred+while+importing+powerline+module.&aqs=chrome..69i57j0l2.10231j0j1&sourceid=chrome&ie=UTF-8
# https://github.com/powerline/powerline/issues/1385
# brew_install_or_upgrade 'macvim' '--with-override-system-vim'
brew_install_or_upgrade 'macvim'
brew_install_or_upgrade 'ctags'
brew_install_or_upgrade 'cmake'
brew_install_or_upgrade 'direnv'
brew_install_or_upgrade 'tmux'
brew_install_or_upgrade 'reattach-to-user-namespace'

# switch to zsh
case "$SHELL" in
  */zsh) : ;;
  *)
    fancy_echo "Changing your shell to zsh ..."
      chsh -s "$(which zsh)"
    ;;
esac

if ! command -v rcup >/dev/null; then
  brew_tap 'thoughtbot/formulae'
  brew_install_or_upgrade 'rcm'
fi

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

#
# Allow users to provide their own set of scripts
if [ -f "$HOME/.dotfiles.local/install.sh" ]; then
  . "$HOME/.dotfiles.local/install.sh"
fi


#
# git clone shallow all of the dotfiles
if [ -d "$HOME/.dotfiles" ]; then
  echo "Dotfiles already cloned from hub.k3integrations.com/k3/dotfiles.\
    Please  remove and run the script again if you'd like to update to the latest."
else
  git clone --depth 1 https://gitlab.com/calebatyapa/dotfiles.git $HOME/.dotfiles
fi


# clone typescript-vim plugin to .vim/bundle directory
git clone https://github.com/leafgarland/typescript-vim.git ~/.vim/bundle/typescript-vim

env RCRC=$HOME/.dotfiles/rcrc rcup
export PATH=

