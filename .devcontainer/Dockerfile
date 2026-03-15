# Estágio de Build para CLIs
FROM ruby:3.4-slim AS builder

ENV DEBIAN_FRONTEND=noninteractive

# Instala apenas o necessário para baixar e instalar os pacotes globais do npm
RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    npm \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala as ferramentas globais (CLI)
RUN npm install -g @bitwarden/cli @anthropic-ai/claude-code

# Estágio Final / Runtime
FROM ruby:3.4-slim

ENV DEBIAN_FRONTEND=noninteractive

# Instalação unificada de dependências de sistema (Infra Forge)
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
    sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copia os binários e bibliotecas do nó do Node.js compilados no estágio anterior
COPY --from=builder /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=builder /usr/local/bin/claude /usr/local/bin/claude
COPY --from=builder /usr/local/bin/bw /usr/local/bin/bw

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
