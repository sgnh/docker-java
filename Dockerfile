FROM alpine

RUN apk --update add curl ca-certificates tar && \
    curl -Ls https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-2.25-r0.apk > /tmp/glibc-2.25-r0.apk && \
    apk add --allow-untrusted /tmp/glibc-2.25-r0.apk

ENV JAVA_VERSION_MAJOR 8
ENV JAVA_VERSION_MINOR 141
ENV JAVA_VERSION_BUILD 15
ENV JAVA_PACKAGE jre
ENV JAVA_ID 336fa29ff2bb4ef291e347e091f7f4a7

RUN mkdir /opt && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie"\
    http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_ID}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
    | tar -xzf - -C /opt &&\
    ln -s /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jre

ENV JAVA_HOME /opt/jre
ENV PATH ${PATH}:${JAVA_HOME}/bin
