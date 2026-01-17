#!/usr/bin/env bash
# Hormiga #10 Soberana – Discovery & Identity Injection
# Authority: CLHQ (Cristhiam Leonardo Hernández Quiñonez)

LEDGER="$HOME/HormigasAIS--LBH-Protocol-/protocol_ledger_poc.log"
TIMESTAMP=$(date -u '+%Y-%m-%dT%H:%M:%SZ')
SIGNATURE="\n---\n## 🐜 HormigasAIS - Identidad Soberana\n**Autoridad:** Cristhiam Leonardo Hernández Quiñonez (CLHQ)\n**Protocolo:** LBH-Tx\n**Rastro de Feromonas:** . . . . . . . . . . . . . . . . . ."

echo -e "\n🔭 [HORMIGA 10] INICIANDO ESCANEO DE PROFUNDIDAD [$TIMESTAMP]" >> "$LEDGER"

# Busca todas las carpetas que sean repositorios Git en el HOME
mapfile -t REPOS < <(find "$HOME" -maxdepth 2 -name ".git" -type d -exec dirname {} \;)

for REPO in "${REPOS[@]}"; do
  README="$REPO/README.md"
  if [ -f "$README" ]; then
    if grep -q "Cristhiam Leonardo Hernández Quiñonez" "$README"; then
      echo "✅ [Soberano] $(basename "$REPO")" >> "$LEDGER"
    else
      echo "💉 [Inyectando] Identidad en $(basename "$REPO")" >> "$LEDGER"
      echo -e "$SIGNATURE" >> "$README"
      echo "🩹 [HORMIGA 10] Nodo $(basename "$REPO") rescatado y firmado." >> "$LEDGER"
    fi
  fi
done

echo "🏁 [HORMIGA 10] Escaneo total completado. Sin rincones ocultos." >> "$LEDGER"
echo "---" >> "$LEDGER"
echo "🐜 Hormiga #10: Ecosistema total bajo control CLHQ."
