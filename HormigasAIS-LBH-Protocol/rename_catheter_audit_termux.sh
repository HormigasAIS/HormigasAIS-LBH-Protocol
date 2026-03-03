#!/bin/bash
# 🐜 LBH | Auditoría simple para Termux/Bash 3.x

BASE_DIR="$HOME/HormigasAIS-LBH-Protocol"
LOG_FILE="$BASE_DIR/logs/rename_catheter_audit_termux.log"

mkdir -p "$(dirname "$LOG_FILE")"

# Archivos esenciales en raíz
essential_files=(
    "MANIFIESTO_SOBERANIA_v1.md"
    "MANIFIESTO_SOBERANIA_v1.html"
    "CONTRACT_HUMAN.lbh"
    "EVALUATION_L3.lbh"
    "HormigasAIS-Despliegue-Total.sh"
    "enter_lab.sh"
    "fiscalizacion_protocolo.lbh"
    "config.human"
    "config_adapter.human"
    "config_node_video.human"
    "core_fiscalizacion.lbh"
    "feromona_pitch_semilla.lbh"
)

# Subcarpetas esenciales
essential_dirs=(
    "HormigasAIS-Commercial-Showcase"
    "HormigasAIS-Investment-Kit"
    "HormigasAIS-LBH-EnergySolar"
    "HormigasAIS-Nodo-Escuela"
    "HormigasAIS-Protocol-Node"
    "HormigasAIS-video-intelligence-checker"
    "Lenguaje-Binario-HormigasAIS-"
    "XOXO-"
    "xoxo-lbh-adapter"
)

echo "🔍 Validando archivos en $BASE_DIR ..." | tee -a "$LOG_FILE"
missing_files=0
for file in "${essential_files[@]}"; do
    if [ ! -f "$BASE_DIR/$file" ]; then
        echo "⚠️ Archivo faltante: $file" | tee -a "$LOG_FILE"
        missing_files=$((missing_files+1))
    else
        echo "✅ Encontrado: $file" | tee -a "$LOG_FILE"
    fi
done

echo "🔍 Validando subcarpetas en $BASE_DIR ..." | tee -a "$LOG_FILE"
missing_dirs=0
for d in "${essential_dirs[@]}"; do
    if [ ! -d "$BASE_DIR/$d" ]; then
        echo "⚠️ Subcarpeta faltante: $d" | tee -a "$LOG_FILE"
        missing_dirs=$((missing_dirs+1))
    else
        echo "✅ Subcarpeta presente: $d" | tee -a "$LOG_FILE"
    fi
done

# Contenido mínimo de subcarpetas críticas
declare -a XOXO_files=("config.lbh" "manager_alpha.py")
declare -a LBH_files=("LBH-Tx-SPEC.md" "README.md")
declare -a adapter_files=("adapter_config.human" "adapter_main.py")
declare -a Nodo_files=("config_node_video.human" "enter_lab.sh")

check_subfolder() {
    local folder="$1"
    shift
    local files=("$@")
    for f in "${files[@]}"; do
        if [ ! -f "$BASE_DIR/$folder/$f" ]; then
            echo "⚠️ Faltante en $folder: $f" | tee -a "$LOG_FILE"
        else
            echo "✅ Presente en $folder: $f" | tee -a "$LOG_FILE"
        fi
    done
}

echo "🔍 Validando contenido mínimo en subcarpetas críticas ..." | tee -a "$LOG_FILE"
check_subfolder "XOXO-" "${XOXO_files[@]}"
check_subfolder "Lenguaje-Binario-HormigasAIS-" "${LBH_files[@]}"
check_subfolder "xoxo-lbh-adapter" "${adapter_files[@]}"
check_subfolder "HormigasAIS-Nodo-Escuela" "${Nodo_files[@]}"

echo "--------------------------------------------------" | tee -a "$LOG_FILE"
echo "🛡️ Auditoría Termux completada." | tee -a "$LOG_FILE"
