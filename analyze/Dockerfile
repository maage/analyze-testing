FROM fedora23:latest

RUN \
    dnf -y install \
	python3-scikit-learn \
	'perl(Search::Elasticsearch)' \
	gcc \
	python3-devel \
	libsodium-devel \
	zeromq-devel \
	czmq-devel \
	redhat-rpm-config \
    ; \
    :

RUN \
    pip3 install elasticsearch; \
    pip3 install elasticsearch-dsl; \
    :

RUN \
    dnf copr enable nalimilan/julia; \
    dnf -y install \
	julia \
    ; \
    :

RUN \
    dnf copr enable petersen/stack; \
    dnf -y install \
	stack \
    ; \
    stack install ihaskell-0.6.5.0; \
    :

RUN \
    pip3 install jupyter; \
    #dnf -y update; dnf clean all; \
    :

EXPOSE 8888
