#!/usr/bin/env bash
set -euo pipefail

# Adiciona um repo ao QG via git subtree (preserva histórico)
# Uso: bash scripts/add-repo.sh <nome> <url-ou-caminho> [branch]

if [ $# -lt 2 ]; then
  echo "Uso: bash scripts/add-repo.sh <nome> <url-ou-caminho> [branch]"
  echo "Exemplos:"
  echo "  bash scripts/add-repo.sh site https://github.com/mundoterra/site.git main"
  echo "  bash scripts/add-repo.sh app ~/projetos/mundoterra-app main"
  exit 1
fi

NOME="$1"
ORIGEM="$2"
BRANCH="${3:-main}"

QG_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$QG_ROOT"

if [ -d "repos/$NOME" ]; then
  echo "ERRO: repos/$NOME já existe. Use sync-repos.sh para atualizar."
  exit 1
fi

echo "==> Importando '$NOME' de $ORIGEM (branch: $BRANCH)..."
git subtree add --prefix="repos/$NOME" "$ORIGEM" "$BRANCH" --squash

# Registrar em scripts/repos.txt
echo "$NOME|$ORIGEM|$BRANCH" >> scripts/repos.txt

echo ""
echo "==> Repo '$NOME' importado em repos/$NOME"
echo "==> Registrado em scripts/repos.txt para sync futuro"
