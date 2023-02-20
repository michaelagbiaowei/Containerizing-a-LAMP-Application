FROM php:8.2.1

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

# Download Composer Installer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# # Install extensions
RUN docker-php-ext-install pdo_mysql zip exif pcntl bcmath gd


#RUN useradd -g www-data,root -u $uid -d /home/${user} ${user}
RUN mkdir -p /home/${user}/.composer && \
    chown -R $user:${user} /home/${user}

# Copy existing application directory contents
COPY . /var/www/html

# Copy existing application directory permissions
COPY --chown=${user}:${user} . /var/www/html

# Change current user to user
USER ${user}

# Expose port 8000 and start php server
EXPOSE 8000
