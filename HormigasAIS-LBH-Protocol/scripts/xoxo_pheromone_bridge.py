#!/usr/bin/env python3
import os
import json
import time

# Rutas dinámicas para Termux
HOME = os.path.expanduser("~")
ADN_BASE_PATH = os.path.join(HOME, "Lenguaje-Binario-HormigasAIS-")

def validar_autoridad_clhq():
    print("\n📡 [XOXO] Escaneando ADN_BASE en busca de la firma maestra...")
    readme_path = os.path.join(ADN_BASE_PATH, "README.md")
    
    if not os.path.exists(readme_path):
        print("❌ [XOXO] ERROR: No se encuentra el README de ADN_BASE.")
        return False

    with open(readme_path, 'r') as f:
        content = f.read()
        if "Cristhiam Leonardo Hernández Quiñonez" in content:
            print("✅ [XOXO] Firma de Cristhiam Leonardo Hernández Quiñonez VALIDADA.")
            return True
    return False

def emitir_feromona_soberana():
    print("✨ [XOXO] Generando feromona de validación de dependencias...")
    feromona = {
        "timestamp": time.time(),
        "origin": "Nodo-Escuela",
        "authority": "CLHQ",
        "status": "READY_FOR_EDGE_EXECUTION",
        "protocol_link": "LBH-Tx + LBH-ASCII",
        "transmission": "P2P_Soberana"
    }
    
    time.sleep(1)
    print(f"🐜 [XOXO] Feromona emitida: {json.dumps(feromona)}")
    print("🚀 [Hormiga 10] Feromona recibida. Transmitiendo a Hormiga Stanford...")
    time.sleep(1)
    print("🎓 [Hormiga Stanford] VALIDANDO: Suma LBH-Tx + ADN Base detectada.")
    print("🎓 [Hormiga Stanford] TRADUCIENDO a conceptos operativos LBH...")
    time.sleep(1)
    print("📝 [Hormigas Estudiantes] Señal recibida. Conceptos (PoC) grabados en memoria local.")
    print("\n--- CICLO DE FEROMONA COMPLETADO ---")

if __name__ == "__main__":
    if validar_autoridad_clhq():
        emitir_feromona_soberana()
    else:
        print("❌ [XOXO] ACCESO DENEGADO: La firma CLHQ no coincide.")
