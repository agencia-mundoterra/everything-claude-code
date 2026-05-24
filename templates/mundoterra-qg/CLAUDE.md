# CLAUDE.md — Mundo Terra QG

Instruções para o Claude Code quando rodando neste workspace.

## Contexto

Este é o **Quartel-General (QG) da Mundo Terra** — um monorepo que centraliza todos os projetos, configurações e integrações da empresa. Cada projeto vive em `repos/<nome>/` e foi importado via `git subtree` (histórico preservado).

## Convenções

- **Commits**: Conventional Commits (`feat:`, `fix:`, `docs:`, `chore:`).
- **Branches**: `feature/<nome>`, `fix/<nome>`, `chore/<nome>`.
- **PRs**: Sempre como draft inicial. Descrição em português.
- **Idioma**: Comunicação em **português brasileiro**.

## Estrutura dos repos

Cada `repos/<projeto>/` é independente — tem seu próprio `package.json`, testes, deploy. Antes de mudar código, leia o `README.md` do projeto específico.

## Antes de qualquer mudança

1. Identifique em qual repo a mudança se aplica (`repos/<nome>/`).
2. Leia o `README.md` e qualquer `CLAUDE.md` do projeto.
3. Rode os testes do projeto se existirem.
4. Use commits pequenos e atômicos.

## Secrets

- **NUNCA** commite arquivos em `secrets/` (já tem `.gitignore`).
- Use `secrets/.env.example` como referência das variáveis necessárias.
- Para adicionar nova variável: atualize tanto `.env` quanto `.env.example` (com valor placeholder).

## Sincronização de subtrees

Quando o usuário pedir para "atualizar repos" ou "sincronizar", use o script:

```bash
bash scripts/sync-repos.sh
```

NÃO rode `git subtree pull` manualmente — o script trata de todos os repos e loga erros.

## MCPs disponíveis

Configurados em `.claude/mcp-servers.json`. Os principais:

- **github** — operações em repos e PRs
- **notion** — base de conhecimento e tarefas
- **supabase** — banco de dados de produção
- **filesystem** — acesso ao próprio QG
- **memory** — memória persistente entre sessões

## Agents customizados

Use os agents Mundo Terra (em `.claude/agents/`) para tarefas específicas:

- `mundoterra-architect` — decisões cross-repo
- `mundoterra-deployer` — deploys e infra
- `mundoterra-content` — conteúdo e marketing
- `mundoterra-data` — análise e dashboards

## Limites

- Não modifique nada fora de `repos/`, `docs/`, `scripts/` sem confirmar.
- Não rode `git push` em repos dentro de `repos/` sem o usuário pedir — use o script de sync.
- Não toque em `secrets/.env` (só leitura).
