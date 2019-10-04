FROM amazonlinux:2

USER root

RUN amazon-linux-extras install -y epel && \
    yum install -y sudo tmux tar bzip2 wget curl wget file unzip nmap-ncat socat net-snmp procps-ng bind-utils dstat iotop jq \
    gcc gcc-c++ bison make automake autoconf \
    curl-devel expat-devel gettext-devel openssl-devel zlib-devel \
    libxml2-devel bison-devel libjpeg-devel libpng-devel readline-devel libxslt-devel httpd-devel enchant-devel libXpm libXpm-devel \
    libtidy-devel \
    freetype-devel t1lib t1lib-devel gmp-devel libicu-devel net-snmp-devel bzip2-devel libmemcached-devel \
    perl-ExtUtils-MakeMaker

RUN  adduser admin && adduser appuser && groupadd develop && \
     usermod -aG develop admin && usermod -aG develop appuser 

COPY ./tmpfiles.d/php-fpm.conf /etc/tmpfiles.d/php-fpm.conf
COPY ./sysctl.d/sysctl.conf /etc/sysctl.d/sysctl.conf
COPY ./sudoers.d/develop /etc/sudoers.d/develop

ARG PHP_VERSION=7.2.21
ARG PECL_INSTALL=igbinary

USER appuser
RUN git clone https://github.com/riywo/anyenv ~/.anyenv && \
    echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.bash_profile && \
    echo 'eval "$(anyenv init -)"' >> ~/.bash_profile

RUN . ~/.bash_profile && \
    yes | anyenv install --init && anyenv install phpenv

RUN . ~/.bash_profile && phpenv install ${PHP_VERSION} && phpenv rehash
RUN phpenv global ${PHP_VERSION} && \
    pecl install ${PECL_INSTALL}

