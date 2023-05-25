# Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"
alias reloadshell="source $HOME/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias ll="/opt/homebrew/opt/coreutils/libexec/gnubin/ls -AhlFo --color --group-directories-first"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias c="clear"
alias compile="commit 'compile'"
alias version="commit 'version'"
alias cat="bat"
alias grep="grep --color=auto"

# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias sites="cd $HOME/Sites"

# Laravel & PHP & Composer
alias phpunit="vendor/bin/phpunit"
alias pest="vendor/bin/pest"
alias a="valet php artisan"
alias c="/usr/local/bin/composer"
alias cu="/usr/local/bin/composer update"
alias cr="/usr/local/bin/composer require"
alias ci="/usr/local/bin/composer install"
alias cda="/usr/local/bin/composer dump-autoload -o"
alias hostfile="sudo vim /etc/hosts"
alias mfs='valet php artisan migrate:fresh --seed'
alias nah='git reset --hard;git clean -df'
alias ad="valet php artisan dusk"
alias adf="valet php artisan dusk --filter"
alias sshconfig="vim ~/.ssh/config"

# JS
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
alias watch="npm run watch"

# Docker
alias docker-composer="docker-compose"
alias leaf="docker run -e LOCAL_USER_ID=$(id -u ${USER}) --rm -v ~/codedor/leaf:/home/leaf -v ~/.ssh/id_rsa:/home/leaf/.ssh/id_rsa:ro -it --init codedor/leaf:latest"

# Git
alias gst="git status"
alias gb="git branch"
alias gc="git checkout"
alias gl="git log --oneline --decorate --color"
alias amend="git add . && git commit --amend --no-edit"
alias diff="git diff"
alias force="git push --force"
alias nuke="git clean -df && git reset --hard"
alias pop="git stash pop"
alias pull="git pull"
alias push="git push"
alias resolve="git add . && git commit --no-edit"
alias stash="git stash -u"
alias unstage="git restore --staged ."
alias wip="commit wip"
