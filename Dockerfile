FROM openjdk:8u131-jre-alpine

# Mirth version compatible with jre 1.8
# Check compatibility matrix http://www.mirthcorp.com/community/wiki/display/mirth/System+Requirements
ENV MIRTH_VERSION 3.8.0.b2464
ENV MIRTH_HOME /opt/mirth-connect

# Mirth Connect user (mirth, uid = 1000)
# Ensure to use the same uid if you mount a bind volume from the host
RUN adduser -S -u 1000 mirth

# Mirth Connect installation
# Download URL: http://downloads.mirthcorp.com/connect/3.4.2.8129.b167/mirthconnect-3.4.2.8129.b167-unix.tar.gz
RUN wget http://downloads.mirthcorp.com/connect/$MIRTH_VERSION/mirthconnect-$MIRTH_VERSION-unix.tar.gz -P /tmp && \
    mkdir -p /opt && tar -xzf /tmp/mirthconnect-$MIRTH_VERSION-unix.tar.gz -C /opt && \
    mv /opt/Mirth\ Connect /opt/mirth-connect && \
    chown -R mirth /opt/mirth-connect && \
    rm -fr /tmp/*

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8080 8443
USER mirth
WORKDIR $MIRTH_HOME

CMD ["java", "-jar", "mirth-server-launcher.jar"]
