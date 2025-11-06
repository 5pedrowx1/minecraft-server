#!/bin/bash
set -e

# Aceita o EULA
echo "eula=true" > eula.txt

# Escolhe a versão mais recente do Fabric
FABRIC_INSTALLER_URL="https://meta.fabricmc.net/v2/versions/installer"
FABRIC_INSTALLER_VERSION=$(curl -s $FABRIC_INSTALLER_URL | jq -r '.[0].version')
curl -O https://meta.fabricmc.net/v2/versions/installer/${FABRIC_INSTALLER_VERSION}/fabric-installer-${FABRIC_INSTALLER_VERSION}.jar

# Instala o servidor para Minecraft 1.21.1
java -jar fabric-installer-${FABRIC_INSTALLER_VERSION}.jar server -mcversion 1.21.1 -downloadMinecraft

# Inicia o servidor
java -Xmx2G -Xms2G -jar fabric-server-launch.jar nogui
