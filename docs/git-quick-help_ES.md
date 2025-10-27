# 🗺️ CONCEPTOS y COMANDOS: git más allá de lo elemental

## 🔧 CONFIGURACIÓN ESENCIAL. ALGUNOS NOMBRES ARBITRARIOS QUE USAMOS

### **REPOSITORIOS Y REMOTOS**
```bash
# ESTRUCTURA BÁSICA
RepoU - Upstream = https://git-lab_hub.com/PROYECTO/ORIGINAL.git
RepoF - Tu Fork  = https://git_lab_hub.com/TU_USUARIO/PROYECTO.git  
RepoL - Local -  = Clon de RepoF

# CONFIGURACIÓN INICIAL
git clone https://git-lab_hub.com/TU_USUARIO/PROYECTO.git
cd PROYECTO
git remote add upstream https://git-lab_hub.com/PROYECTO/ORIGINAL.git
```

### **VERIFICACIÓN DE CONFIGURACIÓN**
```bash
git remote -v
# Debe mostrar:
# origin    https://git-lab_hub.com/TU_USUARIO/PROYECTO.git (fetch/push)
# upstream  https://git-lab_hub.com/PROYECTO/ORIGINAL.git (fetch/push)
```

---

## 🔄 SINCRONIZACIÓN FORK - FLUJO COMPLETO

### **FLUJO REAL DE SINCRONIZACIÓN (concepto)**
```
RepoU → [git fetch upstream] → RepoL → [git push origin upstream/main:main] → RepoF
```

### **SINCRONIZACIÓN BÁSICA - 2 PASOS CLAVE - comandos **
```bash
# PASO 1: Traer cambios de RepoU a RepoL
git fetch upstream

# PASO 2: Enviar cambios de RepoL a RepoF  
git push origin upstream/main:main

# EXPLICACIÓN SINTÁXIS:
# git push [DESTINO] [QUÉ_ENVIAR]:[DÓNDE_PONERLO]
# git push origin   upstream/main  : main
#          ↑           ↑              ↑
#          RepoF   Referencia    Branch en
#                  en RepoL        RepoF
```

### **DETALLES TÉCNICOS CRÍTICOS - concepto **
- **`upstream/main`**: No es una branch normal, es una "remote-tracking branch" en tu RepoL
- **`origin`**: Apunta a tu RepoF (configurado automáticamente al clonar)
- **Solo necesitás permisos de lectura** para RepoU, pero **escritura** para RepoF

### **SINCRONIZACIÓN AVANZADA - comandos **
```bash
# MÚLTIPLES BRANCHES
git fetch upstream
git push origin upstream/main:main
git push origin upstream/develop:develop

# SCRIPT AUTOMÁTICO
#!/bin/bash
echo "🔄 Sincronizando fork..."
git fetch upstream
git push origin upstream/main:main
echo "✅ Fork actualizado"
```

### **RESOLUCIÓN DE CONFLICTOS - comandos **
```bash
# Si el push falla (non-fast-forward):
git push --force-with-lease origin upstream/main:main

# Sincronización nuclear (solo para forks muy dañados):
git push --force origin upstream/main:main
```

---

## 💻 FLUJOS DE TRABAJO PRÁCTICOS

### **FLUJO PARA PRINCIPIANTES**
```bash
# 1. Sincronizar fork antes de trabajar
git fetch upstream
git push origin upstream/main:main

# 2. Actualizar local desde fork actualizado
git pull origin main

# 3. Crear feature branch
git checkout -b mi-feature

# 4. Trabajar y commitear...
git add .
git commit -m "Mi cambio"

# 5. Subir al fork
git push origin mi-feature
```

