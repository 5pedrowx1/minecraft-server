#!/bin/bash
set -e

# Aceita o EULA
echo "eula=true" > eula.txt

# Baixa a versão mais recente do instalador Fabric
FABRIC_INSTALLER_URL="https://meta.fabricmc.net/v2/versions/installer"
LATEST_INSTALLER=$(curl -s $FABRIC_INSTALLER_URL | grep -oP '"version":"\K[^"]+' | head -n 1)
curl -O "https://meta.fabricmc.net/v2/versions/installer/${LATEST_INSTALLER}/fabric-installer-${LATEST_INSTALLER}.jar"

# Instala o servidor para Minecraft 1.21.1
java -jar fabric-installer-${LATEST_INSTALLER}.jar server -mcversion 1.21.1 -downloadMinecraft

# Inicia o servidor
java -Xmx2G -Xms2G -jar fabric-server-launch.jar nogui
