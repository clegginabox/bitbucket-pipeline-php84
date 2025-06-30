FROM php:8.4-cli

# Install system dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    zip \
    curl \
    libzip-dev \
    libonig-dev \
    libxml2-dev \
    default-mysql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy Composer from official image
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy install-php-extensions from mlocati
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

# Install PHP extensions declaratively
RUN install-php-extensions \
    mysqli \
    redis \
    pdo_mysql \
    fileinfo
