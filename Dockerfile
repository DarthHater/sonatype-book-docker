# Dockerfile to build Sonatype book projects

FROM ubuntu
MAINTAINER Jeffry Hesse <jeffryxtron@gmail.com>

# Make it easy to change versions
ENV JAVA_VERSION_MAJOR 8
ENV JAVA_VERSION_MINOR 101
ENV JAVA_VERSION_BUILD 13
ENV GROOVY_MAJOR_VERSION 2
ENV GROOVY_MINOR_VERSION 4
ENV GROOVY_BUILD_VERSION 3

# Install git and necessary build tools
RUN apt-get update -y && \
	apt-get install -y git && \
	apt-get install -y asciidoc && \
	apt-get install -y imagemagick && \
	apt-get install -y wget && \
	apt-get install -y curl && \
	apt-get install -y unzip

# Install JDK
RUN cd /tmp && \
	curl --fail --silent --location --retry 3 \
	--header "Cookie: oraclelicense=accept-securebackup-cookie; " \
	http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
	| gunzip \
	| tar -x && \
	mv jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /jdk && \
	rm -f jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz

# Install Groovy
RUN cd /tmp && \
	wget https://dl.bintray.com/groovy/maven/groovy-binary-${GROOVY_MAJOR_VERSION}.${GROOVY_MINOR_VERSION}.${GROOVY_BUILD_VERSION}.zip && \
	unzip groovy-binary-${GROOVY_MAJOR_VERSION}.${GROOVY_MINOR_VERSION}.${GROOVY_BUILD_VERSION}.zip && \
	mv groovy-${GROOVY_MAJOR_VERSION}.${GROOVY_MINOR_VERSION}.${GROOVY_BUILD_VERSION} /groovy && \
	rm groovy-binary-${GROOVY_MAJOR_VERSION}.${GROOVY_MINOR_VERSION}.${GROOVY_BUILD_VERSION}.zip

ENV JAVA_HOME /jdk
ENV GROOVY_HOME /groovy
ENV PATH $GROOVY_HOME/bin/:$PATH