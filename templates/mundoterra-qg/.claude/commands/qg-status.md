---
description: Mostra visão geral do QG — repos importados, MCPs ativos, último sync, secrets configurados.
---

# /qg-status

Execute esses checks em paralelo e apresente um relatório curto:

1. **Repos importados** — `ls repos/` e mostre cada um com tamanho e último commit do subtree.
2. **MCPs configurados** — leia `.claude/mcp-servers.json` e liste cada server com status (URL/comando).
3. **Secrets** — verifique se `secrets/.env` existe e quantas variáveis tem (sem expor valores!).
4. **Último sync** — `git log --grep="Subtree sync" -1 --format='%ci %s'`.
5. **Git status** — branch atual e mudanças pendentes.

## Formato de saída

```
## QG Status — <data>

### Repos (N)
- repos/site — último subtree merge: <data> (<sha>)
- repos/app — ...

### MCPs ativos (N)
- github ✓
- notion ✓
- ...

### Secrets
- secrets/.env: ✓ (N variáveis definidas)

### Git
- Branch: <nome>
- Mudanças pendentes: N arquivos

### Próximas ações sugeridas
- ...
```

Mantenha o relatório em < 30 linhas.
