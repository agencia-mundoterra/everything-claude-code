---
description: Cria scaffold de um novo projeto Mundo Terra dentro de repos/. Uso, /new-project <nome> [stack]
---

# /new-project

Cria um repo novo dentro de `repos/<nome>/` com a estrutura padrão Mundo Terra.

## Argumentos

- `<nome>` — slug do projeto (lowercase, hifens). Ex: `painel-admin`.
- `[stack]` — opcional. Valores: `nextjs`, `node-api`, `worker`, `static`. Default: `nextjs`.

## Processo

1. Criar `repos/<nome>/` e inicializar como repo git.
2. Adicionar `README.md` com seção Quick Start.
3. Adicionar `CLAUDE.md` apontando para convenções do QG.
4. Adicionar `.gitignore` apropriado para a stack.
5. Adicionar entry em `scripts/repos.txt` (mesmo que sem remote ainda).
6. Não rodar `npm install` automaticamente — deixe o usuário decidir.

## Após criar

Pergunte se o usuário quer:
- Conectar a um remote do GitHub (use MCP do GitHub se sim).
- Configurar deploy (chame agent `mundoterra-deployer`).
- Adicionar CI básico (`.github/workflows/ci.yml`).
