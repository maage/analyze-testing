#!/bin/bash

if [ `uname` == Darwin ]; then
    export CFLAGS="-arch x86_64"
    export FFLAGS="-static -ff2c -arch x86_64"
    export LDFLAGS="-Wall -undefined dynamic_lookup -bundle -arch x86_64"
    cp $PREFIX/lib/libgfortran*.*a .
    cp $PREFIX/lib/libgcc_s* .
    cp $PREFIX/lib/libquadmath* .
    export LDFLAGS="-Wl,-search_paths_first -L$(pwd) $LDFLAGS"
fi

locale
iconv -c -t ascii pymc/flib.f > pymc/flib.f- && mv pymc/flib.f- pymc/flib.f
$PYTHON setup.py install --prefix=$PREFIX
