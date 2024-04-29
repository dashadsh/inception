FROM alpine:3.18

ARG PHP_VERSION=82 \
    DB_NAME \  // DELETE?? no! for wp-config create
    DB_USER \ // DELETE?? add db name??
    DB_PASS // DELETE??

ENV DB_NAME=${DB_NAME}// WHY 
ENV DB_USER=${DB_USER}// WHY 
ENV DB_PASS=${DB_PASS}// WHY 

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
      php${PHP_VERSION} \
      php${PHP_VERSION}-fpm \
      php${PHP_VERSION}-mysqli \
      php${PHP_VERSION}-json \
      php${PHP_VERSION}-curl \
      php${PHP_VERSION}-dom \
      php${PHP_VERSION}-exif \
      php${PHP_VERSION}-fileinfo \
      php${PHP_VERSION}-mbstring \
      php${PHP_VERSION}-openssl \
      php${PHP_VERSION}-xml \
      php${PHP_VERSION}-zip \
#      php${PHP_VERSION}-redis \  // DELETE??
      wget \
      unzip && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
      /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*

WORKDIR /var/www

RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    mv wordpress/* . && \
    rm -rf wordpress latest.zip

COPY ./requirements/wordpress/conf/wp-config-create.sh .
EXPOSE 9000 // ADD??

RUN sh wp-config-create.sh && rm wp-config-create.sh && \
    chmod -R 0777 wp-content/

CMD ["php-fpm82", "-F"]
#CMD ["/usr/sbin/php-fpm8", "-F"]