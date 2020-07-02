FROM php:7.4.7-fpm
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install -y \
        --no-install-recommends libfreetype6-dev libjpeg62-turbo-dev libpng-dev curl \
        && rm -r /var/lib/apt/lists/* \
        && docker-php-ext-configure gd \
        && docker-php-ext-install -j$(nproc) gd opcache pdo_mysql gettext sockets
RUN pecl install redis \
    && pecl install swoole \
    && docker-php-ext-enable redis swoole
ENV COMPOSER_HOME /root/composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV PATH $COMPOSER_HOME/vendor/bin:$PATH

# 安装 Xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN apt-get clean \ 
    && rm -rf /var/lib/apt/lists/* 

#ADD conf/php.ini    /usr/local/etc/php/php.ini
#ADD conf/php-fpm.conf    /usr/local/etc/php-fpm.conf

WORKDIR /data1

EXPOSE 9000 19900
VOLUME ["/data1"]
