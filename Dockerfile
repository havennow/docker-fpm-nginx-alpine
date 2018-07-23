FROM alpine:3.8
MAINTAINER Guilherme <havennow@gmail.com>

# Environment variables
ENV BUILD_PACKAGES="wget tar make gcc g++ zlib-dev libressl-dev pcre-dev fcgi-dev jpeg-dev libmcrypt-dev bzip2-dev curl-dev libxslt-dev  perl-dev file acl-dev libedit-dev icu-dev icu-libs" \
    ESSENTIAL_PACKAGES="nginx libressl pcre zlib supervisor sed re2c m4 ca-certificates py-pip npm" \
    UTILITY_PACKAGES="bash nano"

# Environments
ENV TIMEZONE            America/Sao_Paulo
ENV PHP_MEMORY_LIMIT    512M
ENV MAX_UPLOAD          50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST        10M


# Configure essential and utility packages
RUN apk update && \
    apk --no-cache --progress add $ESSENTIAL_PACKAGES $UTILITY_PACKAGES && \
    mkdir -p /run/nginx/ && \
    chmod ugo+w /run/nginx/ && \
    rm -f /etc/nginx/nginx.conf && \
    mkdir -p /etc/nginx/conf.d && \
    mkdir -p /etc/nginx/ssl/ && \
    mkdir -p /var/www/html/ && \
    chmod -R 775 /var/www/ && \
    chown -R nginx:nginx /var/www/ && \
    apk --progress add curl && \
    pip install --upgrade pip && \
    pip install supervisor-stdout

# Let's roll
RUN	echo "http://dl-cdn.alpinelinux.org/alpine/v3.8/main" >> /etc/apk/repositories
RUN apk update && \
	apk upgrade && \
	apk add --update tzdata && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone && \
	apk add --update \
	    php7-cli \
	    php7-common \
		php7-mcrypt \
		php7-soap \
		php7-openssl \
		php7-gmp \
		php7-pdo_odbc \
		php7-json \
		php7-dom \
		php7-pdo \
		php7-zip \
		php7-mysqli \
		php7-sqlite3 \
		php7-pdo_pgsql \
		php7-bcmath \
		php7-gd \
		php7-odbc \
		php7-pdo_mysql \
		php7-pdo_sqlite \
		php7-gettext \
		php7-xmlreader \
		php7-xmlrpc \
		php7-bz2 \
		php7-iconv \
		php7-pdo_dblib \
		php7-curl \
		php7-ctype \
		php7-phar \
		php7-mbstring \
		php7-tokenizer \
		php7-xmlwriter \
		php7-session \
		php7-fpm

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy manifest folder
COPY ./manifest/ /
# COPY ./src/ /var/www/html

# Setup Volume
VOLUME ["/var/www/html"]
VOLUME ["/etc/nginx/ssl"]
VOLUME ["/var/log/nginx"]

# Expose Ports
EXPOSE 443 80

ENTRYPOINT ["/entrypoint.sh"]
