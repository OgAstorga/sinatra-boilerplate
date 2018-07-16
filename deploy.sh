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
if [ -f .env ]; then
  mkdir -p $DEST_PATH
  cp .env $DEST_PATH/.env
fi

# copy source files
git ls-tree -r $BRANCH --name-only | while read ORIGIN
do
  DEST=$DEST_PATH/$ORIGIN

  mkdir -p $(dirname $DEST)
  cp $ORIGIN $DEST
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
