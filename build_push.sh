#!/bin/bash

ARCH="gpu-cv-cc86"
DOCKER_REPO="robotikainspace/moon-final"
SOURCE_BRANCH="master"
SOURCE_COMMIT=`git ls-remote https://github.com/AlexeyAB/darknet.git ${SOURCE_BRANCH} | awk '{ print $1 }'`
DOCKER_TAG="darknet-$ARCH"

  echo $DOCKER_REPO
  echo $SOURCE_BRANCH
  echo $SOURCE_COMMIT
  echo $DOCKER_TAG
  echo $ARCH

if [[ "$ARCH" == *cv* ]]; then
  if [[ "$ARCH" = *cpu-cv || "$ARCH" = *cpu-noopt-cv ]]; then
    echo "building cpu-cv or cpu-noopt-cv"
    docker build \
      --build-arg CONFIG=$ARCH \
      --build-arg SOURCE_BRANCH=$SOURCE_BRANCH \
      --build-arg SOURCE_COMMIT=$SOURCE_COMMIT \
      -t $DOCKER_REPO:$DOCKER_TAG -f Dockerfile.cpu-cv .
  else
    echo "building gpu-cv"
    docker build \
      --build-arg CONFIG=$ARCH \
      --build-arg SOURCE_BRANCH=$SOURCE_BRANCH \
      --build-arg SOURCE_COMMIT=$SOURCE_COMMIT \
      -t $DOCKER_REPO:$DOCKER_TAG -f Dockerfile.gpu-cv .
  fi
 else
  if [[ "$ARCH" = *cpu || "$ARCH" = *cpu-noopt ]]; then
    echo "building cpu or cpu-noopt"
    docker build \
      --build-arg CONFIG=$ARCH \
      --build-arg SOURCE_BRANCH=$SOURCE_BRANCH \
      --build-arg SOURCE_COMMIT=$SOURCE_COMMIT \
      -t $DOCKER_REPO:$DOCKER_TAG -f Dockerfile.cpu .
  else
    echo "building gpu"
    docker build \
      --build-arg CONFIG=$ARCH \
      --build-arg SOURCE_BRANCH=$SOURCE_BRANCH \
      --build-arg SOURCE_COMMIT=$SOURCE_COMMIT \
      -t $DOCKER_REPO:$DOCKER_TAG -f Dockerfile.gpu .
  fi
fi

docker push $DOCKER_REPO:$DOCKER_TAG
