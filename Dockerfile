ARG ROS_VERSION=jazzy
FROM tomphoward/ros2waffle:${ROS_VERSION}

ARG ROS_VERSION
ENV DEBIAN_FRONTEND=noninteractive

ENV DEFAULT_USER=student

ENV QT_X11_NO_MITSHM=1
ENV EDITOR=nano

RUN apt-get update && apt-get install -y \
    xorg-dev \
    net-tools \
    iputils-ping \
    iproute2 \
    neovim && \
    wget https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg -O /usr/share/keyrings/vscodium-archive-keyring.asc && \
    echo 'deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/vscodium-archive-keyring.asc ] https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs vscodium main' | tee /etc/apt/sources.list.d/vscodium.list && \
    apt update && apt install codium -y && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

# Try to install starship, but don't fail if it doesn't work
RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes || true

USER ${DEFAULT_USER}
ARG HOME_DIR=/home/${DEFAULT_USER}
WORKDIR ${HOME_DIR}

RUN touch ${HOME_DIR}/.hushlogin && \
    mkdir ${HOME_DIR}/.diamond && \
    mkdir ${HOME_DIR}/.ssh

# Only add starship init if starship was successfully installed
RUN if [ -f "/usr/local/bin/starship" ]; then \
    echo 'eval "$(starship init bash)"' >> ~/.bashrc; \
    fi

COPY ./source/ros2-docker-configs.sh ${HOME_DIR}/.diamond/ros2-docker-configs.sh
COPY ./source/bash-aliases ${HOME_DIR}/.diamond/bash-aliases
RUN echo "source ~/.diamond/ros2-docker-configs.sh" >> ${HOME_DIR}/.bashrc

RUN sudo chown -R ${DEFAULT_USER}:${DEFAULT_USER} ${HOME_DIR}/.diamond

CMD ["bash", "-l"]
