#!/bin/bash
# 🐜 LBH-CATETER | Renombrado de carpeta con trazabilidad

# --- Variables ---
ORIG_PATH="$HOME/HormigasAIS--LBH-Protocol-"
NEW_PATH="$HOME/HormigasAIS-LBH-Protocol"
LOG_FILE="$HOME/HormigasAIS--LBH-Protocol-/rename_catheter.log"

# --- Catéter de lectura ---
if [ ! -d "$ORIG_PATH" ]; then
    echo "⚠️ Ruta original no encontrada: $ORIG_PATH" | tee -a "$LOG_FILE"
    exit 1
fi

# --- Catéter de transformación ---
echo "🔄 Preparando renombrado..." | tee -a "$LOG_FILE"

# --- Catéter de escritura / ejecución ---
mv "$ORIG_PATH" "$NEW_PATH"
if [ $? -eq 0 ]; then
    echo "✅ Carpeta renombrada con éxito:" | tee -a "$LOG_FILE"
    echo "   De: $ORIG_PATH" | tee -a "$LOG_FILE"
    echo "   A:   $NEW_PATH" | tee -a "$LOG_FILE"
else
    echo "❌ Error al renombrar la carpeta" | tee -a "$LOG_FILE"
    exit 2
fi

# --- Validación ---
if [ -d "$NEW_PATH" ]; then
    echo "🛡️ Validación completada: carpeta disponible en nueva ruta." | tee -a "$LOG_FILE"
else
    echo "⚠️ Validación fallida: carpeta no encontrada en nueva ruta." | tee -a "$LOG_FILE"
    exit 3
fi

echo "🐜 Operación LBH-CATETER finalizada." | tee -a "$LOG_FILE"
