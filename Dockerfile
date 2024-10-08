FROM nvidia/cuda:12.3.0-devel-ubuntu22.04

# Set the working directory in the container
WORKDIR /opt

# Install system dependencies
RUN chmod 1777 /tmp
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    ca-certificates \
    python3-pip \
    git \
    ssh \
    7zip \
    iputils-ping \
    git-lfs \
    less \
    nano \
    neovim \
    net-tools \
    nvi \
    nvtop \
    rsync \
    tldr \
    tmux \
    unzip \
    vim \
    wget \
    zip \
    zsh \
    && rm -rf /etc/ssh/ssh_host_*

# Set locale
RUN apt-get install -y locales && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG=en_US.utf8

# Upgrade
RUN apt-get upgrade -y

# Upgrade pip
RUN pip install --no-cache-dir --upgrade pip

# Set up git to support LFS, and to cache credentials; useful for Huggingface Hub
RUN git config --global credential.helper cache && \
    git lfs install

# Install tabbyAPI
RUN git clone https://github.com/theroyallab/tabbyAPI.git && \
    cd tabbyAPI && \
    pip install --no-cache-dir .[cu121] && \
    pip install pyarmor==8.4.6 && \
    cp -av config_sample.yml deploy.yml

# Preparing Model Arg
ARG MODEL_NAME
ARG REVISION
ARG MODEL_PATH=deployed

# Download model
RUN cd tabbyAPI && \
    huggingface-cli download $MODEL_NAME --revision $REVISION --local-dir compiled/$MODEL_PATH --local-dir-use-symlinks False && \
    cd ../ && \
    mv tabbyAPI service && \
    sed -i "s/config = self.from_file/config = self._from_file/" service/common/tabby_config.py && \
    sed -i 's/config_override = args.get("options"/config_override = args.get("config"/' service/common/tabby_config.py && \
    pyarmor gen -O dist -r service/ && \
    touch /home/config.yml && \
    mv dist/pyarmor_runtime_000000 dist/service/ && \
    mv service/deploy.yml dist/service/endpoints/ && \
    mv service/compiled dist/service/ && \
    sed -i "s/model_name:.*/model_name: ${MODEL_PATH}/" dist/service/endpoints/deploy.yml && \
    sed -i "s/model_dir:.*/model_dir: \/opt\/dist\/service\/compiled/" dist/service/endpoints/deploy.yml && \
    sed -i "s/disable_auth:.*/disable_auth: True/" dist/service/endpoints/deploy.yml && \
    sed -i "s/#max_seq_len:.*/max_seq_len: 32000/" dist/service/endpoints/deploy.yml && \
    sed -i "s/port:.*/port: 5300/" dist/service/endpoints/deploy.yml && \
    sed -i "s/host:.*/host: 0.0.0.0/" dist/service/endpoints/deploy.yml && \
    rm -f dist/service/compiled/deployed/{LICENSE,*.md} && \
    rm -rf service/

# Expose Port
EXPOSE 5300

# Entrypoint
CMD ["python3", "/opt/dist/service/main.py", "--config", "/opt/dist/service/endpoints/deploy.yml"]

# Disable bash
# RUN rm -rf /bin/bash /bin/sh

# Set the working directory in the container
WORKDIR /home