---
name: gcal-daily-planner
description: Generate a daily planning Markdown file combining Google Calendar events and Jira tasks. Creates an executable daily agenda with configurable parameters, dynamic emoji detection, and timezone support.
metadata:
  author: "hadenlabs"
  version: "0.0.0"
  generatedBy: "openspec"
  opencode:
    emoji: 📋
    tags:
      - google-calendar
      - jira
      - planning
      - daily
      - workflow
    mcp:
      - preferredServer: google-calendar
      - preferredServer: jira-calendar
---

# Google Calendar Daily Planner

Use this skill to generate a daily planning file that combines your Google Calendar events with Jira tasks into a unified executable agenda.

## Objective

Create a daily planning Markdown file at `00-Calendar/Events/YYYY/YYYY-MM-DD.md` that combines:
1. Events from Google Calendar
2. Tasks from Jira (status: "Do Today" or "In Progress")

## Invocation Patterns

This skill can be triggered when the user wants to:

- generate daily planning
- create daily agenda from calendar and tasks
- plan their day automatically

### Example User Requests

- "Use the gcal-daily-planner skill"
- "Generate my daily plan"
- "Create my daily agenda"

## Parameters

| Parameter | Default (Argentina) | Description |
| ---------- |---------------------|-------------|
| taskDuration | 2h | Duration for each Jira task |
| bufferTime | 10m | Buffer time between tasks |
| workStart | 08:00 | Work start time |
| workEnd | 17:00 | Work end time |

**Note**: Parameters automatically adjust based on user's timezone.

## Operational Flow

1. Get current date and timezone using `google-calendar_get-current-time`
2. Fetch today's events from Google Calendar using `google-calendar_list-events`
3. Query Jira for tasks with status "Do Today" or "In Progress"
4. Filter to only include Task type issues
5. Sort tasks: In Progress first, then Do Today
6. Apply scheduling algorithm:
   - Assign taskDuration to each task
   - Add bufferTime between tasks
   - Check for calendar event conflicts
   - Skip conflicting time slots
   - Respect workStart/workEnd window
7. Create folder structure if not exists: `00-Calendar/Events/YYYY/`
8. Generate Markdown file using template format

## Output Format

The output follows this markdown format:

```md
# Event: <title>

## Metadata
- start: YYYY-MM-DD HH:MM
- end: YYYY-MM-DD HH:MM
- timezone: <user-timezone>
- id: <event-id>

## Description
<description>

## Location
<location>
```

### Title Format

#### Emoji Selection (based on keywords in title/summary)

| Keyword Pattern | Emoji | Example |
|----------------|-------|---------|
| `focus`, `deep work`, `study` | 🎯 | 🎯 Deep Focus |
| `meeting`, `standup`, `sync` | 📅 | 📅 Meeting |
| `review`, `code review` | 👀 | 👀 Code Review |
| `deploy`, `release` | 🚀 | 🚀 Deploy |
| `bug`, `fix`, `hotfix` | 🐛 | 🐛 Bug Fix |
| `docs`, `documentation` | 📚 | 📚 Docs |
| `refactor`, `improve` | ♻️ | ♻️ Refactor |
| `test`, `testing` | 🧪 | 🧪 Testing |
| default | 📋 | 📋 Task |

**Rule**: First keyword match wins, fallback to default (📋).

#### Title Construction

- **Calendar Events**: Use original title as-is
- **Jira Tasks**: `<emoji> <detected-type>: <key> - <summary>`

Examples:
- "Refactorizar indexación Qdrant" → ♻️ Refactor: AR-3724 - Refactorizar indexación Qdrant
- "Deploy Qdrant 1.17" → 🚀 Deploy: AR-3729 - Deploy Qdrant 1.17
- "Bug en autenticación" → 🐛 Bug Fix: AR-3730 - Bug en autenticación

#### Location Detection

| Keyword Pattern | Emoji | Example |
|----------------|-------|---------|
| `home`, `remoto`, `remote` | 💻 | 💻 Home |
| `office`, `oficina` | 🏢 | 🏢 Office |
| default | (empty) | Uses event's original location |

**Rule**: First keyword match wins in description/summary. If no keywords found, use original location or leave empty.

### Metadata Fields

| Field | Description |
|-------|-------------|
| start | Start time in YYYY-MM-DD HH:MM format |
| end | End time in YYYY-MM-DD HH:MM format |
| timezone | User's configured timezone |
| id | Google Calendar event ID (for calendar events) |

## MCP Tools Available

### google-calendar_get-current-time
Get current date and timezone.

```json
{
  "account": "optional-account",
  "timeZone": "optional-timezone"
}
```

### google-calendar_list-events
List events for a specific date range.

```json
{
  "calendarId": "primary",
  "timeMin": "YYYY-MM-DDTHH:MM:SSZ",
  "timeMax": "YYYY-MM-DDTHH:MM:SSZ",
  "timeZone": "America/Argentina/Buenos_Aires"
}
```

### jira_searchJiraIssuesUsingJql
Search Jira issues using JQL.

```json
{
  "cloudId": "<cloud-id>",
  "jql": "assignee = currentUser() AND status IN (\"Do Today\", \"In Progress\") AND issuetype = Task",
  "maxResults": 50
}
```

## Idempotent Behavior

The skill is idempotent - running multiple times on the same day will not duplicate events or tasks in the output file.

## Implementation

The skill follows these steps:

### Step 1: Get Current Time
Call `google-calendar_get-current-time` to get:
- Current date (used as the planning day)
- User's timezone (used for all scheduling)

### Step 2: Fetch Calendar Events
Call `google-calendar_list-events` with:
- `timeMin`: Start of today (YYYY-MM-DDT00:00:00)
- `timeMax`: End of today (YYYY-MM-DDT23:59:59)
- `timeZone`: User's timezone from Step 1

