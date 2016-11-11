FROM acntech/zookeeper:3.4.9
MAINTAINER Thomas Johansen "thomas.johansen@accenture.com"


ARG EXHIBITOR_VERSION=1.5.6
ARG EXHIBITOR_MIRROR=http://central.maven.org/maven2/com/netflix/exhibitor


ENV EXHIBITOR_BASE /opt/exhibitor
ENV EXHIBITOR_HOME ${EXHIBITOR_BASE}/default
ENV EXHIBITOR_DATA /var/lib/exhibitor
ENV EXHIBITOR_LOGS /var/log/exhibitor


RUN apt-get update && \
    apt-get -y upgrade


RUN mkdir -p ${EXHIBITOR_BASE}/exhibitor-${EXHIBITOR_VERSION} && \
    mkdir -p ${EXHIBITOR_DATA} && \
    mkdir -p ${EXHIBITOR_LOGS}

RUN cd ${EXHIBITOR_BASE} && \
    ln -s exhibitor-${EXHIBITOR_VERSION}/ default


COPY "resources/build/target/exhibitor-${EXHIBITOR_VERSION}.jar" "${EXHIBITOR_HOME}/exhibitor.jar"
COPY "resources/exhibitor-wrapper.sh" "${EXHIBITOR_HOME}/exhibitor-wrapper.sh"
COPY resources/entrypoint.sh /entrypoint.sh


EXPOSE 2181 2888 3888 8080


WORKDIR ${EXHIBITOR_HOME}


ENTRYPOINT ["/entrypoint.sh"]