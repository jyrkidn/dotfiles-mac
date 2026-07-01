#!/bin/sh

echo "Setting up your Mac..."

# Make sure we know where the dotfiles live (in case this is run directly)
export DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles.
# The shell config is a plain zsh setup (starship + brew plugins) — no framework needed.
rm -rf $HOME/.zshrc
ln -s $DOTFILES/.zshrc $HOME/.zshrc

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile).
# This installs the shell tools .zshrc relies on: starship, zsh-autosuggestions,
# zsh-syntax-highlighting, zsh-completions, fnm, fzf, zoxide — plus Laravel Herd.
brew tap homebrew/bundle
brew bundle --file $DOTFILES/Brewfile

# Install PHP extensions with PECL
pecl install imagick redis swoole

# Install global Composer packages
$HOME/.composer/vendor/bin/composer global require laravel/installer tightenco/takeout

# PHP / local dev is handled by Laravel Herd (installed as a cask via the Brewfile).
# Open Herd once to finish its setup: open -a Herd

# Create a Sites directory
mkdir $HOME/Sites

# Symlink the Mackup config file to the home directory
ln -s $DOTFILES/.mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences - we will run this last because this will reload the shell
source $DOTFILES/.macos
