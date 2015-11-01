#!/bin/sh

set -e

chmod +x configure

case "$(uname)" in
    Darwin) ./configure --prefix=$PREFIX --enable-fat --enable-cxx ;;
    *)./configure --prefix=$PREFIX --enable-fat ;;
esac

make -j 4
make check
make install
