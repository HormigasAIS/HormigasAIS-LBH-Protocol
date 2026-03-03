#!/bin/bash
# 🐜 LBH | Script de renombrado + auditoría completa
# Autor: CLHQ
# Propósito: renombrar carpeta antigua y validar archivos, subcarpetas y contenido mínimo

OLD_DIR="$HOME/HormigasAIS--LBH-Protocol-"
NEW_DIR="$HOME/HormigasAIS-LBH-Protocol"
LOG_FILE="$NEW_DIR/logs/rename_catheter_audit.log"

# Crear carpeta de logs si no existe
mkdir -p "$(dirname "$LOG_FILE")"

# Función para verificar archivos esenciales en un directorio
check_files() {
    local dir="$1"
    local -n files_ref=$2
    local missing=0

    echo "🔍 Validando archivos en $dir ..." | tee -a "$LOG_FILE"
    for file in "${files_ref[@]}"; do
        if [ ! -f "$dir/$file" ]; then
            echo "⚠️ Archivo faltante: $file" | tee -a "$LOG_FILE"
            missing=$((missing+1))
        else
            echo "✅ Encontrado: $file" | tee -a "$LOG_FILE"
        fi
    done

    return $missing
}

# Función para verificar subcarpetas esenciales
check_dirs() {
    local parent_dir="$1"
    local -n dirs_ref=$2
    local missing=0

    echo "🔍 Validando subcarpetas en $parent_dir ..." | tee -a "$LOG_FILE"
    for d in "${dirs_ref[@]}"; do
        if [ ! -d "$parent_dir/$d" ]; then
            echo "⚠️ Subcarpeta faltante: $d" | tee -a "$LOG_FILE"
            missing=$((missing+1))
        else
            echo "✅ Subcarpeta presente: $d" | tee -a "$LOG_FILE"
        fi
    done

    return $missing
}

# Función para validar contenido mínimo en subcarpetas críticas
check_subfolder_content() {
    local parent_dir="$1"
    local -n subfolders_ref=$2
    local missing=0

    echo "🔍 Validando contenido interno de subcarpetas críticas ..." | tee -a "$LOG_FILE"
    for subfolder in "${!subfolders_ref[@]}"; do
        for file in "${subfolders_ref[$subfolder][@]}"; do
            if [ ! -f "$parent_dir/$subfolder/$file" ]; then
                echo "⚠️ Faltante en $subfolder: $file" | tee -a "$LOG_FILE"
                missing=$((missing+1))
            else
                echo "✅ Presente en $subfolder: $file" | tee -a "$LOG_FILE"
            fi
        done
    done

    return $missing
}

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

# Contenido mínimo esperado en subcarpetas críticas
declare -A subfolder_content
subfolder_content["XOXO-"]=("config.lbh" "manager_alpha.py")
subfolder_content["Lenguaje-Binario-HormigasAIS-"]=("LBH-Tx-SPEC.md" "README.md")
subfolder_content["xoxo-lbh-adapter"]=("adapter_config.human" "adapter_main.py")
subfolder_content["HormigasAIS-Nodo-Escuela"]=("config_node_video.human" "enter_lab.sh")

# Renombrar carpeta si existe
if [ -d "$OLD_DIR" ]; then
    echo "🔄 Preparando renombrado..." | tee -a "$LOG_FILE"
    mv "$OLD_DIR" "$NEW_DIR" 2>>"$LOG_FILE"
    echo "✅ Carpeta renombrada con éxito:" | tee -a "$LOG_FILE"
    echo "   De: $OLD_DIR" | tee -a "$LOG_FILE"
    echo "   A:   $NEW_DIR" | tee -a "$LOG_FILE"
else
    echo "⚠️ Carpeta antigua no encontrada: $OLD_DIR" | tee -a "$LOG_FILE"
    exit 1
fi

# Validar archivos en raíz
check_files "$NEW_DIR" essential_files
files_missing=$?

# Validar subcarpetas
check_dirs "$NEW_DIR" essential_dirs
dirs_missing=$?

# Validar contenido mínimo de subcarpetas críticas
check_subfolder_content "$NEW_DIR" subfolder_content
content_missing=$?

# Resumen final
echo "--------------------------------------------------" | tee -a "$LOG_FILE"
if [ $files_missing -eq 0 ] && [ $dirs_missing -eq 0 ] && [ $content_missing -eq 0 ]; then
    echo "🎯 Auditoría completa exitosa. Todos los archivos, subcarpetas y contenidos mínimos presentes." | tee -a "$LOG_FILE"
else
    echo "❌ Auditoría incompleta. Revisar alertas anteriores." | tee -a "$LOG_FILE"
fi
echo "🛡️ Operación LBH-CATETER FINALIZADA." | tee -a "$LOG_FILE"
