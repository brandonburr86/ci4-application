FROM php:8.3-fpm-alpine

# --- system deps ------------------------------------------------------------
RUN apk add --no-cache \
      bash icu-data-full icu-dev libzip-dev oniguruma-dev \
      $PHPIZE_DEPS \
      && docker-php-ext-install intl pdo_mysql mysqli opcache mbstring bcmath

# --- CodeIgniter & permissions ---------------------------------------------
WORKDIR /var/www/html
COPY --chown=www-data:www-data src/ .

# switch to non-root for safety
USER www-data

CMD ["php-fpm"]
