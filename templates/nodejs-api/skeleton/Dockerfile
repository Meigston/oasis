# syntax=docker/dockerfile:1
FROM node:22-slim

ENV NODE_ENV=production \
    PORT=${{ values.port }}

WORKDIR /app

# Instala dependências primeiro para aproveitar o cache de camadas
COPY package*.json ./
RUN npm install --omit=dev

# Copia o código da aplicação
COPY src/ ./src/

EXPOSE ${{ values.port }}

# node:slim já traz o usuário sem privilégios "node"
USER node

CMD ["node", "src/index.js"]
