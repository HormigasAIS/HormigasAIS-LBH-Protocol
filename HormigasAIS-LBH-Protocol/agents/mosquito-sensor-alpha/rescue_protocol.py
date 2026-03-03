import subprocess
import os

def trigger_rescue():
    print("🐜 [LBH-RESCUE] Ejecutando Contrato de Emergencia L3...")
    # Ruta al protocolo que acabamos de leer
    emergency_script = "/data/data/com.termux/files/home/HormigasAIS-LBH-Protocol-mirror/xoxo-lbh-adapter/protocolo_emergencia.sh"
    
    try:
        # Ejecutamos la recuperación soberana
        result = subprocess.run(['bash', emergency_script, 'recovery'], capture_output=True, text=True)
        print(result.stdout)
        if result.returncode == 0:
            print("🚀 [MISION CUMPLIDA] Nodo Lightning restablecido por HormigasAIS.")
        else:
            print("❌ [FALLO] El protocolo de emergencia no encontró el respaldo.")
    except Exception as e:
        print(f"⚠️ Error de sistema: {e}")

if __name__ == "__main__":
    trigger_rescue()
