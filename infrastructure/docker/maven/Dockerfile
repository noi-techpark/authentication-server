FROM maven:3-openjdk-11

ARG JENKINS_GROUP_ID=1000
ARG JENKINS_USER_ID=1000

RUN addgroup --gid $JENKINS_GROUP_ID jenkins
RUN adduser --disabled-login --uid $JENKINS_USER_ID --ingroup jenkins jenkins

USER jenkins

RUN mkdir -p /tmp/m2
ENV MAVEN_CONFIG=/tmp/m2
