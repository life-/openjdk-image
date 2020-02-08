FROM alpine:latest

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
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk/jre
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin
# ENV PS1 "\n\e[1;37m[\e[m\e[1;32m\u\e[m\e[1;33m@\e[m\e[1;35m\h\e[m\e[m:\e[4m$(pwd)\e[m\e[1;37m]\e[m\e[1;36m\e[m\n\\$ "
# ENV PS1 "\n\e[1;37m[\e[m\e[1;32m\u\e[m\e[1;33m@\e[m\e[1;35m\H\e[m \e[4m`pwd`\e[m\e[1;37m]\e[m\e[1;36m\e[m\n\$"

ARG JAVA_ALPINE_VERSION="8.232.09-r0"
ARG SUPERVISORD_ALPINE_VERSION="1.0"
ARG MIRROR="http://mirrors.aliyun.com"

RUN set -x \
    && echo -e "${MIRROR}/alpine/v3.11/main\n${MIRROR}/alpine/v3.11/community" > /etc/apk/repositories \
	&& apk add --no-cache openjdk8-jre \
    && mkdir -p /home/admin \
	&& [ "$JAVA_HOME" = "$(docker-java-home)" ]

WORKDIR /home/admin
