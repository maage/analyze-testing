FROM docker.io/jupyter/datascience-notebook

#USER jovyan

RUN \
    conda install --yes \
	conda-build \
    ;

RUN \
    conda skeleton pypi urllib3; \
    conda build urllib3/; \
    conda install --yes urllib3 --use-local; \
    :

RUN \
    conda skeleton pypi elasticsearch --version=1.9.0; \
    #sed -i '/urllib3/{s/^/#/}' elasticsearch/*.yaml; \
    #sed -i '/\#\!/{s/$/\nsed -i "\/urllib3\/\{s\/^\/#\/\}" setup.py elasticsearch.egg-info\/requires.txt\n/}' elasticsearch/build.sh; \
    #cat elasticsearch/build.sh; \
    #egrep -v '^#' elasticsearch/meta.yaml; \
    conda build elasticsearch/; \
    conda install --yes elasticsearch --use-local; \
    :

RUN \
    conda skeleton pypi elasticsearch-dsl; \
    conda build elasticsearch-dsl/; \
    conda install --yes elasticsearch-dsl --use-local; \
    :

RUN \
    conda skeleton pypi BitVector; \
    conda build bitvector/; \
    conda install --yes BitVector --use-local; \
    :

RUN \
    conda install --yes bokeh; \
    :

RUN \
    conda skeleton pypi colormath && \
    conda build colormath/ && \
    conda install --yes colormath --use-local && \
    :

RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends \
	software-properties-common \
    && \
    add-apt-repository -y 'deb http://www.deb-multimedia.org jessie main non-free' && \
    apt-get update && \
    apt-get install -y --force-yes \
	deb-multimedia-keyring \
    && \
    apt-get update && \
    apt-get install -y \
	ffmpeg \
    && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    :

RUN \
    conda install --yes cairo && \
    conda install -c https://conda.anaconda.org/fallen pycairo && \
    conda install -c https://conda.anaconda.org/inso pyqt5 && \
    conda config --add channels fallen && \
    conda config --add channels inso && \
    conda skeleton pypi toyplot && \
    sed -i '/run:/{s/$/\n    - cairo/};\
/^test:/{s/$/\n  requires:\n    - cairo/};\
/toyplot\.cairo/d;\
/toyplot\.qt/d;\
#/imports:/{s/$/\n    - cairo/};\
' toyplot/meta.yaml && \
    cat toyplot/meta.yaml && \
    conda build toyplot/ && \
    conda install --yes toyplot --use-local && \
    :

RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends \
	bison \
        file \
	libncurses-dev \
	libreadline-dev \
	m4 \
        mt-st \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    :

COPY ["files/gmp/*", "gmp/"]
RUN \
    conda build gmp/ && \
    conda install --yes gmp --use-local && \
    :

COPY ["files/mpfr/*", "mpfr/"]
RUN \
    conda build mpfr/ && \
    conda install --yes mpfr --use-local && \
    :

COPY ["files/mpc/*", "mpc/"]
RUN \
    conda build mpc/ && \
    conda install --yes mpc --use-local && \
    :

COPY ["files/gmpy2/*", "gmpy2/"]
RUN \
    conda build gmpy2/ && \
    conda install --yes gmpy2 --use-local && \
    :

COPY ["files/pymc/*", "pymc/"]
RUN \
    conda build pymc/ && \
    conda install --yes pymc --use-local && \
    :

