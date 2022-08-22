FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

USER root
 
# Create non-root user
ARG PUID=1000
ENV PUID=${PUID}
ARG PGID=1000
ENV PGID=${PGID}

# Set timezone
ARG TZ=UTC
ENV TZ=${TZ}

RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone
# Install essentials
RUN set -xe; \
  apt-get update -y && \
  apt-get install -y \
    curl \
    ripgrep \
    software-properties-common \
    zsh && \
  chsh -s $(which zsh) && \
  sh -c "$(curl -fsSL https://starship.rs/install.sh)" -y -f

# Install Neovim Git
RUN set -xe; \
  add-apt-repository ppa:neovim-ppa/unstable -y && \
  add-apt-repository ppa:git-core/ppa -y && \
  apt-get update -y && \
  apt-get install -y \
    neovim \
    git

# Python build dependencies
# RUN set -xe; \
#   apt-get update -y && \
#   apt-get install -y \
#     build-essential \
#     libncurses5-dev \
#     libgdbm-dev \
#     libnss3-dev \
#     libsqlite3-dev \
#     libssl-dev \
#     libreadline-dev \
#     libffi-dev \
#     zlib1g-dev

# Install Python LDAP
RUN set -xe; \
  apt-get update -y && \
  apt-get install -y \
  libldap2-dev \
  libsasl2-dev \
  python3-dev

# Create user
RUN groupadd --gid ${PGID} dev && \
  useradd \
    --create-home \
    --home /home/dev \
    --shell /bin/bash \
    --uid ${PUID} \
    --gid dev \
    dev

ENV HOME=/home/dev
ENV ZSH_CUSTOM=${HOME}/.oh-my-zsh/custom

# Set system environment variables
ENV LANG=C.UTF-8 \
  LC_ALL=C.UTF-8 \
  PYTHONDONTWRITEBYTECODE=1 \
  PYTHONFAULTHANDLER=1

USER dev

WORKDIR ${HOME}

# Setup zsh
RUN set -xe; \
  mkdir -p ${HOME}/${ZSH_CUSTOM}/plugins && \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions

COPY .zshrc ${HOME}/

# Install nvm
RUN set -xe; \
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Install Dein
RUN set -xe; \
  mkdir -p ${HOME}/.vim/bundles && \
  curl -O https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh && \
  sh ./installer.sh ${HOME}/.vim/bundles && \
  rm ./installer.sh

# Neovim config files
RUN set -xe; \
  mkdir -p ${HOME}/.config/nvim/lua

COPY nvim ${HOME}/.config/nvim/
COPY lua ${HOME}/.config/nvim/lua/
COPY starship.toml ${HOME}/.config

# Language servers
RUN export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && \
  printf %s "${HOME}/.nvm")" && \
  \. "$NVM_DIR/nvm.sh" && \
  nvm install node && \
  npm i -g \
  neovim \
  npm@latest \
  pyright \
  svelte-language-server \
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

USER root

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/log/lastlog /var/log/faillog

RUN chown -R ${PUID}:${PUID} ${HOME}/.config/nvim

USER dev

WORKDIR ${HOME}/app
