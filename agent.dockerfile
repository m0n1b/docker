FROM ubuntu:22.04

WORKDIR /root
COPY ./agent_linux /root/agent_linux
COPY ./config.env /root/config.env

RUN apt-get update && apt-get install -y \
    libxcomposite1 \
    libatk-bridge2.0-0 \
    libcairo2 \
    libnss3 \
    libxfixes3 \
    libcups2 \
    libxkbcommon0 \
    libxdamage1 \
    libpango-1.0-0 \
    libgbm1 \
    libasound2 \
    bzip2 \
    sudo \
    vim \
    wget \
    p7zip-full \
    libxrandr2 \
    lsb-release \
    curl \
    gnupg && \
    \
    curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg && \
    \
    echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" \
    | tee /etc/apt/sources.list.d/cloudflare-client.list && \
    \
    apt-get update && apt-get install -y cloudflare-warp && \
    \
    echo "root:AAaa1212." | chpasswd && \
    \
    chmod +x /root/agent_linux && \
    \
    apt-get clean && rm -rf /var/lib/apt/lists/*
#docker build -t acunetix-warp-systemd 
#docker run -it -p 34413:34413  --privileged --cap-add CAP_LINUX_IMMUTABLE --name agent acunetix-warp-systemd:latest   /bin/bash -c "/usr/sbin/init"
#warp-svc star  and  run 
