FROM ruby:2.7.6-bullseye

ARG GCC_URL=https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
ARG Doxygen_URL=https://www.doxygen.nl/files/doxygen-1.9.5.linux.bin.tar.gz

# Install required apt packages
RUN apt update \
    && apt install -y --no-install-recommends \
           curl make libncurses5 python3 git \
    && rm -rf /var/lib/apt/lists/*

# Install GNU Arm Toolchain
RUN curl -L ${GCC_URL} -o gcc-arm-none-eabi.tar.bz2 \
    && mkdir -p  /usr/local/gcc-arm-none-eabi \
    && tar -xf gcc-arm-none-eabi.tar.bz2 -C /usr/local/gcc-arm-none-eabi --strip-components=1 \
    && rm -rf gcc-arm-none-eabi.tar.bz2
ENV PATH $PATH:/usr/local/gcc-arm-none-eabi/bin


# Install required Ruby gem
RUN gem install shell

# Install Doxygen
RUN curl -L ${Doxygen_URL} -o doxygen.tar.gz \
    && mkdir -p  /usr/local/doxygen \
    && tar -xf doxygen.tar.gz -C /usr/local/doxygen --strip-components=1 \
    && rm -rf doxygen.tar.gz
ENV PATH $PATH:/usr/local/doxygen/bin
