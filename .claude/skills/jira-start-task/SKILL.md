---
name: jira-start-task
description: Selecciona un issue de Jira, genera un prompt OpenSpec usando el template local del skill y crea/usa un branch feature/<ISSUE-KEY>.
license: Proprietary
metadata:
  author: "hadenlabs"
  version: "0.0.0"
  opencode:
    emoji: 🎯
    triggers:
      - "usa el skill jira-start-task"
      - "empezar tarea jira"
      - "trabajar en issue"
      - "generar prompt openspec"
    tags:
      - jira-cloud
      - git
      - workflow
      - openspec
    mcp:
      preferredServer: jira
---

# jira-start-task

Inicia el trabajo sobre un issue de Jira seleccionándolo o proporcionando su clave, genera un prompt para OpenSpec usando el template local del skill y prepara el branch correspondiente en git.

---

## Trigger phrases

El humano puede invocar este skill usando frases como:

- "usa el skill jira-start-task"
- "quiero empezar una tarea de Jira"
- "trae mis issues pendientes"
- "genera el prompt para OpenSpec desde Jira"
- "crea el branch para este issue"
- "trabajar en issue AR-123"

## Inputs

- `issueKey` (string, optional)

---

## Template Resolution

El template SIEMPRE vive junto al skill:

```
<skill_root>/prompt.md.tpl
```

Donde `<skill_root>` es el directorio donde se encuentra este archivo.

### Reglas

- El archivo es obligatorio
- No existe fallback
- No se buscan otros paths

Si no existe:

```
prompt.md.tpl not found in skill directory.
```

---

## Flow

### 1. Resolve Issue

#### Si `issueKey` es proporcionado

- Fetch directo vía MCP (Jira)

#### Si NO (modo interactivo)

- Validar `jasper.toml`
- Leer `issueTracking.projectKey`

Si no existe:

```

jasper.toml not found. Provide issueKey or configure projectKey.

```

- Ejecutar JQL:

```sql
project = <PROJECT_KEY>
AND assignee = currentUser()
AND statusCategory != Done
ORDER BY updated DESC
```

- Mostrar lista
- Usuario selecciona issue

---

### 2. Fetch Issue

Obtener:

- key
- title
- description (markdown)

Si falla:

```
Jira issue <ISSUE-KEY> could not be fetched.
```

---

### 3. Parsing

Buscar headings (case-insensitive):

- Scenario
- Acceptance Tests
- Acceptance Criteria
- Sources

Si no se encuentran headings claros:

- usar `raw_description` como fallback
- no fallar el flujo

---

### 4. Extracción de contenido (NO transformación rígida)

Extraer contenido sin imponer semántica de especificación.

#### Scenario

- Extraer texto bajo heading
- Mantener estructura original (párrafos, bullets)

Fallback:

- usar toda la descripción

---

#### Acceptance Tests

- Extraer lista de ítems
- Mantener formato original (Gherkin, bullets, etc.)

---

#### Sources

- Extraer links o referencias
- Sin transformación

---

### 5. Data Contract (RAW, orientado a prompt)

```yaml
issue:
  key: string
  title: string

content:
  scenario: string
  acceptance_tests: string[]
  sources: string[]
  raw_description: string
```

---

### 6. Git

Branch:

```
feature/<ISSUE-KEY>
```

Reglas:

- No existe → crear + checkout
- Existe → solo checkout

---

### 7. Render Template

- Leer:

```
<skill_root>/prompt.md.tpl
```

- Renderizar usando el contrato `content`
- Sintaxis tipo mustache

Si falla el render:

- mostrar error
- NO generar archivo
- NO continuar flujo

---

### 8. Output

```
docs/prompts/openspec/<ISSUE-KEY>.md
```

---

### 9. Idempotencia

- Si existe:
  - comparar contenido
  - igual → no escribir
  - distinto → overwrite

---

### 10. Working Tree

- Si está dirty:
  - warning
  - no bloquear

---

## Validation

El archivo generado debe:

- Ser un prompt válido (no una spec)
- Respetar el template
- Contener información suficiente del issue
- Permitir que OpenSpec genere requerimientos en inglés usando:
  - MUST
  - SHOULD
  - MAY

---

## Debug

Mostrar:

- issue seleccionado
- path del template
- path del output

---

## Output Final

- Issue seleccionado
- Prompt generado
- Branch activo `feature/<ISSUE-KEY>`

---

## Warnings

```
Warning: Could not fully parse structured sections. Using fallback extraction.
```

---

## Notas

- No inventar datos
- No incluir issues en Done
- Parsing best-effort pero consistente
- El template define completamente la estructura del prompt
- El output final de OpenSpec debe estar en inglés (MUST/SHOULD/MAY)