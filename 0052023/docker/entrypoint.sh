#!/bin/bash
if [ ! -f "vendor/autoload.php" ]; then
composer install --no-progress --no-interaction
fi

php artisan migrate
php artisan config:clear
php artisan route:clear
php artisan serve --port=$PORT --host=0.0.0.0 --env=.env

exec docker-php-entrypoint "$@"