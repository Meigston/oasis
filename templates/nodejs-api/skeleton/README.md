# ${{ values.appName }}

${{ values.description }}

API Node.js construída com [Express](https://expressjs.com/), criada a partir do
Backstage Developer Portal (template **Node.js API**).

## Endpoints

| Método | Rota      | Descrição                             |
| ------ | --------- | ------------------------------------- |
| GET    | `/health` | Health check (`{"status":"healthy"}`) |
| GET    | `/`       | Informações básicas do serviço        |

## Rodando localmente

```bash
npm install
npm start
```

Acesse: http://localhost:${{ values.port }}/health

## Docker

```bash
docker build -t ${{ values.appName }} .
docker run -p ${{ values.port }}:${{ values.port }} ${{ values.appName }}
```

## CI/CD

O pipeline em `.github/workflows/ci-cd.yml` builda a imagem Docker e publica no
**Google Artifact Registry** a cada push na branch `main`.

Configure no repositório:

**Secret**

- `GCP_KEY` — JSON da service account com permissão de escrita no Artifact Registry.

**Variables**

- `GCP_PROJECT_ID`
- `GCP_REGION` — ex. `us-central1`
- `GCP_ARTIFACT_REPOSITORY`
