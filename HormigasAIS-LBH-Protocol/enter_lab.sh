#!/data/data/com.termux/files/usr/bin/bash

# Entrar al laboratorio XOXO-LBH-Adapter
echo "📦 Bienvenido al laboratorio XOXO-LBH-Adapter"

# Directorio base
LAB_DIR="$HOME/xoxo-lbh-adapter"
cd "$LAB_DIR" || exit
echo "Directorio actual: $PWD"

# Variables LBH
export LBH_BIN_ROOT="$LAB_DIR/lbh_bin_module"
export LBH_BIN_INCLUDE="$LBH_BIN_ROOT/include"
export LBH_BIN_SRC="$LBH_BIN_ROOT/src"
export PYBIND_INCLUDE=$(python3 -m pybind11 --includes)
export OUTPUT="$LBH_BIN_ROOT/lbh_module.so"

echo "Variables LBH listas para compilación/importación en Python"

# Compilación automática del módulo LBH
echo "🔧 Compilando LBH Binario HormigasAIS..."
c++ -O3 -Wall -shared -std=c++17 -fPIC \
    $PYBIND_INCLUDE \
    -I$LBH_BIN_INCLUDE \
    $LBH_BIN_SRC/lbh_module.cpp \
    -o $OUTPUT

if [ $? -eq 0 ]; then
    echo "✅ Compilación exitosa: $OUTPUT"
else
    echo "❌ Error en la compilación"
fi

