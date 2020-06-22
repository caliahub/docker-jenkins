FROM caliahub/jre:1.8.0_101

MAINTAINER Calia "cnboycalia@gmail.com"

ENV JENKINS_HOME /home/jenkins
ENV JENKINS_UC https://updates.jenkins.io
ENV JENKINS_UC_EXPERIMENTAL=https://updates.jenkins.io/experimental
ENV JENKINS_INCREMENTALS_REPO_MIRROR=https://repo.jenkins-ci.org/incrementals
ENV COPY_REFERENCE_FILE_LOG /home/jenkins/copy_reference_file.log

RUN apk add --no-cache \
  bash \
  coreutils \
  curl \
  git \
  git-lfs \
  openssh-client \
  tini \
  ttf-dejavu \
  tzdata \
  unzip \
  && mkdir -p /home/jenkins /usr/share/jenkins/ref/init.groovy.d \
  && curl -fsSL https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/2.222.1/jenkins-war-2.222.1.war -o /usr/share/jenkins/jenkins.war 

COPY jenkins-support /usr/local/bin/jenkins-support
COPY jenkins.sh /usr/local/bin/jenkins.sh
COPY tini-shim.sh /bin/tini
COPY plugins.sh /usr/local/bin/plugins.sh
COPY install-plugins.sh /usr/local/bin/install-plugins.sh

VOLUME /home/jenkins

WORKDIR /home/jenkins

EXPOSE 8080 50000

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]
