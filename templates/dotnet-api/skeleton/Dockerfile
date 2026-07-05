# syntax=docker/dockerfile:1

# ---- build ----
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# Restaura dependências primeiro (melhor cache)
COPY ["${{ values.appName }}.csproj", "./"]
RUN dotnet restore "${{ values.appName }}.csproj"

# Copia o restante e publica
COPY . .
RUN dotnet publish "${{ values.appName }}.csproj" -c Release -o /app/publish --no-restore

# ---- runtime ----
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app

ENV ASPNETCORE_URLS=http://+:${{ values.port }}

COPY --from=build /app/publish .

EXPOSE ${{ values.port }}

# Usuário sem privilégios já definido nas imagens .NET 8+
USER $APP_UID

ENTRYPOINT ["dotnet", "${{ values.appName }}.dll"]
