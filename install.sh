#!/bin/sh


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



if [ "$(uname)" == "Darwin" ]; then
  # Install Homebrew and dependencies
  if ! command -v brew >/dev/null; then
    fancy_echo "Installing Homebrew ..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      export PATH="/usr/local/bin:$PATH"
  else
    fancy_echo "Homebrew already installed. Skipping ..."
  fi

  brew_install_or_upgrade '1password'
  brew_install_or_upgrade 'nordvpn'

  #TODO pause

  # CLI basics
  brew_install_or_upgrade 'zsh'
  brew_install_or_upgrade 'git'
  #brew_install_or_upgrade 'fasd' # replaced by fzf?
  brew_install_or_upgrade 'the_silver_searcher'
  brew_install_or_upgrade 'ripgrep' # for nvim telescope
  #TODO do we need macvim?
  # yes because powerline fonts error otherwise
  # or update python?
  # Be sure to add alias to macvim from brew to zshrc.
  # https://www.google.com/search?q=vim+An+error+occurred+while+importing+powerline+module.&oq=vim+An+error+occurred+while+importing+powerline+module.&aqs=chrome..69i57j0l2.10231j0j1&sourceid=chrome&ie=UTF-8
  # https://github.com/powerline/powerline/issues/1385
  # brew_install_or_upgrade 'macvim' '--with-override-system-vim'
  brew_install_or_upgrade 'btop'
  brew_install_or_upgrade 'cmake'
  brew_install_or_upgrade 'ctags'
  brew_install_or_upgrade 'direnv'
  brew_install_or_upgrade 'eza' # a better looking version of ls
  brew_install_or_upgrade 'findutils' # to get gfind (gnu find)
  brew_install_or_upgrade 'macvim'
  brew_install_or_upgrade 'nvm'
  brew_install_or_upgrade 'python'
  #brew_install_or_upgrade 'neovim'
  #pip3 install pynvim
  brew_install_or_upgrade 'reattach-to-user-namespace'
  brew_install_or_upgrade 'tmux'
  brew_install_or_upgrade 'hiddenbar'
  brew_install_or_upgrade 'htop'

  # The rest of my apps
  #TODO make these work as brew install --cask opera etc.
  brew_install_or_upgrade 'alfred'
  brew_install_or_upgrade 'app-tamer'
  brew_install_or_upgrade 'arc'
  brew_install_or_upgrade 'arduino-ide'
  brew_install_or_upgrade 'audio-hijack'
  #brew_install_or_upgrade 'bettertouchtool' # 20250114 Throws SHA256 mismatch error. Proabably better to download this one from the internet manually for now.
  brew_install_or_upgrade 'bitwarden'
  brew_install_or_upgrade 'blender'
  brew_install_or_upgrade 'brave-browser'
  #brew_install_or_upgrade 'copyclip' # how to get v1?
  brew_install_or_upgrade 'cubicsdr'
  brew_install_or_upgrade 'curseforge'
  brew_install_or_upgrade 'discord'
  #brew_install_or_upgrade 'docker' # cask
  brew_install_or_upgrade 'firefox'
  brew_install_or_upgrade 'gimp'
  brew_install_or_upgrade 'istat-menus'
  brew_install_or_upgrade 'iterm2'
  brew_install_or_upgrade 'karabiner-elements'
  brew_install_or_upgrade 'keyboard-cleaner'
  brew_install_or_upgrade 'kitty' # my new favorite terminal emulator
  brew_install_or_upgrade 'obsidian'
  #brew_install_or_upgrade 'ollama' # cask
  brew_install_or_upgrade 'opera'
  brew_install_or_upgrade 'parallels'
  brew_install_or_upgrade 'prismlauncher'
  brew_install_or_upgrade 'qflipper'
  brew_install_or_upgrade 'raspberry-pi-imager'
  brew_install_or_upgrade 'signal'
  brew_install_or_upgrade 'slack'
  brew_install_or_upgrade 'spotify'
  brew_install_or_upgrade 'steam'
  brew_install_or_upgrade 'tradingview'
  brew_install_or_upgrade 'transmission'
  brew_install_or_upgrade 'visual-studio-code'
  brew_install_or_upgrade 'vlc'
  brew_install_or_upgrade 'vnc-viewer'
  brew_install_or_upgrade 'wezterm'
  #brew_install_or_upgrade 'wireshark' # cask
  brew_install_or_upgrade 'xquartz'
  brew_install_or_upgrade 'zed'
  brew_install_or_upgrade 'zoom'

  if ! command -v rcup >/dev/null; then
    brew_tap 'thoughtbot/formulae'
    brew_install_or_upgrade 'rcm'
  fi

  if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi

  # git clone shallow all of the dotfiles
  if [ -d "$HOME/.dotfiles" ]; then
    echo "Dotfiles already cloned from hub.k3integrations.com/k3/dotfiles.\
      Please  remove and run the script again if you'd like to update to the latest."
  else
    git clone --depth 1 https://github.com/fungaldore/dotfiles_old.git $HOME/.dotfiles
  fi

  env RCRC=$HOME/.dotfiles/rcrc rcup

  ln -s /opt/homebrew/bin/python3 /opt/homebrew/bin/python

  # Reset dock pinned items
  defaults write "com.apple.dock" "persistent-apps" -array; killall Dock

  # mac keyboard repeat rate to something sensible
  # Source: https://apple.stackexchange.com/a/83923
  # beforehand
  #   defaults read -g InitialKeyRepeat is 15
  # and
  #   defaults read -g KeyRepeat is 2
  # using the fastest I can make it through the settings UI
  # I like 10 and 1 respectively
  defaults write -g InitialKeyRepeat -int 10
  defaults write -g KeyRepeat -int 1

  # oh-my-zsh plugins
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

  ## switch to zsh
  ## Old method when zsh wasn't the default shell in macos
  ##case "$SHELL" in
  ##  */zsh) : ;;
  ##  *)
  ##    fancy_echo "Changing your shell to zsh ..."
  ##      chsh -s "$(which zsh)"
  ##    ;;
  #esac
  # New method now that macos ships with its own zsh
  # allow /opt/homebrew/bin/zsh to be used
  sudo echo "$(which zsh)" >> /etc/shells
  # set /opt/homebrew/bin/zsh as the default shell
  chsh -s "$(which zsh)"


  # TODO Maybe install frida?
  # Source: https://notes.alinpanaitiu.com/Fullscreen%20apps%20above%20the%20MacBook%20notch
  # pip install frida-tools

  echo "/n"
  echo "===================================="
  echo 'Manual tasks at the end'
  echo 'see the install script for a list'
  echo "===================================="
  # download (keep downloaded) obsidian vault from icloud drive

  # sign in to firefox, arc
  # sync brave

  # install neovim, if this works move it into the automated portion of the script
  # brew install miniconda
  # conda init
  # restart session
  # pip install pynvim
  # brew install neovim
  # inside nvim
  #   :checkhealth (all good?)
  #   :PlugInstall
  # nvim should work now

  # fix youcompleteme?
  # brew install cmake python go nodejs (use nvm for nodejs)

  # install my fonts, and script it
  # powerline, menlolig

  # copy over ~/.config and ~/.local/share/nvim
  # changes in these plugins, just copy whole directories for now
  # neovim (.vim/plugged) and vim (.vim/bundle)
  # - fogbell
  # - nerdcommenter
  # - vim-easymotion
  # - vim-illuminate

  # copy iterm configs
  # copy btt configs
  # copy istat menus configs
  # copy karabiner configs
  #
  # Add
  # auth       sufficient     pam_tid.so
  # to beginning of /etc/pam.d/sudo
