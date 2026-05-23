#!/usr/bin/env bash
set -euo pipefail

# Sincroniza todos os repos do QG (git subtree pull)
# Uso: bash scripts/sync-repos.sh

QG_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$QG_ROOT"

REPOS_FILE="scripts/repos.txt"
LOG_FILE="docs/sync-log.md"

if [ ! -f "$REPOS_FILE" ]; then
  echo "ERRO: $REPOS_FILE não encontrado. Rode init-qg.sh primeiro."
  exit 1
fi

mkdir -p docs
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
echo "" >> "$LOG_FILE"
echo "## Sync $TIMESTAMP" >> "$LOG_FILE"

SUCESSOS=0
FALHAS=0

while IFS='|' read -r NOME ORIGEM BRANCH; do
  # Pular comentários e linhas vazias
  [[ "$NOME" =~ ^#.*$ ]] && continue
  [[ -z "$NOME" ]] && continue

  BRANCH="${BRANCH:-main}"

  if [ ! -d "repos/$NOME" ]; then
    echo "  ⚠  $NOME: pasta repos/$NOME não existe — pulando"
    echo "- ⚠ $NOME: pasta não existe" >> "$LOG_FILE"
    continue
  fi

  echo "==> Sincronizando '$NOME' de $ORIGEM ($BRANCH)..."
  if git subtree pull --prefix="repos/$NOME" "$ORIGEM" "$BRANCH" --squash 2>&1 | tail -5; then
    echo "  ✓ $NOME atualizado"
    echo "- ✓ $NOME ($ORIGEM @ $BRANCH)" >> "$LOG_FILE"
    SUCESSOS=$((SUCESSOS + 1))
  else
    echo "  ✗ $NOME falhou"
    echo "- ✗ $NOME — verificar conflitos" >> "$LOG_FILE"
    FALHAS=$((FALHAS + 1))
  fi
done < "$REPOS_FILE"

echo ""
echo "==> Sync concluído: $SUCESSOS sucesso(s), $FALHAS falha(s)"
echo "==> Log salvo em $LOG_FILE"
