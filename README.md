# Oasis — Backstage Developer Portal (PoC)

Portal interno de desenvolvimento (Internal Developer Platform) construído com
[Backstage](https://backstage.io).

## Objetivo

Permitir que um desenvolvedor escolha um **Software Template** e, com um clique,
tenha automaticamente:

1. Repositório criado no GitHub
2. Estrutura inicial do projeto
3. Dockerfile pronto para produção
4. GitHub Actions (CI/CD) configurada
5. Build da imagem Docker
6. Publicação da imagem no **Google Artifact Registry**
7. Componente registrado no catálogo do Backstage (base para deploy futuro na GCP)

> PoC intencionalmente simples: **sem Terraform, Pulumi ou Kubernetes** neste estágio.
> A arquitetura permite adicionar Cloud Run, Kubernetes, Helm e Terraform depois.

## Templates disponíveis

| Template     | Stack            | Status         |
| ------------ | ---------------- | -------------- |
| `python-api` | FastAPI (Python) | ✅ Implementado |
| `dotnet-api` | .NET             | 🔜 Planejado   |
| `nodejs-api` | Node.js          | 🔜 Planejado   |

Templates ficam em [`templates/`](./templates) e são registrados no catálogo via
`app-config.yaml` (`catalog.locations`).

## Rodando o Backstage localmente

```sh
export GITHUB_TOKEN=<seu_personal_access_token>   # Linux/macOS
# $env:GITHUB_TOKEN="<token>"                      # Windows PowerShell

yarn install
yarn start
```

Acesse http://localhost:3000 → **Create...** → **Python API (FastAPI)**.

O `GITHUB_TOKEN` precisa de permissão para criar repositórios na organização
alvo (`repo` + `workflow`).

## Fluxo da PoC

```
Backstage > Create > Python API
  ↳ preenche: nome, descrição, owner, porta, org/repo GitHub
  ↳ CREATE
     ✓ repositório GitHub criado
     ✓ código FastAPI + Dockerfile gerados
     ✓ workflow CI/CD adicionado
     ✓ componente registrado no catálogo
     ✓ push na main dispara o pipeline → imagem no Artifact Registry
```

## Configuração da GCP (no repositório gerado)

O pipeline espera, no repositório criado:

- **Secret** `GCP_KEY` — JSON de uma service account com escrita no Artifact Registry.
- **Variables** `GCP_PROJECT_ID`, `GCP_REGION`, `GCP_ARTIFACT_REPOSITORY`.

Uma evolução futura é uma **Custom Action** do Backstage para criar secrets,
environments e permissões automaticamente.
