FROM openjdk:8-jre-alpine

COPY lib/cassandra-reaper.jar /opt/cassandra-reaper.jar

RUN mkdir /etc/cassandra-reaper && \
    chgrp 0 /etc/cassandra-reaper

USER 1001

ENTRYPOINT ["java", "-jar", "/opt/cassandra-reaper.jar", "server", "/etc/cassandra-reaper/cassandra-reaper.yaml"]
