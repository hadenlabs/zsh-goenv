---
name: jira-sync-filters
description: Skill para sincronizar filtros de Jira con un archivo markdown. Crea, actualiza y reconcilia filtros (incluyendo JQL, description y favourite).
metadata:
  author: "hadenlabs"
  version: "0.0.0"
  opencode:
    emoji: "🔍"
    tags:
      - jira-cloud
      - filters
      - sync
    mcp:
      preferredServer: jira
---

# Jira Sync Filters

Sincroniza filtros de un archivo markdown con los filtros de Jira, incluyendo creación, actualización y reconciliación.

El archivo markdown es el **source of truth**.

---

## Uso de argumentos

Este skill recibe argumentos mediante `{{args}}`.

### 1. String (CLI)

```bash
jira-sync-filters ./docs/jira/filters.md
```

### 2. JSON

```json
{
  "filePath": "./docs/jira/filters.md"
}
```

---

## Resolución de `filePath`

- Si `{{args}}` es string → usar como `filePath`
- Si `{{args}}` es objeto → usar `args.filePath`
- Si no existe → error

---

## Estructura del archivo markdown

```markdown
## Filter: HAD | Critical

- name: HAD | Critical
- jql: project = HAD AND priority = Highest AND status != Done
- description: Critical issues across HAD
- favourite: true
- jiraId: 12345
```

---

## Parámetros

- `filePath` (string, requerido):
  Ruta absoluta o relativa al archivo markdown de componentes.

---

## Overview

1. Resolver `filePath` desde `{{args}}`
2. Validar acceso al archivo
3. Leer markdown
4. Obtener filtros desde Jira
5. Comparar estados
6. Ejecutar reconciliación:
   - Crear
   - Actualizar
   - Agregar desde Jira
7. Escribir archivo actualizado

---

## Implementación esperada

### Validación inicial

- Resolver `filePath`
- Verificar existencia
- Verificar permisos
- Fallar si algo no cumple

---

### Lectura y parsing

- Parsear filtros
- Validar estructura

---

### Obtener estado actual

Usar MCP:

- `jira_search_filters`

---

### Construcción de estructuras

- `fileFiltersById`
- `fileFiltersByName`

---

# Reglas de sincronización

---

## 1. Crear (Markdown → Jira)

Filtros sin `jiraId`

Acción:

- `jira_create_filter`
  - name
  - jql
  - description
  - favourite

- Guardar `jiraId` en archivo

---

## 2. Actualizar (Markdown → Jira)

Filtros con `jiraId`

Comparar:

- `name`
- `jql`
- `description`
- `favourite`

Si hay diferencias:

- `jira_update_filter`

---

## 3. Agregar (Jira → Markdown)

Filtros en Jira que no están en archivo

Acción:

- Agregar al final del markdown
- Incluir:
  - name
  - jql
  - description
  - favourite
  - jiraId

---

## 4. Validar integridad

- Si un `jiraId` del archivo no existe en Jira:
  - Marcar como inconsistencia
  - No eliminar automáticamente
  - Registrar warning

---

# Escritura del archivo

- Mantener orden original
- Insertar nuevos al final
- Preservar formato
- Actualizar `jiraId`

---

# Reglas de comportamiento

- `filePath` obligatorio
- No usar defaults
- No inferir rutas
- No eliminar filtros en Jira
- Markdown = source of truth
- Evitar updates innecesarios
- Normalizar strings (`trim`)
- No asumir configuración de Jira
- MCP resuelve server

---

# Logging esperado

- CREATED
- UPDATED
- SYNCED
- ADDED_FROM_JIRA
- INCONSISTENT

---

# Interpretación de solicitudes

Ejemplos:

- "Sincroniza filtros de Jira con este archivo"
- "Crea filtros desde markdown"
- "Actualiza JQL desde archivo"
- "Trae filtros faltantes"

Siempre implica:

- sync completo

---

# Reglas de ejecución

- Si no hay `filePath`:
  - pedirlo
  - no ejecutar