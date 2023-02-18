FROM php:8.2

ARG user
ARG uid

# Set working directory
WORKDIR /var/www/html

# Install Laravel framework system requirements (https://laravel.com/docs/8.x/deployment#optimizing-configuration-loading)
RUN apk add oniguruma-dev libxml2-dev
RUN apt update && apt install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    libzip-dev

# Clear cache
RUN apt clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl bcmath gd


RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-install gd  oniguruma-dev

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# # # Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-interaction --optimize-autoloader --no-dev

RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# Change current user to www
USER $user

# Copy existing application directory contents
COPY . /var/www/html

# # Copy existing application directory permissions
# COPY --chown=www:www . /var/www

# Optimizing Configuration loading
#RUN php artisan config:cache
# Optimizing Route loading
#RUN php artisan route:cache
# Optimizing View loading
#RUN php artisan view:cache

# Expose port 9000 and start php-fpm server
EXPOSE 8000

RUN php artisan serve
# CMD ["php-fpm"]
