FROM alpine

RUN apk --update add curl ca-certificates tar && \
    curl -Ls https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk > /tmp/glibc-2.23-r3.apk && \
    apk add --allow-untrusted /tmp/glibc-2.23-r3.apk

ENV JAVA_VERSION_MAJOR 8
ENV JAVA_VERSION_MINOR 112
ENV JAVA_VERSION_BUILD 15
ENV JAVA_PACKAGE jre

RUN mkdir /opt && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie"\
    http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
    | tar -xzf - -C /opt &&\
    ln -s /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jre

ENV JAVA_HOME /opt/jre
ENV PATH ${PATH}:${JAVA_HOME}/bin