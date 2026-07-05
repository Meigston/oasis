# ${{ values.resourceName }}

${{ values.description }}

Recurso de banco de dados **Cloud SQL** no Google Cloud, provisionado via
`gcloud` (GitHub Actions) — **sem Terraform**. Criado a partir do Backstage
Developer Portal (template **Banco de dados no GCP**).

## Configuração

| Item      | Valor                          |
| --------- | ------------------------------ |
| Instância | `${{ values.instanceName }}`   |
| Engine    | `${{ values.databaseVersion }}`|
| Região    | `${{ values.region }}`         |
| Tier      | `${{ values.tier }}`           |
| Banco     | `${{ values.databaseName }}`   |

## Como provisionar

1. No repositório, configure:
   - **Secret** `GCP_KEY` — JSON da service account com o papel *Cloud SQL Admin*.
   - **Secret** `DB_ROOT_PASSWORD` — senha do usuário root da instância.
   - **Variable** `GCP_PROJECT_ID` — id do projeto no GCP.
2. Vá em **Actions → Provision Cloud SQL → Run workflow**.

O script `scripts/create-db.sh` é **idempotente**: rodar de novo não recria
recursos já existentes. Ao final ele imprime o `connectionName` da instância.

> ⚠️ Cloud SQL gera custo enquanto a instância estiver ativa. Para a PoC use um
> tier pequeno (`db-f1-micro`) e apague a instância quando não precisar:
> `gcloud sql instances delete ${{ values.instanceName }} --project <PROJECT_ID>`
