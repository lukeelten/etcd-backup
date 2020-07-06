FROM registry.redhat.io/openshift4/ose-cli:v4.4

COPY backup.sh /usr/local/bin

ENTRYPOINT [ 'backup.sh' ]
