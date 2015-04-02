#!/bin/bash

type patch  >/dev/null 2>&1 || { echo >&2 "I require patch but it's not installed. Aborting."; exit 1; }

for i in "$@"
do
    case $i in
        --prefix=*)
            PREFIX="${i#*=}"
            shift
        ;;
        --jobs=*)
            JOBS="${i#*=}"
            shift
        ;;
        *)
            shift
        ;;
    esac
done

wget http://www.haskell.org/ghc/dist/7.8.4/ghc-7.8.4-src.tar.xz
tar xf ghc-7.8.4-src.tar.xz

cd ghc-7.8.4

patch -p1 < ../D69_simplified.diff

./configure --prefix="$PREFIX"
make -j"$JOBS"