### Step 3: Query Jira Tasks
Call `jira_searchJiraIssuesUsingJql` with:
- `jql`: `assignee = currentUser() AND status IN ("Do Today", "In Progress") AND issuetype = Task`
- `maxResults`: 50

### Step 4: Sort Tasks
Sort tasks by status:
1. "In Progress" tasks first
2. "Do Today" tasks second

### Step 5: Schedule Tasks
For each task (respecting order):
1. Start at current time or workStart, whichever is later
2. If within work window (workStart to workEnd):
   - If slot conflicts with calendar event → move to next available slot after event
   - If no conflict → schedule task with taskDuration
   - Add bufferTime after each task
3. If task doesn't fit in work window → schedule at 17:00 (end of day) as pending task

### Step 5.1: Add All Jira Tasks
ALL Jira tasks must be included in the output file, regardless of calendar conflicts:
- Tasks that fit in the schedule → include with their scheduled time
- Tasks that don't fit → include with time "17:00" (or workEnd) as pending/unplanned
- This allows the user to see all pending work and choose what to take

### Step 6: Generate Output
Create the markdown file at `00-Calendar/Events/YYYY/YYYY-MM-DD.md`.

Before generating each task title, apply dynamic detection:

#### 6.1: Detect Emoji and Type
For Jira tasks, scan summary for keywords (case-insensitive, first match wins):
1. `focus`, `deep work`, `study` → 🎯 Deep Focus
2. `meeting`, `standup`, `sync` → 📅 Meeting
3. `review`, `code review` → 👀 Code Review
4. `deploy`, `release` → 🚀 Deploy
5. `bug`, `fix`, `hotfix` → 🐛 Bug Fix
6. `docs`, `documentation` → 📚 Docs
7. `refactor`, `improve` → ♻️ Refactor
8. `test`, `testing` → 🧪 Testing
9. Default → 📋 Task

#### 6.2: Detect Location
Scan description/summary for location keywords:
1. `home`, `remoto`, `remote` → 💻 Home
2. `office`, `oficina` → 🏢 Office
3. Otherwise → use original location or leave empty

#### 6.3: Generate Description
The description must be a clear, human-readable summary that communicates what work is being done. Anyone reading the event should understand the purpose without needing to open Jira.

**Description Generation Rules:**
1. **If summary exists** → Use summary as base, add context from description if needed
2. **Extract the "Objetivo"** → If description has "## Scenario" or "## Objetive", extract that purpose
3. **Extract the "What"** → If description has "## Acceptance Tests" or "### Acceptance Criteria", extract first 2 items
4. **Keep it concise** → Max 300 characters, use plain language
5. **No markdown** → Strip headers (#, ##), bold (*), links, and technical jargon

**Description Template:**
```
[Verb in past tense]: [what was done]
Objetivo: [purpose/goal]
Next: [what comes next or what's pending]
```

**Examples:**

| Jira Description | Generated Description |
|-----------------|----------------------|
| "Refactorizar indexación para soportar documentos tipados con document_id y chunking consistente en Qdrant" | "Refactorizar indexación para soportar documentos tipados con document_id<br>Objetivo: garantizar consistencia entre chunks y permitir reconstrucción de documentos completos" |
| "Desplegar Qdrant 1.17 en producción asegurando estabilidad del servicio" | "Desplegar Qdrant 1.17 en producción<br>Validar estabilidad del servicio post-deploy y monitorear métricas" |
| "chore: add in sops environment variables in devops/deployments" | "Agregar variables de entorno en archivos sops de devops/deployments<br>Objetivo: evitar errores humanos al usar variables locales" |

#### 6.4: Build Title
For Jira tasks: `<emoji> <detected-type>: <key> - <summary>`

Example output format:

```
# Event: <title>

## Metadata
- start: YYYY-MM-DD HH:MM
- end: YYYY-MM-DD HH:MM
- timezone: <user-timezone>
{{#if id}}
- id: <event-id>
{{/if}}

## Description
<description-summary>

## Location
<location>

---

# Event: ♻️ Refactor: AR-3724 - Refactorizar indexación Qdrant

## Metadata
- start: 2026-04-21 17:00
- end: 2026-04-21 19:00
- timezone: America/Lima

## Description
Refactorizar indexación para soportar documentos tipados con document_id
Objetivo: garantizar consistencia entre chunks y permitir reconstrucción de documentos completos

## Location
💻 Home
```

**Note**: Tasks scheduled at 17:00 (workEnd) are "unplanned/pending" - they show what work is available but not yet scheduled.

### Step 7: Idempotent Check
Before writing, check if file exists:
- If exists with same content → skip (no changes needed)
- If exists with different content → update with merged content
- If not exists → create new file

## Default Parameters (Argentina timezone)

| Parameter | Default | Description |
|-----------|---------|-------------|
| taskDuration | 2h | Duration for each Jira task |
| bufferTime | 10m | Buffer time between tasks |
| workStart | 08:00 | Work start time |
| workEnd | 17:00 | Work end time |

**Note**: Parameters automatically adjust based on user's timezone.

## Validation Rules

- Must obtain current date from Google Calendar
- Must respect user's timezone (not hardcoded)
- Must avoid scheduling tasks during calendar events
- Must create folder structure before writing file
- Output file must follow markdown-to-gcal template format
- Jira task titles must use dynamic emoji and type detection (first keyword match wins)
- Location must include emoji prefix when location keywords are detected
- ALL Jira tasks must be included in output (no filtering out)
- Description must be a summary (max 200 chars, no full content)
- Tasks without available time slots must be marked at 17:00 as pending