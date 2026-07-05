# syntax=docker/dockerfile:1
FROM python:3.12-slim

# Evita .pyc e garante logs sem buffer
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=${{ values.port }}

WORKDIR /app

# Instala dependências primeiro para aproveitar o cache de camadas
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copia o código da aplicação
COPY src/ ./src/

EXPOSE ${{ values.port }}

# Roda como usuário sem privilégios
RUN useradd --create-home --uid 1000 appuser
USER appuser

CMD ["sh", "-c", "uvicorn app.main:app --host 0.0.0.0 --port ${PORT} --app-dir src"]
