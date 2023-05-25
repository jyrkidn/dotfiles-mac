tag() {
    tag=$1
    git tag -a $tag -m "Released $tag" && git push -u origin $tag
}

dirty_folders() {
  START=`pwd`; find . -type d | egrep "\.git$" | while read git_folder; do s=`cd $git_folder; cd ..; git status -sb`; count=`echo $s | wc -l`; [ ! $count -eq 1 ] && echo $git_folder | sed 's/\.git//g'; cd $START; done
}

# All the dig info
function digga() {
  dig +nocmd "$1" any +multiline +noall +answer
}

# Scrape a single webpage with all assets
function scrapeUrl() {
  wget --adjust-extension --convert-links --page-requisites --span-hosts --no-host-directories "$1"
}

#  Commit everything
function commit() {
  commitMessage="$1"

  if [ "$commitMessage" = "" ]; then
     commitMessage="wip"
  fi

  git add .
  eval "git commit -a -m '${commitMessage}'"
}

function p () {
  vendor/bin/$(phpunit-or-pest) $*;
}
function pf () {
  vendor/bin/$(phpunit-or-pest) --filter $*
}
function pg () {
  vendor/bin/$(phpunit-or-pest) --group $*
}

# usage:
#    up 2 = cd ../..
#    up www = will cd to the www folder
function up() {
  case $1 in
    *[!0-9]*)                                          # if no a number
      cd $( pwd | sed -r "s|(.*/$1[^/]*/).*|\1|" )     # search dir_name in current path, if found - cd to it
      ;;                                               # if not found - not cd
    *)
      cd $(printf "%0.0s../" $(seq 1 $1));             # cd ../../../../  (N dirs)
    ;;
  esac
}

# usage db create|refresh|drop [database_name]
function db {
  [ ! -f .env ] && { echo "No .env file found."; exit 1; }

  DB_CONNECTION=$(grep DB_CONNECTION .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
  DB_HOST=$(grep DB_HOST .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
  DB_PORT=$(grep DB_PORT .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)

  if [ -z "$2" ]; then
    DB_DATABASE=$(grep DB_DATABASE .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
  else
    DB_DATABASE=$2
  fi

  DB_USERNAME=$(grep DB_USERNAME .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
  DB_PASSWORD=$(grep DB_PASSWORD .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)

  if [ "$1" = "refresh" ]; then
    mysql -h${DB_HOST} -P${DB_PORT} -u${DB_USERNAME} -p${DB_PASSWORD} -e "drop database ${DB_DATABASE}; create database ${DB_DATABASE}"
  elif [ "$1" = "create" ]; then
    mysql -h${DB_HOST} -P${DB_PORT} -u${DB_USERNAME} -p${DB_PASSWORD} -e "create database ${DB_DATABASE}"
  elif [ "$1" = "drop" ]; then
    mysql -h${DB_HOST} -P${DB_PORT} -u${DB_USERNAME} -p${DB_PASSWORD} -e "drop database ${DB_DATABASE}"
  fi
}

function opendb () {
   [ ! -f .env ] && { echo "No .env file found."; exit 1; }

   DB_CONNECTION=$(grep DB_CONNECTION .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
   DB_HOST=$(grep DB_HOST .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
   DB_PORT=$(grep DB_PORT .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
   DB_DATABASE=$(grep DB_DATABASE .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
   DB_USERNAME=$(grep DB_USERNAME .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
   DB_PASSWORD=$(grep DB_PASSWORD .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)

   DB_URL="${DB_CONNECTION}://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}"

   echo "Opening ${DB_URL}"
}

function lssh() {
  env="$2"

  if [ "$env" = "" ]; then
     env="jyrki-de-neve"
  fi

  leaf l27:ssh $1 $env
}

