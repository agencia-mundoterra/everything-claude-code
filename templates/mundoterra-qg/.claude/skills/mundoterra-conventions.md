# Mundo Terra — Convenções de Código

Skill carregado automaticamente quando trabalhando em qualquer repo dentro do QG.

## Quando usar

Sempre que estiver editando código em `repos/*/`.

## Convenções universais

### Linguagem

- **Domínio em português** — entidades de negócio: `Pedido`, `Cliente`, `Produto`, `Carrinho`.
- **Código em inglês** — funções, variáveis, tipos: `createOrder`, `customerEmail`, `OrderStatus`.
- **Strings de UI em português** — `"Adicionar ao carrinho"`, não `"Add to cart"`.

### Arquivos

- **kebab-case** para arquivos: `pedido-service.ts`, `cliente-form.tsx`.
- **PascalCase** para componentes React quando o arquivo é o componente: `PedidoForm.tsx` é aceitável.
- **Testes**: `<nome>.test.ts` ao lado do código, NÃO em pasta separada.

### Commits

```
feat(escopo): descrição curta no presente

Corpo opcional explicando o porquê.
```

Tipos: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `style`.
Escopo: nome do repo ou área (`site`, `api`, `auth`).

### PRs

- Título: igual ao commit principal.
- Descrição em português, sempre com seções:
  - **O que muda**
  - **Por quê**
  - **Como testar**
- Sempre abrir como **draft** primeiro.

## Stack padrão

### Frontend
- Next.js 15+ (App Router)
- Tailwind CSS
- Componentes em `components/`, páginas em `app/`
- Server Components por default — `"use client"` só quando necessário

### Backend
- Node.js 20+ (CommonJS quando script, ESM quando app)
- Hono ou Express para APIs
- Drizzle ORM ou supabase-js

### Banco
- Supabase (Postgres)
- Migrations em `supabase/migrations/`
- RLS habilitado em todas as tabelas com dados de usuário

## Testes

- Testes unitários para lógica de negócio (services, helpers).
- Testes de integração para endpoints/APIs.
- E2E apenas para fluxos críticos (checkout, login).
- Roda com `npm test` em cada repo.

## O que evitar

- Comentários óbvios (`// soma a + b`).
- `any` em TypeScript — use `unknown` ou tipos específicos.
- Lógica de negócio em componentes React — extraia para hooks ou services.
- Acoplamento direto entre repos — use contratos (OpenAPI, tipos compartilhados via pacote npm).
