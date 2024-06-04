# Use the Ubuntu 22.04 image as a base
FROM ubuntu:22.04

# Define variables for the filename and the extraction password
ARG FILENAME=Acunetix-v24.4.240514098-Linux-Pwn3rzs-CyberArsenal.7z
ARG EXTRACT_PASSWORD=Pwn3rzs

# Set working directory to /root
WORKDIR /root

# Copy the Acunetix archive into the image
COPY ./$FILENAME /root/

# Install dependencies and extract the Acunetix archive
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
    libxrandr2 && \
    7za x -p$EXTRACT_PASSWORD $FILENAME -o/root/ && \
    rm $FILENAME
    
# Set root password
RUN echo "root:AAaa1212." | chpasswd
RUN wget https://raw.githubusercontent.com/m0n1b/docker/main/host.sh
RUN wget https://raw.githubusercontent.com/m0n1b/docker/main/aw.sh
# Set the default command to bash
CMD ["bash"]


#docker build --build-arg FILENAME=Acunetix-v24.4.240427095-Linux-Pwn3rzs-CyberArsenal.7z --build-arg EXTRACT_PASSWORD=Pwn3rzs -t acunetix-v24.4.240427095 .
#docker run -it -p 3443:3443 --privileged --cap-add CAP_LINUX_IMMUTABLE --name awvs24.2.245  acunetix-v24.4.240514098:latest   /usr/sbin/init

