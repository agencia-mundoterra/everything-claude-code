---
description: Sincroniza todos os repos do QG via git subtree pull. Atualiza cada repo a partir do remote original.
---

# /sync-repos

Execute o script de sync e reporte o resultado:

```bash
bash scripts/sync-repos.sh
```

O script:
1. Lê `scripts/repos.txt` (lista de repos com nome + URL + branch)
2. Para cada repo, roda `git subtree pull --prefix=repos/<nome> <url> <branch> --squash`
3. Loga sucessos e falhas em `docs/sync-log.md`

## Após o sync

- Mostre quais repos foram atualizados (novos commits trazidos).
- Mostre quais falharam e o motivo.
- Se houve mudanças, pergunte se o usuário quer revisar com `git diff HEAD~1`.
