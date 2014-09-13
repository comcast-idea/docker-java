FROM phusion/baseimage:0.9.13
MAINTAINER Sergey Matochkin <sergey@matochkin.com>

ENV DEBIAN_FRONTEND noninteractive

######### Set locale to UTF-8 ###################
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN echo LANG=\"en_US.UTF-8\" > /etc/default/locale

# Install Java
RUN add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    apt-get clean && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN sed -e 's%^\(securerandom.source\)=.*%\1=file:/dev/./urandom%' \
        -i $JAVA_HOME/jre/lib/security/java.security
