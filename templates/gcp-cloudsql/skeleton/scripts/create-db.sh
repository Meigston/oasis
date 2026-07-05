#!/usr/bin/env bash
#
# Provisiona uma instância Cloud SQL e um banco dentro dela, de forma idempotente.
# Valores fixos abaixo são gerados pelo template do Backstage; segredos e o
# project id vêm de variáveis de ambiente (injetadas pelo GitHub Actions).
#
set -euo pipefail

INSTANCE="${{ values.instanceName }}"
REGION="${{ values.region }}"
TIER="${{ values.tier }}"
DB_VERSION="${{ values.databaseVersion }}"
DB_NAME="${{ values.databaseName }}"

PROJECT_ID="${GCP_PROJECT_ID:?Defina a variável GCP_PROJECT_ID}"
ROOT_PASSWORD="${DB_ROOT_PASSWORD:?Defina o secret DB_ROOT_PASSWORD}"

echo "==> Projeto: ${PROJECT_ID} | Instância: ${INSTANCE} (${DB_VERSION}) | Região: ${REGION}"

# 1) Instância — cria só se não existir
if gcloud sql instances describe "${INSTANCE}" --project "${PROJECT_ID}" >/dev/null 2>&1; then
  echo "==> Instância '${INSTANCE}' já existe, pulando criação."
else
  echo "==> Criando instância '${INSTANCE}'..."
  gcloud sql instances create "${INSTANCE}" \
    --project "${PROJECT_ID}" \
    --database-version "${DB_VERSION}" \
    --tier "${TIER}" \
    --region "${REGION}" \
    --edition ENTERPRISE \
    --root-password "${ROOT_PASSWORD}"
fi

# 2) Banco — cria só se não existir
if gcloud sql databases describe "${DB_NAME}" --instance "${INSTANCE}" --project "${PROJECT_ID}" >/dev/null 2>&1; then
  echo "==> Banco '${DB_NAME}' já existe, pulando criação."
else
  echo "==> Criando banco '${DB_NAME}'..."
  gcloud sql databases create "${DB_NAME}" \
    --instance "${INSTANCE}" \
    --project "${PROJECT_ID}"
fi

echo "==> Concluído."
gcloud sql instances describe "${INSTANCE}" --project "${PROJECT_ID}" \
  --format="value(connectionName)"
