# Gunakan Node LTS terbaru (misal Node 20 dengan Debian Bullseye)
FROM node:20-bullseye

LABEL MAINTAINER="me@monlor.com"
LABEL VERSION="1.0.1"
LABEL ORIGINAL_AUTHOR="Scavin <scavin@appinn.com>"

# Set locale
ENV LANG C.UTF-8
WORKDIR /ws-scrcpy

# Install dependencies terbaru
RUN apt update && \
    apt install -y --no-install-recommends \
    android-tools-adb \
    netcat \
    git \
    wget \
    unzip \
    && npm install -g node-gyp \
    && rm -rf /var/lib/apt/lists/*

# Clone repository ws-scrcpy terbaru
RUN git clone https://github.com/NetrisTV/ws-scrcpy.git . && \
    npm install && \
    npm run dist

# Jika mau, bisa juga pakai platform-tools terbaru langsung dari Google
# RUN wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip && \
#     unzip platform-tools-latest-linux.zip && \
#     mv ./platform-tools/adb /usr/bin/adb

EXPOSE 8000

# Copy entrypoint
COPY --chmod=755 entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
