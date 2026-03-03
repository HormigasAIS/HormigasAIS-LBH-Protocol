#!/bin/bash
# levantar_hormiga_guardian.sh
# Versión ultra silenciosa: alerta solo ante fallos críticos o inactividad prolongada

HORMIGA_DIR=~/HormigasAIS-LBH-Protocol/HormigasAIS-video-intelligence-checker/backend/HormigasAIS_Lab/HormigasAIS.com
LOG_DIR="$HORMIGA_DIR/logs"
ALERTA_SCRIPT="$HORMIGA_DIR/enviar_alerta.py"

MAX_INACTIVITY=300  # segundos, si backend no genera logs en este tiempo, se envía alerta

echo "🐜 Preparando entorno..."
cd $HORMIGA_DIR || { echo "❌ No se puede acceder al directorio"; exit 1; }

# Crear virtualenv si no existe
if [ ! -d "venv" ]; then
    python3 -m venv venv
fi
source venv/bin/activate
pip install --upgrade pip
pip install -r backend/requirements.txt

echo "🐜 Iniciando hormiga guardian..."
while true; do
    echo "🐜 Inicio de backend: $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_DIR/hormiga_supervisor.log"

    # Inicia backend en segundo plano y guarda PID
    bash scripts/start_backend.sh &
    BACKEND_PID=$!

    # Monitoreo silencioso de logs
    LAST_LOG_TIME=$(date +%s)
    while kill -0 $BACKEND_PID 2>/dev/null; do
        sleep 10
        # Chequear si hay logs recientes
        if [ -d "$LOG_DIR" ]; then
            LATEST_LOG=$(find "$LOG_DIR" -type f -name "*.log" -printf "%T@ %p\n" | sort -nr | head -1 | cut -d' ' -f1)
            NOW=$(date +%s)
            INACTIVITY=$((NOW - ${LATEST_LOG%.*}))
            if [ $INACTIVITY -ge $MAX_INACTIVITY ]; then
                echo "⚠️ ALERTA: No hay actividad en logs desde $INACTIVITY segundos" >> "$LOG_DIR/hormiga_supervisor.log"
                [ -f "$ALERTA_SCRIPT" ] && python3 "$ALERTA_SCRIPT" "🐜 ALERTA: Inactividad prolongada de la hormiga ($INACTIVITY s)"
                break
            fi
        fi
    done

    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        echo "❌ ERROR crítico: la hormiga terminó con código $EXIT_CODE" >> "$LOG_DIR/hormiga_supervisor.log"
        [ -f "$ALERTA_SCRIPT" ] && python3 "$ALERTA_SCRIPT" "🐜 ALERTA CRÍTICA: la hormiga terminó inesperadamente con código $EXIT_CODE"
    else
        echo "✅ Reinicio limpio de la hormiga." >> "$LOG_DIR/hormiga_supervisor.log"
    fi

    sleep 10
done

echo "🐜 Supervisión finalizada."
