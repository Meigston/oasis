from fastapi import FastAPI

app = FastAPI(
    title="${{ values.appName }}",
    description="${{ values.description }}",
    version="0.1.0",
)


@app.get("/health")
def health() -> dict[str, str]:
    """Liveness/readiness probe."""
    return {"status": "healthy"}


@app.get("/")
def root() -> dict[str, str]:
    return {"service": "${{ values.appName }}", "status": "running"}
