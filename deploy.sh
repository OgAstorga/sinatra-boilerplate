#!/bin/bash


######
PWD=$(pwd)
DATE=$(date +"%Y-%m-%dT%H:%M:%S")
BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ -z ${RELEASE_PATH+x} ]; then
  RELEASE_PATH=$PWD/releases
fi
DEST_PATH=$RELEASE_PATH/$DATE
CREL_PATH=$RELEASE_PATH/current


######
echo "destination path: $DEST_PATH"


######
echo "copying source files to release folder"

# copy config file
declare -a keep=(
  ".env"
  "thin.yml"
)

for filename in "${keep[@]}"
do
  SOURCE=$PWD/$filename
  DEST=$DEST_PATH/$filename
  mkdir -p $(dirname $DEST)

  if [ -f $SOURCE ]; then
    cp $SoOURCE $DEST
    printf "*"
  else
    touch $DEST
    printf "o"
  fi
done

# copy source files
git ls-tree -r $BRANCH --name-only | while read SOURCE
do
  DEST=$DEST_PATH/$SOURCE

  mkdir -p $(dirname $DEST)
  cp $SOURCE $DEST
  printf "."
done

printf "\ndone\n\n"


######
echo "installing gems..."
cd $DEST_PATH
bundle install --path .bundle
cd $PWD
printf "done\n\n"


######
echo "changing current link..."
if [ -d $CREL_PATH ]; then
  rm $CREL_PATH
fi

ln -sr $DEST_PATH $CREL_PATH
printf "done\n\n"
