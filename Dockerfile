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
  python3-distutils \
  zlib1g-dev \
  libncurses5-dev \
  libgdbm-dev \
  libnss3-dev \
  libssl-dev \
  libreadline-dev \
  libffi-dev

# Install Python LDAP
RUN apt-get update && \
  apt-get install -yqq \
  libldap2-dev \
  libsasl2-dev \
  python-dev

RUN ln -snf /usr/share/zoneinfo/Asia/Yangon /etc/localtime && \
  echo Asia/Yangon > /etc/timezone

# Install Node
USER dev

WORKDIR /home/dev

ARG NODE_VERSION
ENV NVM_DIR /home/dev/.nvm
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
ENV HOME /home/dev

RUN mkdir -p ${NVM_DIR} && \
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash && \
  . ${NVM_DIR}/nvm.sh && \
  nvm install ${NODE_VERSION} && \
  nvm alias default ${NODE_VERSION} && \
  nvm use default

# Dein
RUN set -xe; \
  mkdir -p ${HOME}/.vim/bundles && \
  curl -O https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh && \
  sh ./installer.sh ${HOME}/.vim/bundles && \
  rm ./installer.sh

# Neovim config files
RUN mkdir -p \
  ${HOME}/.config/nvim/lua \
  ${HOME}/.config/nvim/syntax && \
  curl http://www.vim.org/scripts/download_script.php?src_id=19394 -o ${HOME}/.config/nvim/syntax/nginx.vim

COPY nvim ${HOME}/.config/nvim/
COPY lua ${HOME}/.config/nvim/lua/

# Language servers
RUN npm i -g \
  neovim \
  npm@latest \
  pyright \
  typescript \
  typescript-language-server \
  vscode-langservers-extracted

# Powerline fonts
RUN mkdir -p \
  ${HOME}/app \
  ${HOME}/.local/share/fonts \
  ${HOME}/.config/fontconfig/conf.d && \
  curl -O https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf && \
  curl -O https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf && \
  mv PowerlineSymbols.otf ${HOME}/.local/share/fonts/ && \
  mv 10-powerline-symbols.conf ${HOME}/.config/fontconfig/conf.d/

# pyenv
RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

# Pip
RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
  python3 get-pip.py && \
  python3 -m pip install --upgrade pip && \
  rm get-pip.py

# Bash
RUN echo " \n\
alias cls='cat /dev/null > ~/.bash_history && history -c && clear && reset' \n\
export PATH=/home/dev/.pyenv/bin:$PATH:$HOME/.local/bin \n\
if type rg &> /dev/null; then \n\
  export FZF_DEFAULT_COMMAND='rg --files' \n\
fi " >> ${HOME}/.bashrc

USER root

# Remove unnecessary packages
RUN apt-get purge -yqq \
  apt-utils \
  software-properties-common \
  pkg-config \
  autoconf \
  automake \
  python3-docutils \
  libseccomp-dev && \
  apt-get autoremove -yqq

# Locale
RUN update-locale LANG=LANG=en_US.UTF-8 LANGUAGE

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/log/lastlog /var/log/faillog

RUN chown -R dev:dev ${HOME}/.config/nvim

USER dev

WORKDIR ${HOME}/app

