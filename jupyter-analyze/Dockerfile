FROM docker.io/jupyter/datascience-notebook

#USER jovyan

RUN \
    conda install --yes \
	conda-build \
    ;

#RUN conda install --yes -c https://conda.anaconda.org/wakari urllib3
#RUN conda install --yes -c https://conda.anaconda.org/indico urllib3

RUN \
    conda skeleton pypi elasticsearch --version=1.9.0; \
    sed -i '/urllib3/{s/^/#/}' elasticsearch/*.yaml; \
    sed -i '/\#\!/{s/$/\nsed -i "\/urllib3\/\{s\/^\/#\/\}" setup.py elasticsearch.egg-info\/requires.txt\n/}' elasticsearch/build.sh; \
    cat elasticsearch/build.sh; \
    egrep -v '^#' elasticsearch/meta.yaml; \
    conda build elasticsearch/; \
    conda install elasticsearch --use-local; \
    :

RUN \
    conda skeleton pypi elasticsearch-dsl; \
    conda build elasticsearch-dsl/; \
    conda install elasticsearch-dsl --use-local; \
    

