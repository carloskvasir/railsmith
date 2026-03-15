# Usa uma imagem oficial leve e enxuta, baseada em slim
FROM ruby:3.3-slim

# Evita interações travando o apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Instalação unificada de dependências de sistema (Infra Forge)
# Inclui dependências de build, banco de dados (PG), libvips (Rails ActiveStorage) e NodeJS
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    bash \
    curl \
    git \
    libpq-dev \
    postgresql-client \
    redis-tools \
    libvips \
    nodejs \
    npm \
    sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala as ferramentas globais (CLI)
RUN npm install -g @bitwarden/cli @anthropic-ai/claude-code

# Otimização: Já deixa o Rails e o Bundler pré-instalados na imagem
RUN gem update --system && gem install bundler rails

# Cria um usuário não-root (vscode) compatível com DevContainers padrão
RUN useradd -m -s /bin/bash vscode \
    && echo "vscode ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vscode \
    && chmod 0440 /etc/sudoers.d/vscode

# Configura as permissões do diretório de trabalho
WORKDIR /workspace
RUN chown -R vscode:vscode /workspace

# Define o vscode como usuário padrão da imagem
USER vscode
