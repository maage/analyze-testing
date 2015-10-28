#FROM Fedora-Docker-Base-23_Beta-20150915.x86_64:latest
# docker tag e77ecc27a219 maage/fedora-23-beta-20150915:latest

FROM maage/fedora-23-beta-20150915

RUN \
    sed -i '/deltarpm=/d;/^\[main\]/{s/$/\ndeltarpm=0/}' /etc/dnf/dnf.conf && \
    dnf -y update fedora-repos && \
    dnf -y update && \
    dnf clean all; \
    rm -rf /var/cache/*; \
    :
