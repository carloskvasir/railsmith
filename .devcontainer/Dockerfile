ARG VARIANT=3.3-bookworm
FROM mcr.microsoft.com/devcontainers/ruby:${VARIANT}

# Instalar pacotes de sistema necessários e utilitários
# libvips é uma dependência moderna recomendada para processamento de imagens no Rails (Active Storage / ImageProcessing)
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends postgresql-client redis-tools libvips \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