### **FLUJO PARA CONTRIBUCIONES**
```bash
# 1. Sincronizar TODO
git fetch upstream
git push origin upstream/main:main
git checkout main
git pull origin main

# 2. Branch desde main actualizada
git checkout -b fix-issue

# 3. Desarrollo con rebase periódico
git fetch upstream
git rebase upstream/main    # Mantiene historial limpio

# 4. Push para PR (seguro)
git push --force-with-lease origin fix-issue
```

---

## 🧩 GESTIÓN DE PATCHES

### **PATCHES TRADICIONALES (.diff/.patch)**
```bash
# GENERAR
git diff > cambio.patch
git format-patch HEAD~1

# APLICAR
git apply --check cambio.patch    # Verificar sin aplicar
git apply cambio.patch           # Aplicar sin commit
```

### **PATCHES MBOX (B4)**
```bash
# FLUJO COMPLETO B4
b4 am -o ./patches MSG-ID@lista.com    # Descargar
b4 am -l                              # Listar
b4 am -s MSG-ID@lista.com             # Aplicar serie

# APLICACIÓN MANUAL
git am *.patch                       # Aplicar manteniendo metadata
```

### **RESOLUCIÓN CONFLICTOS PATCHES**
```bash
git am --show-current-patch         # Ver patch conflictivo
# Editar archivos manualmente...
git add archivos/
git am --continue
```

---

## 🧹 MANTENIMIENTO Y LIMPIEZA

### **LIMPIEZA DE HISTORIAL**
```bash
# ELIMINAR ARCHIVOS GRANDES
git filter-repo --path archivo-grande.zip --invert-paths

# OPTIMIZACIÓN POST-LIMPIEZA
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```

### **ANÁLISIS DE REPOSITORIO**
```bash
# IDENTIFICAR ARCHIVOS GRANDES
git rev-list --objects --all | \
  git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
  awk '/^blob/ {print substr($0,6)}' | \
  sort --numeric-sort --key=2 | \
  tail -10

# VER ESTADO
git count-objects -v
git gc
```

---

## 🚀 TABLA DECISORIA RÁPIDA

| **ESCENARIO** | **OPERACIÓN** | **COMANDO** |
|---------------|---------------|-------------|
| **Actualizar fork** | Sync básico | `git fetch upstream && git push origin upstream/main:main` |
| **Trabajo en feature** | Branch + desarrollo | `git checkout -b feature && git push origin feature` |
| **Mantener feature actualizada** | Rebase periódico | `git fetch upstream && git rebase upstream/main` |
| **Subir después de rebase** | Push seguro | `git push --force-with-lease origin feature` |
| **Aplicar patches email** | B4 completo | `b4 am -s MSG-ID && git am patches/*.patch` |
| **Recuperar fork corrupto** | Sincronización forzada | `git push --force origin upstream/main:main` |

---

## ⚠️ MEJORES PRÁCTICAS - RECUERDA

### **✅ HACER SIEMPRE:**
- `git fetch upstream` antes de sincronizar
- `--force-with-lease` en lugar de `--force`
- `git apply --check` antes de aplicar patches
- Backup antes de operaciones destructivas

### **❌ EVITAR:**
- Modificar historial ya compartido
- `git push --force` sin `--force-with-lease`
- Operaciones sin entender consecuencias
- Sincronizar sin verificar cambios

### **🔄 REBASE vs MERGE:**
- **REBASE**: Para trabajo local/no-compartido (limpia historial)
- **MERGE**: Para integración colaborativa (preserva historial)

---

## 🎯 RESUMEN EJECUTIVO

**CONFIGURACIÓN:** `git remote add upstream` (una vez)  
**SINCRONIZACIÓN:** Dos comandos mágicos: `fetch upstream` + `push origin upstream/main:main`  
**FLUJO REAL:** RepoU → RepoL → RepoF (RepoL como puente)  
**TRABAJO:** Branch + rebase + push seguro  
**PATCHES:** B4 para email, git apply para locales  
**MANTENIMIENTO:** filter-repo + gc agresivo  

**¡Listo para operaciones de campo!** 🚀
