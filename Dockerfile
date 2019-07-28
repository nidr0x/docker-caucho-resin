FROM registry.access.redhat.com/ubi8/ubi-minimal:8.0 as builder

RUN mkdir -p /var/resin/webapp-jars && \
    cd /var/resin/webapp-jars && \
    microdnf install --nodocs unzip && \
    microdnf clean all && \
    curl -LO http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.38.zip && \
    unzip -j mysql-connector-java-5.1.38.zip mysql-connector-java-5.1.38/mysql-connector-java-5.1.38-bin.jar

FROM registry.access.redhat.com/ubi8/ubi-minimal:8.0
LABEL MAINTAINER "Carlos <nidr0x@gmail.com>"

ENV USER=resin
ENV GROUP=resin
ENV RESIN_VERSION=4.0.62

RUN microdnf install --nodocs java-1.8.0-openjdk-headless openssl-devel glibc-devel shadow-utils && \
    groupadd -g 1001 ${GROUP} && \
    useradd -r -u 1001 -g ${USER} ${GROUP}

RUN curl -O http://caucho.com/download/rpm-6.8/${RESIN_VERSION}/x86_64/resin-${RESIN_VERSION}-1.x86_64.rpm && \
    rpm -i resin-${RESIN_VERSION}-1.x86_64.rpm && \
    rm resin-${RESIN_VERSION}-1.x86_64.rpm && \
    mkdir -p /var/resin/webapp-jars && \
    chown -R ${USER}:${GROUP} /usr/local/share/resin-${RESIN_VERSION} && \
    chown -R ${USER}:${GROUP} /var/resin && \
    sed -i -e 's/setuid_user : resin/setuid_user : ${USER}/g' /etc/resin/resin.properties && \
    sed -i -e 's/setuid_group : resin/setuid_group : ${GROUP}/g' /etc/resin/resin.properties

ENV RESIN_HOME=/usr/local/share/${RESIN_VERSION}

COPY --from=builder --chown=1001 /var/resin/webapp-jars /var/resin/webapp-jars

USER 1001

ENTRYPOINT ["/usr/local/share/resin/bin/resinctl"]
CMD ["console"]
