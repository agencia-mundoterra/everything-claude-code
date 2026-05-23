# Mundo Terra — Quartel-General (QG)

Workspace central que unifica todos os projetos, configurações e ferramentas da Mundo Terra num único lugar acessível via VPN.

## Estrutura

```
mundoterra-qg/
├── .claude/              # Configuração do Claude Code (agents, skills, MCPs)
│   ├── agents/           # Subagents especializados (architect, deployer, content, data)
│   ├── skills/           # Workflows e convenções
│   ├── commands/         # Slash commands (/sync-repos, /qg-status, /new-project)
│   ├── hooks/            # Automações por evento
│   ├── settings.json     # Permissions, env vars, hooks
│   └── mcp-servers.json  # MCPs unificados (GitHub, Notion, Supabase, etc.)
├── repos/                # Repos da Mundo Terra (via git subtree)
├── docs/                 # Documentação, runbooks, decisões
├── secrets/              # .env e credenciais (NUNCA commitar)
├── scripts/              # Utilitários (init, sync, deploy)
├── CLAUDE.md             # Instruções para o Claude Code
└── README.md             # Este arquivo
```

## Quick Start

```bash
# 1. Clonar este QG na sua máquina
cd ~
git clone <url-do-qg> mundoterra-qg
cd mundoterra-qg

# 2. Rodar o bootstrap (instala deps, configura MCPs, copia .env exemplo)
bash scripts/init-qg.sh

# 3. Editar credenciais
cp secrets/.env.example secrets/.env
# preencha os valores

# 4. Iniciar Claude Code
claude
```

## Acesso remoto via VPN

Recomendado: **Tailscale** + SSH.

```bash
# Na máquina onde está o QG
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up

# De qualquer outro device autenticado na sua tailnet
ssh seu-usuario@nome-da-maquina
cd ~/mundoterra-qg && claude
```

## Importar um repo novo (preservando histórico)

```bash
bash scripts/add-repo.sh <nome> <caminho-ou-url-do-repo>
# Exemplo:
bash scripts/add-repo.sh site ~/projetos/mundoterra-site
bash scripts/add-repo.sh app https://github.com/mundoterra/app.git
```

## Sincronizar todos os repos

```bash
bash scripts/sync-repos.sh
```

## Slash commands úteis

- `/qg-status` — visão geral do QG (repos, MCPs ativos, último sync)
- `/sync-repos` — atualiza todos os subtrees
- `/new-project <nome>` — cria scaffold de um novo projeto Mundo Terra

## Agents disponíveis

- `mundoterra-architect` — decisões de arquitetura cross-repo
- `mundoterra-deployer` — pipelines de deploy e CI/CD
- `mundoterra-content` — produção de conteúdo e marketing
- `mundoterra-data` — análise de dados e dashboards
