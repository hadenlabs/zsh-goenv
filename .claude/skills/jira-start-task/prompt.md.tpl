# Entrada para OpenSpec

## Issue

- Key: {{issue.key}}
- Title: {{issue.title}}

---

## Contenido Fuente

### Scenario
{{content.scenario}}

### Acceptance Tests
{{#each content.acceptance_tests}}
- {{this}}
{{/each}}

### Sources
{{#each content.sources}}
- {{this}}
{{/each}}

### Descripción Completa
{{content.raw_description}}

---

## Tarea

Generar una especificación completa en OpenSpec basada ÚNICAMENTE en el contenido proporcionado.

---

## Guía

Usa la información para:

- Entender el contexto del problema
- Identificar el problema principal
- Definir el alcance functional
- Convertir los acceptance tests en requerimientos claros y testeables
- Mantener una estructura clara, consistente y sin ambigüedad

Este prompt está diseñado para ayudar tanto a humanos como a sistemas a generar especificaciones de alta calidad a partir de issues de Jira.

---

## Restricciones

- NO inventar información
- Usar SOLO el contenido proporcionado
- Mantener la intención original del issue
- Evitar ambigüedades
- Usar keywords tipo RFC en los requerimientos:
  - MUST
  - SHOULD
  - MAY

---

## Requisitos de Salida

- Generar una especificación válida de OpenSpec
- Los requerimientos deben estar en inglés usando:
  - The system MUST ...
  - The system SHOULD ...
  - The system MAY ...
- Mantener trazabilidad con el issue ({{issue.key}})
- Usar markdown estructurado

---

## Contrato de Validación

La especificación generada DEBE pasar `task validate` sin cambios manuales.

---

## Post-Procesamiento (OBLIGATORIO)

Después de generar la especificación:

`task validate`

---

## Reglas de Salida

- Retornar SOLO la especificación final
- NO incluir explicaciones
- NO incluir razonamiento
- NO incluir bloques de código
