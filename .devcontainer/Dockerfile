# Estágio de Build para CLIs e Ferramentas de Performance
FROM ruby:4.0.0-slim AS builder

ENV DEBIAN_FRONTEND=noninteractive

# Instala ferramentas de build básicas
RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    npm \
    curl \
    ca-certificates \
    build-essential \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala Rust para habilitar o ZJIT (exige Rust 1.85+)
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain 1.85.0
ENV PATH="/root/.cargo/bin:${PATH}"

# Instala as ferramentas globais (CLI)
# Fix BW CLI: Forçando instalação do core-js para resolver erro de módulo ausente
RUN npm install -g @bitwarden/cli @anthropic-ai/claude-code core-js

# Estágio Final / Runtime
FROM ruby:4.0.0-slim

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
    npm \
    sudo \
    && npm install -g @bitwarden/cli @anthropic-ai/claude-code \
    && apt-get purge -y npm \
    && apt-get autoremove -y \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copia ferramentas de performance do estágio de builder
COPY --from=builder /root/.cargo /home/vscode/.cargo
COPY --from=builder /root/.rustup /home/vscode/.rustup

# Configura o Rust para o usuário vscode (ambiente ZJIT)
ENV PATH="/home/vscode/.cargo/bin:${PATH}"

# Otimização: Já deixa o Rails e o Bundler pré-instalados na imagem
RUN gem update --system && gem install bundler rails

# Habilita as vanguardas do Ruby 4.0 (Apenas após o build para evitar instabilidade)
ENV RUBY_ZJIT=1
ENV RUBY_BOX=1

# Cria um usuário não-root (vscode) compatível com DevContainers padrão
RUN useradd -m -s /bin/bash vscode \
    && echo "vscode ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vscode \
    && chmod 0440 /etc/sudoers.d/vscode \
    && mkdir -p /home/vscode/.config \
    && chown -R vscode:vscode /home/vscode /home/vscode/.cargo /home/vscode/.rustup

# Configura as permissões do diretório de trabalho
WORKDIR /workspace
RUN chown -R vscode:vscode /workspace

# Define o vscode como usuário padrão da imagem
USER vscode
