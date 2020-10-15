FROM amazonlinux:2

USER root

RUN amazon-linux-extras install -y epel && \
    yum install -y sudo  bzip2 wget curl unzip tmux tar nmap-ncat socat net-snmp procps-ng bind-utils dstat iotop jq \
    gcc gcc-c++ bison make automake autoconf gawk file \
    curl-devel expat-devel gettext-devel openssl-devel zlib-devel bzip2-devel openssl-devel libffi-devel sqlite-devel \
    libxml2-devel bison-devel libjpeg-devel libpng-devel readline-devel libxslt-devel httpd-devel enchant-devel libXpm libXpm-devel \
    freetype-devel t1lib t1lib-devel gmp-devel libicu-devel net-snmp-devel  libmemcached-devel libtidy-devel \
    nginx \
    perl-ExtUtils-MakeMaker

RUN  adduser admin && adduser appuser && groupadd develop && \
     usermod -aG develop admin && usermod -aG develop appuser

COPY ./tmpfiles.d/php-fpm.conf /etc/tmpfiles.d/php-fpm.conf
COPY ./sysctl.d/sysctl.conf /etc/sysctl.d/sysctl.conf
COPY ./sudoers.d/develop /etc/sudoers.d/develop

## confd
RUN mkdir -p /etc/confd/{conf.d,templates} && \
    wget -q "https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64" -O /usr/local/bin/confd && \
    chmod +x /usr/local/bin/confd
COPY ./start.toml /etc/confd/conf.d/
COPY ./start.tmpl /etc/confd/templates/

## entrykit
RUN  ENTRYKIT_VERSION=0.4.0 && \
     wget -qO - "https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz" | tar -xzvf - -C /usr/local/bin && \
     chmod +x /usr/local/bin/entrykit && /usr/local/bin/entrykit --symlink


ARG PHP_BUILD_CONFIGURE_OPTS=--with-pear
ARG PHP_BUILD_EXTRA_MAKE_ARGUMENTS=-j4
ARG PHP_VERSION=7.2.21
ARG PECL_INSTALL='igbinary msgpack'


#####

USER admin
COPY mysql/dot.my.cnf ~/.my.cnf

RUN git clone https://github.com/riywo/anyenv ~/.anyenv && \
    echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.bash_profile && \
    echo 'eval "$(anyenv init -)"' >> ~/.bash_profile

RUN . ~/.bash_profile && \
    yes | anyenv install --init && anyenv install pyenv && anyenv install phpenv  

RUN . ~/.bash_profile && phpenv install ${PHP_VERSION} && phpenv rehash
RUN . ~/.bash_profile && phpenv global ${PHP_VERSION} && \
    pecl install ${PECL_INSTALL}


##### 

USER appuser
COPY mysql/dot.my.cnf ~/.my.cnf

RUN git clone https://github.com/riywo/anyenv ~/.anyenv && \
    echo 'export PATH="$HOME/.anyenv/bin:$PATH"' >> ~/.bash_profile && \
    echo 'eval "$(anyenv init -)"' >> ~/.bash_profile

RUN . ~/.bash_profile && \
    yes | anyenv install --init && anyenv install pyenv && anyenv install phpenv   

RUN . ~/.bash_profile && phpenv install ${PHP_VERSION} && phpenv rehash
RUN . ~/.bash_profile && phpenv global ${PHP_VERSION} && \
    pecl install ${PECL_INSTALL}




