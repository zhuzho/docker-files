FROM openjdk:8

ENV SONAR_VERSION=7.4 \
    SONARQUBE_HOME=/opt/sonarqube \
    # Database configuration
    # Defaults to using H2
    # DEPRECATED. Use -v sonar.jdbc.username=... instead
    # Drop these in the next release, also in the run script
    SONARQUBE_JDBC_USERNAME=sonar \
    SONARQUBE_JDBC_PASSWORD=sonar \
    SONARQUBE_JDBC_URL=

# Http port
EXPOSE 9000

RUN groupadd -r sonarqube && useradd -r -g sonarqube sonarqube

# grab gosu for easy step-down from root
RUN set -x \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.10/gosu-$(dpkg --print-architecture)" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/1.10/gosu-$(dpkg --print-architecture).asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && (gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
        || gpg --batch --keyserver ipv4.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4) \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true
    


ADD sonarqube-$SONAR_VERSION.zip /opt

RUN  set -x \
    && cd /opt \
    && ls -al \
    && unzip sonarqube-7.4.zip \
    && mv sonarqube-$SONAR_VERSION sonarqube \
    && chown -R sonarqube:sonarqube sonarqube \
    && rm sonarqube-$SONAR_VERSION.zip* \
    && rm -rf $SONARQUBE_HOME/bin/*

ADD sonar-gitlab-plugin-4.0.0.jar sonar-l10n-zh-plugin-1.24.jar sonar-auth-gitlab-plugin-1.2.2.jar /opt/sonarqube/extensions/plugins/

VOLUME "$SONARQUBE_HOME/data"

WORKDIR $SONARQUBE_HOME


COPY run.sh $SONARQUBE_HOME/bin/
RUN chown sonarqube:sonarqube $SONARQUBE_HOME/bin/run.sh \
    && chmod +x $SONARQUBE_HOME/bin/run.sh
# RUN ls -al /opt/sonarqube/bin

USER sonarqube

ENTRYPOINT ["./bin/run.sh"]


# docker build -t quancheng/sonar:v2 -f Dockerfile .