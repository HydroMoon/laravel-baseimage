ARG BASE_IMAGE
FROM $BASE_IMAGE

# Install latest security patches
RUN echo "deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware" > /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y

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
    && docker-php-ext-install mysqli intl pcntl gd pdo pdo_mysql bcmath opcache exif zip \
    && pecl install mongodb && pecl install redis && pecl install imagick \
    && docker-php-ext-enable mongodb redis imagick

ARG QEMU_ARCH
#ADD x86_64_qemu-${QEMU_ARCH}-static.tar.gz /usr/bin

COPY . /bd_build

RUN /bd_build/prepare.sh && \
	/bd_build/system_services.sh && \
	/bd_build/utilities.sh && \
	/bd_build/cleanup.sh

ENV DEBIAN_FRONTEND="teletype"

CMD ["/sbin/my_init"]
