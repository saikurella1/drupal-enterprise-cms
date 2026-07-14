FROM php:8.2-apache

# Install required system packages
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    libpq-dev \
    libzip-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        gd \
        pdo \
        pdo_pgsql \
        pgsql \
        zip \
        opcache

# Enable Apache rewrite
RUN a2enmod rewrite

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Copy project
COPY . .
RUN mkdir -p /var/www/html/web/sites/default/files \
    && mkdir -p /var/www/html/web/sites/default/files/translations \
    && chown -R www-data:www-data /var/www/html/web/sites/default \
    && chmod -R 775 /var/www/html/web/sites/default

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Configure Apache document root
ENV APACHE_DOCUMENT_ROOT=/var/www/html/web

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' \
    /etc/apache2/sites-available/*.conf \
    /etc/apache2/apache2.conf

EXPOSE 80

# Copy startup script
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Make it executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Start using the entrypoint script
CMD ["/usr/local/bin/docker-entrypoint.sh"]