fi

if [ "$(uname)" == "Linux" ]; then
  if [ -f /etc/debian_version ] ; then
    sudo apt update -qq && sudo apt install -y \
      build-essential \
      aptitude \
      python3 \
      zsh \
      tmux \
      curl \
      git \
      vim \
      silversearcher-ag \
      fasd \
      btop \
      htop \
      direnv \
      kitty \
      python3-pynvim \
      neovim

    # Install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # oh-my-zsh plugins
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

    # switch to zsh
    # Old method when zsh wasn't the default shell in macos
    case "$SHELL" in
      */zsh) : ;;
      *)
        echo "Changing your shell to zsh ..."
        echo "NOTE: Hit ctrl-d when this completes to finish install script"
        echo "TODO script gets stuck here, so I just copied and pasted the rest of it"
          chsh -s "$(which zsh)"
        ;;
    esac

    git clone https://github.com/fungaldore/dotfiles_old.git ~/.dotfiles

    mkdir -p ~/.config/nvim
    mkdir -p ~/.config/kitty
    ln -sfF ~/.dotfiles/condarc           ~/.condarc
    ln -sfF ~/.dotfiles/tmux.conf         ~/.tmux.conf
    ln -sfF ~/.dotfiles/vimrc             ~/.vimrc
    ln -sfF ~/.dotfiles/vimrc.common.vim  ~/.vimrc.common.vim
    ln -sfF ~/.dotfiles/init.vim          ~/.config/nvim/init.vim
    ln -sfF ~/.dotfiles/zshrc             ~/.zshrc
    ln -sfF ~/.dotfiles/bashrc            ~/.bashrc
    ln -sfF ~/.dotfiles/aliases           ~/.aliases
    ln -sfF ~/.dotfiles/kitty.conf        ~/.config/kitty/kitty.conf

    # Because powerline or oh-my-zsh still references python2
    sudo ln -s /usr/bin/python3 /usr/bin/python

    # Install powerline plugin for oh-my-zsh theme
    mkdir -p .vim/bundle
    git clone https://github.com/powerline/powerline ~/.vim/bundle/powerline

    # Install vim-plug for neovim
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    # Install neovim plugins
    nvim -c "PlugInstall"

    echo "\n"
    echo "####################################################################"
    echo "################ Reboot for changes to take affect #################"
    echo "####################################################################"
  fi

  if [ "$(uname -r | grep 'MANJARO')" ]; then
    pacman -Syu --noconfirm || \
    pacman -S --noconfirm sudo || \
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm vim tmux zsh git curl the_silver_searcher \
      ctags cmake python which fasd

    # download and install dotfiles
    git clone -b arch_dev_setup --recurse-submodules -j8 \
        https://github.com/fungaldore/dotfiles_old.git ~/.dotfiles.tmp
    mv -f ~/.dotfiles.tmp ~/.dotfiles

    ln -sfF ~/.dotfiles/tmux      ~/.tmux
    ln -sfF ~/.dotfiles/oh-my-zsh ~/.oh-my-zsh
    ln -sfF ~/.dotfiles/vim       ~/.vim
    ln -sfF ~/.dotfiles/tmux.conf ~/.tmux.conf
    ln -sfF ~/.dotfiles/vimrc     ~/.vimrc
    ln -sfF ~/.dotfiles/zshrc     ~/.zshrc
    ln -sfF ~/.dotfiles/bashrc    ~/.bashrc
    ln -sfF ~/.dotfiles/aliases   ~/.aliases
    ln -sfF ~/.dotfiles/kitty.conf ~/.config/kitty/kitty.conf
  fi
