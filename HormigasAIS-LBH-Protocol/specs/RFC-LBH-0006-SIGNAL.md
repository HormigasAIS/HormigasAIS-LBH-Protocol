# RFC-LBH-0006 — Mensaje LBH Estándar entre Nodos

**Estado:** Borrador  
**Versión:** 0.1  
**Autor:** CLHQ — Cristhiam Leonardo Hernández Quiñonez  
**Fecha:** 2026-03-12  
**Repo:** LBH-Net  

## Motivación

Los nodos LBH (Termux, Gitea, GitHub) operan con scripts
independientes. Este RFC define un formato de mensaje común
que permite a cualquier nodo entender y validar señales LBH
sin depender de implementación específica.

## Formato del Mensaje
LBH://SIGNAL
version: 1.1
node: <termux|gitea|github>
action: <sign|verify|replicate|publish>
asset: <nombre_archivo>
hash: 
timestamp: 
sig: 
issued_by: CLHQ
## Acciones Válidas

| Acción | Nodo origen | Descripción |
|---|---|---|
| sign | termux | Firma un activo con LBH |
| verify | cualquiera | Verifica integridad del activo |
| replicate | gitea | Replica hacia GitHub |
| publish | github | Publica identidad global |

## Ejemplo Real
LBH://SIGNAL
version: 1.1
node: termux
action: sign
asset: REPORTE_RENDIMIENTO_HORMIGAS.png
hash: 978573716282ac69...
timestamp: 1773377360
sig: 1603c360f76d76d9...
issued_by: CLHQ
## Validación

Un mensaje LBH es válido si:
1. `version` es 1.0 o superior
2. `node` es uno de los nodos registrados
3. `hash` coincide con SHA256 del activo
4. `sig` es HMAC-SHA256 verificable
5. `timestamp` no supera 300 segundos de diferencia

## Relación con RFC anteriores

| RFC | Contenido |
|---|---|
| RFC-LBH-0001 | Estructura base del protocolo |
| RFC-LBH-0005 | Seguridad y anti-replay |
| RFC-LBH-0006 | Mensaje estándar entre nodos ← este |

## Estado de implementación

- [x] Formato definido
- [x] Ejemplo real validado
- [ ] Parser en Python
- [ ] Integración con bridge_centinela
- [ ] Integración con lbh-node-service
