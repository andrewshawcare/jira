FROM alpine

EXPOSE 8080

ENV JIRA_VERSION 7.5.0
ENV JIRA_BASENAME atlassian-jira-software-${JIRA_VERSION}
ENV JIRA_INSTALLATION_PATH /${JIRA_BASENAME}-standalone
ENV JIRA_BINARY_URI https://www.atlassian.com/software/jira/downloads/binary/${JIRA_BASENAME}.tar.gz
ENV JIRA_HOME /root
ENV JAVA_HOME /usr/lib/jvm/default-jvm

RUN apk --no-cache add curl tar tini bash openjdk8

RUN curl -Ls ${JIRA_BINARY_URI} | tar -xz --no-same-owner
RUN sed -i 's/java version/openjdk version/g' "${JIRA_INSTALLATION_PATH}/bin/check-java.sh"

ENTRYPOINT ["/sbin/tini", "--"]
CMD ${JIRA_INSTALLATION_PATH}/bin/start-jira.sh -fg