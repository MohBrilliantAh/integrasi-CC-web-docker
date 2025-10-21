# Gunakan base image PHP dengan ekstensi yang dibutuhkan Laravel
FROM php:8.2-cli

# Set working directory
WORKDIR /var/www/html

# Install dependencies sistem dan ekstensi PHP
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy semua file project ke dalam container
COPY . .

# Expose port 8000 (port Laravel artisan serve)
EXPOSE 8000

# Jalankan Laravel menggunakan artisan serve
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
