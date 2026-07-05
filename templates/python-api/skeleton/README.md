# ${{ values.appName }}

${{ values.description }}

API Python construída com [FastAPI](https://fastapi.tiangolo.com/), criada a partir do
Backstage Developer Portal (template **Python API**).

## Endpoints

| Método | Rota      | Descrição                       |
| ------ | --------- | ------------------------------- |
| GET    | `/health` | Health check (`{"status":"healthy"}`) |
| GET    | `/`       | Informações básicas do serviço  |

## Rodando localmente

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload --app-dir src --port ${{ values.port }}
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

Para funcionar, configure no repositório:

**Secret**

- `GCP_KEY` — JSON da service account com permissão de escrita no Artifact Registry.

**Variables** (Settings → Secrets and variables → Actions → Variables)

- `GCP_PROJECT_ID`
- `GCP_REGION` — ex. `us-central1`
- `GCP_ARTIFACT_REPOSITORY` — nome do repositório no Artifact Registry
