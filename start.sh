#!/bin/bash
set -e

# Aceita o EULA
echo "eula=true" > eula.txt

# Baixa a versão mais recente do instalador Fabric
FABRIC_INSTALLER_URL="https://meta.fabricmc.net/v2/versions/installer"
LATEST_INSTALLER=$(curl -s $FABRIC_INSTALLER_URL | jq -r '.[0].version')

echo "Using Fabric Installer version: ${LATEST_INSTALLER}"

# Baixa o instalador
curl -OL "https://maven.fabricmc.net/net/fabricmc/fabric-installer/${LATEST_INSTALLER}/fabric-installer-${LATEST_INSTALLER}.jar"

if [ ! -f "fabric-installer-${LATEST_INSTALLER}.jar" ]; then
    echo "Failed to download Fabric installer"
    exit 1
fi

echo "Installing Fabric server for Minecraft 1.21.1..."

# Instala o servidor
java -jar fabric-installer-${LATEST_INSTALLER}.jar server -mcversion 1.21.1 -downloadMinecraft

if [ ! -f "fabric-server-launch.jar" ]; then
    echo "Failed to install Fabric server"
    exit 1
fi

echo "Starting Minecraft server..."

java -Xmx1G -Xms1G \
  -XX:+UseG1GC \
  -XX:+ParallelRefProcEnabled \
  -XX:MaxGCPauseMillis=200 \
  -XX:+UnlockExperimentalVMOptions \
  -XX:+DisableExplicitGC \
  -XX:G1NewSizePercent=30 \
  -XX:G1MaxNewSizePercent=40 \
  -XX:G1HeapRegionSize=8M \
  -XX:G1ReservePercent=20 \
  -XX:G1HeapWastePercent=5 \
  -XX:G1MixedGCCountTarget=4 \
  -XX:InitiatingHeapOccupancyPercent=15 \
  -XX:G1MixedGCLiveThresholdPercent=90 \
  -XX:SurvivorRatio=32 \
  -jar fabric-server-launch.jar nogui
