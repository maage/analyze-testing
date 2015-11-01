./configure --prefix=$PREFIX \
    --with-gmp=$PREFIX \
    --with-mpfr=$PREFIX \
    --enable-silent-rules \
    --disable-dependency-tracking \

make -j 4
make check
make install
