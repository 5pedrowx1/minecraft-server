FROM eclipse-temurin:21-jdk-jammy

# Instala jq para processar JSON
RUN apt-get update && apt-get install -y jq && rm -rf /var/lib/apt/lists/*

# Cria diretório de trabalho
WORKDIR /app

# Copia os arquivos do projeto
COPY . .

# Garante permissão de execução
RUN chmod +x start.sh

# Exposição da porta padrão do Minecraft
EXPOSE 25565

# Comando para iniciar o servidor
CMD ["./start.sh"]
