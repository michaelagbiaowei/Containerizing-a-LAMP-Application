FROM php:8.2-fpm-alpine

# Install image requirements
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# install php extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install compposer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Create user to run php cli commands
RUN WWWGROUPadd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# Create working dir for lamp app
WORKDIR /var/www/html

USER $user