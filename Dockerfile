FROM ubuntu:latest

# Set environment vairable
ENV DEBIAN_FRONTEND noninteractive

# Root
USER root

# Add non-root user
ARG PUID=1000
ENV PUID ${PUID}
ARG PGID=1000
ENV PGID ${PGID}

RUN set -xe; \
	groupadd -g ${PGID} dev && \
	useradd -l -u ${PUID} -g dev -m dev && \
	usermod -p "*" dev -s /bin/bash

# Update & install packages
RUN set -xe; \
  apt-get update -yqq && \
	apt-get install -yqq \
		apt-utils \
    curl \
    locales \
    software-properties-common

# Git Neovim Ripgrep
RUN add-apt-repository ppa:git-core/ppa -y && \
  add-apt-repository ppa:neovim-ppa/stable -y && \
  apt-get update -yqq && \
  apt-get install -yqq \
  git \
  neovim \
  ripgrep

WORKDIR /home/dev

# Universal Ctags
RUN apt-get update -yqq && \
  apt-get install -yqq \
  gcc \
  make \
  pkg-config \
  autoconf \
  automake \
  python3-docutils \
  libseccomp-dev \
  libjansson-dev \
  libyaml-dev \
  libxml2-dev
RUN git clone https://github.com/universal-ctags/ctags.git && \
  cd ctags && \
  ./autogen.sh && \
  ./configure --prefix=/usr/local && \
  make && \
  make install && \
  cd .. && rm -rf ctags

# Install Python from source
RUN apt-get update && \
  apt-get install -yqq \
  build-essential \
  zlib1g-dev \
  libncurses5-dev \
  libgdbm-dev \
  libnss3-dev \
  libssl-dev \
  libreadline-dev \
  libffi-dev

ARG PYTHON_VERSION
ARG PYTHON_DOWNLOAD_VERSION

RUN curl -O https://www.python.org/ftp/python/${PYTHON_DOWNLOAD_VERSION}/Python-${PYTHON_DOWNLOAD_VERSION}.tgz && \
  tar xvf Python-${PYTHON_DOWNLOAD_VERSION}.tgz && \
  cd Python-${PYTHON_DOWNLOAD_VERSION} && \
  ./configure --enable-optimizations --with-ensurepip=install && \
  make -j 12 && \
  make install && \
  cd .. && \
  rm Python-${PYTHON_DOWNLOAD_VERSION}.tgz && \
  rm -rf Python-${PYTHON_DOWNLOAD_VERSION}

# Install Python LDAP
RUN apt-get update && \
  apt-get install -yqq \
  libldap2-dev \
  libsasl2-dev \
  python-dev

RUN ln -snf /usr/share/zoneinfo/Asia/Yangon /etc/localtime && echo Asia/Yangon > /etc/timezone

# Install Node
USER dev

WORKDIR /home/dev

ARG NODE_VERSION
ENV NVM_DIR /home/dev/.nvm
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN mkdir -p ${NVM_DIR} && \
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash && \
  . ${NVM_DIR}/nvm.sh && \
  nvm install ${NODE_VERSION} && \
  nvm alias default ${NODE_VERSION} && \
  nvm use default

# Dein
RUN set -xe; \
  mkdir -p $HOME/.vim/bundles && \
  curl -O https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh && \
  sh ./installer.sh $HOME/.vim/bundles && \
  rm ./installer.sh

# Neovim config files
RUN mkdir -p $HOME/.config/nvim/lua

COPY init.vim /home/dev/.config/nvim/
COPY lsp-config.lua /home/dev/.config/nvim/lua/

# Language servers
RUN npm i -g npm@latest neovim pyright vscode-langservers-extracted

RUN python$PYTHON_VERSION -m pip install --user --upgrade pip && \
  python$PYTHON_VERSION -m pip install --user pynvim pipenv

# Powerline fonts
RUN mkdir -p $HOME/app $HOME/.local/share/fonts $HOME/.config/fontconfig/conf.d && \
  curl -O https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf && \
  curl -O https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf && \
  mv PowerlineSymbols.otf $HOME/.local/share/fonts/ && \
  mv 10-powerline-symbols.conf $HOME/.config/fontconfig/conf.d/

# Bash
RUN cat bash.txt >> $HOME/.bashrc

USER root

# Remove unnecessary packages
RUN apt-get purge -yqq \
  apt-utils \
  software-properties-common \
  make \
  pkg-config \
  autoconf \
  automake \
  python3-docutils \
  libseccomp-dev \
  build-essential \
  zlib1g-dev \
  libncurses5-dev \
  libgdbm-dev \
  libnss3-dev \
  libreadline-dev \
  libffi-dev && \
  apt-get autoremove -yqq

# Locale
RUN echo en_US.UTF-8 UTF-8 > /etc/locale.gen && \
  locale-gen

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/log/lastlog /var/log/faillog

RUN chown -R dev:dev /home/dev/.config/nvim

USER dev

WORKDIR /home/dev/app

