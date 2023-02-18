FROM php:8.2.1-fpm

ARG user
ARG uid

# Set working directory
WORKDIR /var/www/html

# Install Laravel framework system requirements (https://laravel.com/docs/8.x/deployment#optimizing-configuration-loading)
RUN apt update && apt install -y \
    git \
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

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# # Install extensions
RUN docker-php-ext-install pdo_mysql zip exif pcntl bcmath gd

# # # Download installer
# RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php

# # verify that the downloaded installer matches the SHA-384 hash for the latest installer
# RUN HASH=`curl -sS https://composer.github.io/installer.sig`

# # verify the obtained value
# RUN echo $HASH

# # verify that the installation script is safe to run
# RUN php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

# # install composer
# RUN php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN useradd -G www-data,root -u $uid -d /home/${user} ${user}
RUN mkdir -p /home/${user}/.composer && \
    chown -R $user:${user} /home/${user}

# Copy existing application directory contents
COPY . /var/www/html

# Copy existing application directory permissions
COPY --chown=${user}:${user} . /var/www/html

# Change current user to user
USER ${user}

# Expose port 8000 and start php server
EXPOSE 9000

CMD ["php-fpm"]