fi

###############################################################################
# all brew packages
###############################################################################
# $brew list
# ==> Formulae
# aircrack-ng			icu4c@77			limesuite			pdf2json
# asitop				iftop				little-cms2			pinentry
# bash				jpeg-turbo			lpeg				pixman
# brotli				libassuan			lua				poppler
# btop				libevent			luajit				python@3.13
# c-ares				libgcrypt			luv				rcm
# ca-certificates			libgit2				lz4				readline
# cairo				libgpg-error			lzo				reattach-to-user-namespace
# cmake				libidn2				macvim				repo
# cscope				libksba				miniupnpc			ripgrep
# ctags				liblinear			mpdecimal			ruby
# direnv				libnghttp2			msgpack				soapysdr
# docker				libpng				ncurses				sqlite
# docker-completion		libssh2				neovim				the_silver_searcher
# eza				libtasn1			nettle				tmux
# findutils			libtiff				nmap				transmission-cli
# fontconfig			libunistring			node				tree-sitter
# freetype			libusb				npth				unbound
# gettext				libuv				nspr				unibilium
# git				libvterm			nss				utf8proc
# glib				libx11				nvm				wxwidgets
# gmp				libxau				ollama				xorgproto
# gnupg				libxcb				openjpeg			xz
# gnutls				libxdmcp			openssl@3			zsh
# gpgme				libxext				p11-kit				zstd
# grc				libxrender			pcre
# gtop				libyaml				pcre2

# ==> Casks
# 1password		blender			iterm2			qflipper		visual-studio-code
# alfred			brave-browser		karabiner-elements	raspberry-pi-imager	vlc
# android-studio		cubicsdr		keyboard-cleaner	slack			vnc-viewer
# app-tamer		curseforge		kitty			spotify			wezterm
# arc			discord			miniconda		steam			wireshark
# arduino-ide		firefox			obsidian		tradingview		xquartz
# audio-hijack		font-hack-nerd-font	opera			transmission		zed
# bitcoin-core		gimp			parallels		utm			zoom
# bitwarden		istat-menus		prismlauncher		virtualbox
