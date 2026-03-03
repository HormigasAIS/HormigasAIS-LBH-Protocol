#!/bin/bash
# Protocolo de Transferencia HormigasAIS
# Orquestador: Cristhiam Leonardo Hernández Quiñonez

echo "📡 Iniciando transferencia de Protocolo de Rescate al Nodo-Escuela..."

DESTINO="/data/data/com.termux/files/home/HormigasAIS_Core/HormigasAIS-video-intelligence-checker/HormigasAIS-Nodo-Escuela/contracts"

# 1. Asegurar que el directorio de contratos existe
mkdir -p $DESTINO

# 2. "Compilar" simbólicamente el protocolo a WASM (Sello de Soberanía)
# Nota: Usamos el código de rescue_protocol.py como base del contrato
cp rescue_protocol.py $DESTINO/rescue_protocol.wasm

# 3. Asignar permisos de ejecución soberana
chmod +x $DESTINO/rescue_protocol.wasm
chmod +x /data/data/com.termux/files/home/HormigasAIS-LBH-Protocol-mirror/xoxo-lbh-adapter/protocolo_emergencia.sh

echo "✅ Protocolo desplegado en: $DESTINO/rescue_protocol.wasm"
echo "🐜 [LBH] El Nodo-Escuela ahora posee la capacidad de Rescate L3."
