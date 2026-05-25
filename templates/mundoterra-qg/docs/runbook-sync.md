# Runbook — Sincronização do QG entre máquinas

O QG roda em **cópia independente por máquina** (desktop, notebook), todas
apontando para o **mesmo repositório git privado**. Cada uma trabalha offline e
sincroniza via `git pull` / `git push`.

> Não confundir com a sincronização de *subtrees* (`scripts/sync-repos.sh`), que
> traz atualizações dos repos externos para dentro de `repos/`. Aqui é sobre
> manter as **máquinas** em sincronia entre si.

## Setup inicial (uma vez)

### 1. Criar o repositório do QG

Crie um repo **privado** no GitHub, ex: `agencia-mundoterra/mundoterra-qg`.

### 2. Primeira máquina (ex: desktop)

```bash
cp -r everything-claude-code/templates/mundoterra-qg ~/mundoterra-qg
cd ~/mundoterra-qg
bash scripts/init-qg.sh                 # roda git init -b main
git remote add origin git@github.com:agencia-mundoterra/mundoterra-qg.git
git push -u origin main
```

### 3. Demais máquinas (ex: notebook)

```bash
git clone git@github.com:agencia-mundoterra/mundoterra-qg.git ~/mundoterra-qg
cd ~/mundoterra-qg
bash scripts/init-qg.sh                 # detecta .git, só instala deps
cp secrets/.env.example secrets/.env    # preencha as credenciais (NÃO vão via git)
```

## Rotina diária

Em **qualquer** máquina, sempre:

```bash
# Ao começar a trabalhar
git pull origin main

# ... faça suas mudanças ...

# Ao terminar
git add -A
git commit -m "feat: ..."
git push origin main
```

**Regra de ouro:** sempre `git pull` **antes** de começar. Se editar nos dois
lados sem dar pull, vai gerar conflito de merge.

## O que sincroniza (e o que não)

| Item | Sincroniza via git? | Observação |
|------|:---:|------------|
| `repos/<projeto>/` (subtrees) | ✅ | Conteúdo é commitado no QG |
| `.claude/`, `docs/`, `scripts/` | ✅ | Configuração e utilitários |
| `CLAUDE.md`, `README.md` | ✅ | — |
| `secrets/.env` | ❌ | Gitignored — copie manualmente por máquina |
| `node_modules/` | ❌ | Recriado por `npm install` em cada máquina |

## Resolvendo conflitos

Se o `git pull` acusar conflito:

1. `git status` para ver os arquivos em conflito.
2. Edite cada arquivo resolvendo os marcadores `<<<<<<<` / `>>>>>>>`.
3. `git add <arquivo>` e `git commit`.
4. `git push origin main`.

Se o conflito for em `repos/` (subtree), trate como código normal — resolva no
arquivo e commite. **Não** rode `git subtree` para resolver conflito de sync.
