#!/bin/bash
# 🐜 LBH — Auditoría Interactiva Final
# Autor: CLHQ
# Estándar: Silencioso · Sobrio · Termux-safe
# UX: (1/2/3) con tokens inferidos internamente

set -o nounset
set -o pipefail

ROOT_DIR="$HOME/HormigasAIS-LBH-Protocol"
LOG_DIR="$ROOT_DIR/logs"
mkdir -p "$LOG_DIR"

LOG_FILE="$LOG_DIR/audit_$(date '+%Y%m%d_%H%M%S').log"

# ---------------------------
# Tokens internos (NO UX)
# ---------------------------
TOKEN_ULTRA="1#"
TOKEN_IMPROVED="2@"
TOKEN_COLOR="3!"

# ---------------------------
# UX limpia (Termux-style)
# ---------------------------
echo
echo "Selecciona tipo de auditoría:"
echo "  1) Ultra-light   (rápida, log simple)"
echo "  2) Mejorada      (resumen + detalles)"
echo "  3) Colores       (resumen + detalles + colores)"
echo
read -r -p "Opción [1/2/3]: " USER_CHOICE
echo

# ---------------------------
# Inferencia segura de token
# ---------------------------
case "$USER_CHOICE" in
    1) INTERNAL_TOKEN="$TOKEN_ULTRA" ;;
    2) INTERNAL_TOKEN="$TOKEN_IMPROVED" ;;
    3) INTERNAL_TOKEN="$TOKEN_COLOR" ;;
    *)
        echo "❌ Opción inválida." | tee "$LOG_FILE"
        exit 1
        ;;
esac

# ---------------------------
# Ejecución controlada
# ---------------------------
echo "🔹 Auditoría LBH iniciada" | tee "$LOG_FILE"
echo "🔹 Modo seleccionado: $USER_CHOICE" >> "$LOG_FILE"

case "$INTERNAL_TOKEN" in

    "$TOKEN_ULTRA")
        echo "→ Ejecutando Ultra-light" | tee -a "$LOG_FILE"
        bash "$ROOT_DIR/rename_catheter_audit.sh" ultra  >> "$LOG_FILE" 2>&1
        ;;

    "$TOKEN_IMPROVED")
        echo "→ Ejecutando Mejorada" | tee -a "$LOG_FILE"
        bash "$ROOT_DIR/rename_catheter_audit.sh" improved >> "$LOG_FILE" 2>&1
        ;;

    "$TOKEN_COLOR")
        echo "→ Ejecutando Colores" | tee -a "$LOG_FILE"
        bash "$ROOT_DIR/rename_catheter_audit_termux.sh" color >> "$LOG_FILE" 2>&1
        ;;

esac

echo "🛡️ Auditoría completada." | tee -a "$LOG_FILE"
echo "📄 Log: $LOG_FILE"
