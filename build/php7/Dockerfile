FROM php:7.3.19-fpm

RUN usermod -u 1000 www-data
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# ADD conf/sources.list    /etc/apt/sources.list
# 安装modules
RUN apt-get update && apt-get install -y \
        #libxml2-dev \
        libfreetype6-dev \
        libmemcached-dev \
        libmcrypt-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        unzip \
        && docker-php-ext-install -j$(nproc) iconv mcrypt \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install -j$(nproc) gd \
        && docker-php-ext-install mysqli \
        && docker-php-ext-install pdo_mysql \
        && docker-php-ext-install opcache \
        && docker-php-ext-install zip \
        && docker-php-ext-install mysql \
        && pecl install redis \
        && docker-php-ext-enable redis
ADD conf/php.ini    /usr/local/etc/php/php.ini
ADD conf/php-fpm.conf    /usr/local/etc/php-fpm.conf




# 安装 Xdebug
RUN curl -fsSL 'https://xdebug.org/files/xdebug-2.4.0.tgz' -o xdebug.tar.gz \
    && mkdir -p xdebug \
    && tar -xf xdebug.tar.gz -C xdebug --strip-components=1 \
    && rm xdebug.tar.gz \
    && ( \
    cd xdebug \
    && phpize \
    && ./configure --enable-xdebug \
    && make -j$(nproc) \
    && make install \
    ) \
    && rm -r xdebug \
    && docker-php-ext-enable xdebug
#配置 debugger
RUN echo "xdebug.enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    echo "xdebug.remote_host=192.168.99.100" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# 安装 phpcomposer
RUN php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" ;php composer-setup.php; mv composer.phar /usr/local/bin/composer; composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/;

WORKDIR /data1

EXPOSE 9000
VOLUME ["/data1"]
