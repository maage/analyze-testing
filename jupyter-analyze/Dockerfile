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
