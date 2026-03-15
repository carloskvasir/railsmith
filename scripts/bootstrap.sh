#!/bin/bash
set -e

echo "========================================="
echo "🚂 Bem-vindo ao RailSmith!"
echo "========================================="

echo "📦 Verificando gems (bundle install)..."
if [ -f "Gemfile" ]; then
  bundle install
else
  echo "⚠️ Nenhum Gemfile encontrado. (Pule esta etapa se você ainda não rodou 'rails new .')"
fi

echo "🗄️ Preparando o banco de dados..."
if [ -f "bin/rails" ]; then
  bin/rails db:prepare || echo "⚠️  Nenhum banco de dados para preparar ainda."
else
  echo "⚠️ App Rails não identificada. Lembre-se de rodar: rails new . -d postgresql"
fi

echo "-----------------------------------------"
echo "🔐 Autenticação: Bitwarden e Claude"
echo "-----------------------------------------"

if ! command -v bw &> /dev/null; then
  echo "⚠️  Bitwarden CLI não encontrado na imagem base."
else
  if bw status | grep -q '"status":"unauthenticated"'; then
    echo "⚠️  Você ainda não se autenticou no Bitwarden CLI."
    echo "👉 Rode: bw login"
  else
    echo "✅ Bitwarden CLI instalado e logado."
  fi
fi

echo ""
echo "🤖 Para parear com a inteligência artificial da Anthropic:"
echo "👉 Rode: claude"
echo "========================================="
echo "✅ Ambiente ativado no DevContainer! Divirta-se!"
