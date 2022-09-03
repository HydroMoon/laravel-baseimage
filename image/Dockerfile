ARG BASE_IMAGE
FROM $BASE_IMAGE

# Install php exts
RUN apt update && apt install -y \
    libpng-dev libonig-dev \
    libxml2-dev libzip-dev \
    libjpeg-dev zip unzip \
    libssl-dev pkg-config \
    libcurl4-openssl-dev \
    libfreetype6-dev libmagickwand-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-configure pcntl --enable-pcntl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install intl pcntl gd pdo pdo_mysql bcmath opcache exif zip \
    && pecl install mongodb && pecl install redis && pecl install imagick \
    && docker-php-ext-enable mongodb redis imagick

ARG QEMU_ARCH
#ADD x86_64_qemu-${QEMU_ARCH}-static.tar.gz /usr/bin

COPY . /bd_build

RUN /bd_build/prepare.sh && \
	/bd_build/system_services.sh && \
	/bd_build/utilities.sh && \
	/bd_build/cleanup.sh

ENV DEBIAN_FRONTEND="teletype" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8"

CMD ["/sbin/my_init"]
