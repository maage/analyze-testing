FROM fedora23:latest

RUN \
    dnf -y install \
	'perl(Search::Elasticsearch)' \
    && \
    :

RUN \
    pip3 install elasticsearch; \
    pip3 install elasticsearch-dsl; \
    :
