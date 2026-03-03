#!/bin/bash
# 🐜 HormigasAIS - Sincronización Transversal de Nodos
# Autor: Cristhiam Leonardo Hernández Quiñonez (CLHQ)

echo "🚀 Iniciando despliegue desde el Nodo Maestro..."

# 1. Configuración de Video Intelligence Checker
mkdir -p ~/HormigasAIS-video-intelligence-checker/config
echo "{\"modulo\":\"VIDEO_INTEL\", \"protocolo\":\"LBH\", \"estado\":\"VINCULADO\"}" > ~/HormigasAIS-video-intelligence-checker/config/status.lbh

# 2. Configuración del Nodo Escuela (Visualizadores)
cat << 'V_EOF' > ~/HormigasAIS-Nodo-Escuela/visualizador_directo.py
import pandas as pd
import matplotlib.pyplot as plt
import os

def generar_grafico_vinculado():
    try:
        df = pd.read_csv('visual_demo_stream.csv', skipinitialspace=True)
        df.columns = df.columns.str.strip()
        plt.figure(figsize=(10,6))
        plt.plot(df['FECHA_HORA'], df['DATO_VALOR'], marker='o', color='#00ffcc', linewidth=2)
        plt.title('HormigasAIS - Pulso de Inteligencia Soberana')
        plt.savefig('REPORTE_RENDIMIENTO_HORMIGAS.png')
        print("🎨 Gráfico actualizado en Nodo Escuela.")
    except Exception as e:
        print(f"❌ Error visual: {e}")

if __name__ == "__main__":
    generar_grafico_vinculado()
V_EOF

# 3. Actualización del README Maestro (Soberanía Visible)
cat << 'R_EOF' > ~/HormigasAIS-Nodo-Escuela/README.md
# 🐜 HormigasAIS - Nodo Escuela
🛡️ **Infraestructura de Inteligencia Distribuida Soberana**

### 📊 Estado del Enjambre
- **Protocolo:** LBH (Lenguaje Binario HormigasAIS)
- **Autoridad Raíz:** lbh.human
- **Estado:** ✅ ANTIFRÁGIL

![Gráfico de Rendimiento](REPORTE_RENDIMIENTO_HORMIGAS.png)

*Cerrado por Auditoría de Cristhiam Leonardo Hernández Quiñonez (CLHQ)*
R_EOF

# 4. Sincronización del Adapter (xoxo-lbh-adapter)
# Copiamos el validador maestro para que no haya discrepancias
cp ~/HormigasAIS-Nodo-Escuela/actualizar_csv.py ~/HormigasAIS-Nodo-Escuela/xoxo-lbh-adapter/ 2>/dev/null || echo "Info: Adapter directo en raíz."

# 5. Commit y Push Universal
cd ~/HormigasAIS-Nodo-Escuela
git add .
git commit -m "🌐 TOTAL_SYNC: Video, Escuela, Visual y Adapter unificados por el Maestro | PUSH_OK" --quiet
git push origin main --force

echo "🏁 [DESPLIEGUE COMPLETADO] La colonia es ahora una entidad única y coherente."
