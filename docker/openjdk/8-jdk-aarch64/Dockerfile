# https://github.com/docker-library/openjdk/blob/b4f29ba829765552239bd18f272fcdaf09eca259/8-jdk/alpine/Dockerfile
FROM arm64v8/alpine:latest

# Default to UTF-8 file.encoding
ENV LANG zh_CN.UTF-8

# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

ARG MIRROR="http://mirrors.aliyun.com"

RUN set -x \
    && echo -e "${MIRROR}/alpine/v3.11/main\n${MIRROR}/alpine/v3.11/community" > /etc/apk/repositories \
	&& apk add --no-cache  openjdk8  maven \
    && rm -f /usr/share/java/maven-3/conf/settings.xml \
    && mkdir -p /home/admin \
	&& [ "$JAVA_HOME" = "$(docker-java-home)" ]

ADD settings.xml /usr/share/java/maven-3/conf/settings.xml
ONBUILD COPY . /home/admin
WORKDIR /home/admin
