#!/bin/bash
set -e

# Aceita o EULA
echo "eula=true" > eula.txt

# Baixa a versão mais recente do instalador Fabric
FABRIC_INSTALLER_URL="https://meta.fabricmc.net/v2/versions/installer"
LATEST_INSTALLER=$(curl -s $FABRIC_INSTALLER_URL | jq -r '.[0].version')

echo "Using Fabric Installer version: ${LATEST_INSTALLER}"

# Baixa o instalador (URL correto do Maven)
curl -OL "https://maven.fabricmc.net/net/fabricmc/fabric-installer/${LATEST_INSTALLER}/fabric-installer-${LATEST_INSTALLER}.jar"

# Verifica se o download foi bem-sucedido
if [ ! -f "fabric-installer-${LATEST_INSTALLER}.jar" ]; then
    echo "Failed to download Fabric installer"
    exit 1
fi

echo "Installing Fabric server for Minecraft 1.21.1..."

# Instala o servidor para Minecraft 1.21.1
java -jar fabric-installer-${LATEST_INSTALLER}.jar server -mcversion 1.21.1 -downloadMinecraft

# Verifica se o servidor foi instalado
if [ ! -f "fabric-server-launch.jar" ]; then
    echo "Failed to install Fabric server"
    exit 1
fi

echo "Starting Minecraft server..."

# Inicia o servidor
java -Xmx2G -Xms2G -jar fabric-server-launch.jar nogui
