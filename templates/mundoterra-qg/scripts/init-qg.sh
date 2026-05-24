#!/usr/bin/env bash
set -euo pipefail

# Bootstrap do Mundo Terra QG
# Uso: bash scripts/init-qg.sh

QG_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$QG_ROOT"

echo "==> Mundo Terra QG bootstrap em: $QG_ROOT"
echo ""

# 1. Verificar pré-requisitos
echo "==> Verificando pré-requisitos..."
command -v git >/dev/null || { echo "ERRO: git não encontrado"; exit 1; }
command -v node >/dev/null || { echo "ERRO: node não encontrado (instale Node.js 18+)"; exit 1; }
command -v npm >/dev/null || { echo "ERRO: npm não encontrado"; exit 1; }

NODE_MAJOR=$(node -v | sed 's/v\([0-9]*\).*/\1/')
if [ "$NODE_MAJOR" -lt 18 ]; then
  echo "ERRO: Node.js >=18 necessário (encontrado: $(node -v))"
  exit 1
fi
echo "  ✓ git, node $(node -v), npm $(npm -v)"

# 2. Inicializar git se necessário
if [ ! -d .git ]; then
  echo "==> Inicializando repo git..."
  git init -b main
  git add .
  git commit -m "chore: inicializa QG Mundo Terra" || true
fi

# 3. Criar pastas se faltarem
echo "==> Garantindo estrutura de pastas..."
mkdir -p repos docs secrets scripts .claude/{agents,skills,commands,hooks}

# 4. Criar .env.example se não existir
if [ ! -f secrets/.env.example ]; then
  echo "==> Criando secrets/.env.example..."
  cat > secrets/.env.example <<'EOF'
# Mundo Terra QG — variáveis de ambiente
# Copie para secrets/.env e preencha

# GitHub
GITHUB_PAT=

# Supabase
SUPABASE_PROJECT_REF=
SUPABASE_ACCESS_TOKEN=
SUPABASE_URL=
SUPABASE_ANON_KEY=

# Vercel
VERCEL_TOKEN=

# Notion (se usando self-hosted)
NOTION_API_KEY=

# Exa (busca web)
EXA_API_KEY=

# OpenAI / Anthropic (se necessário para apps)
OPENAI_API_KEY=
ANTHROPIC_API_KEY=
EOF
fi

# 5. Criar scripts/repos.txt se não existir
if [ ! -f scripts/repos.txt ]; then
  echo "==> Criando scripts/repos.txt..."
  cat > scripts/repos.txt <<'EOF'
# Lista de repos do QG
# Formato: <nome>|<url-ou-caminho>|<branch>
# Linhas começando com # são ignoradas
# Exemplo:
# site|https://github.com/mundoterra/site.git|main
# app|/Users/augusto/projetos/mundoterra-app|main
EOF
fi

# 6. Instalar Claude Code se não existe
if ! command -v claude >/dev/null; then
  echo "==> Instalando Claude Code..."
  npm install -g @anthropic-ai/claude-code
fi

echo ""
echo "==> Bootstrap concluído!"
echo ""
echo "Próximos passos:"
echo "  1. cp secrets/.env.example secrets/.env  &&  edite os valores"
echo "  2. Adicione seus repos editando scripts/repos.txt"
echo "  3. Importe os repos: bash scripts/add-repo.sh <nome> <url-ou-caminho>"
echo "  4. Inicie o Claude Code: claude"
