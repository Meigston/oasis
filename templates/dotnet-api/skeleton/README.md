# ${{ values.appName }}

${{ values.description }}

API .NET 10 (Minimal API) criada a partir do Backstage Developer Portal
(template **.NET API**).

## Endpoints

| Método | Rota      | Descrição                             |
| ------ | --------- | ------------------------------------- |
| GET    | `/health` | Health check (`{"status":"healthy"}`) |
| GET    | `/`       | Informações básicas do serviço        |

## Rodando localmente

```bash
dotnet run
```

Por padrão sobe em `http://localhost:5000`. Para usar a porta de produção:

```bash
ASPNETCORE_URLS=http://+:${{ values.port }} dotnet run
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
