---
name: goji-commit-smart
description: Orchestrates deterministic multi-commit generation from git working tree. Uses jasper.toml as policy layer and .goji.json (or bootstrap template) for domain model. Performs semantic grouping of changes before commit execution.
license: Proprietary
metadata:
  author: "hadenlabs"
  version: "0.0.0"
  opencode:
    emoji: 🧠
    triggers:
      - "goji commit"
      - "commit smart"
      - "crear commits"
      - "organizar commits"
    tags:
      - git
      - commits
      - grouping
      - deterministic
    mcp:
      preferredServer: git
---

# goji-commit-smart

Skill de partición semántica de commits desde working tree.

---

# Trigger phrases

- goji commit
- commit smart
- organizar commits
- crear commits

---

# Inputs

- No inputs
- Input = git working tree
- --skip-validate → skip pre-commit validation (default: skip for speed)

---

# Source of truth

## 1. jasper.toml (policy layer)

Define:

- commit style
- format
- provider rules
- issue extraction
- branch parsing
- signoff
- subject length

---

## 2. .goji.json (domain layer)

### Bootstrap

```bash
if [ ! -f .goji.json ]; then
  cp <skill_root>/goji.json.tpl .goji.json
fi
```

---

## 3. goji.json.tpl (skill asset)

- emoji map
- types
- scopes
- subject rules

---

# 🔄 Flow

- Validation is optional (skipped by default for speed)
- Use `--validate` flag to enable full pre-commit validation

---

## STEP 0 — Read format from jasper.toml (NEW)

Before any commit generation, extract the commit policy from `jasper.toml`:

### Extract configuration

```bash
# Read commit.format (e.g., "<type> <emoji> (<scope>): <subject>")
FORMAT=$(grep -E "^format\s*=" jasper.toml | cut -d'=' -f2 | tr -d ' "')

# Read commit.style (jira, github, or gitlab)
STYLE=$(grep -E "^style\s*=" jasper.toml | cut -d'=' -f2 | tr -d ' "')

# Read provider-specific rules
PROVIDER_CONFIG="jasper.toml[commit.providers.$STYLE]"
```

### Provider format patterns

| Provider | Example Format                                 | Issue Pattern                            |
| -------- | ---------------------------------------------- | ---------------------------------------- |
| Jira     | `feat ✨ (core): AR-3748 add mcp docs`         | `^<PROJECTKEY>-[0-9]+` prefix in subject |
| GitHub   | `fix 🐛 (core): handle missing env var (#123)` | `\(#[0-9]+\)$` suffix in subject         |
| GitLab   | `chore 🧹 (core): bump tooling (#123)`         | `\(#[0-9]+\)$` suffix in subject         |

### Extract from .goji.json

- Load emoji map for each commit type
- Validate types against allowed types
- Get scope options

---

## STEP 0b — Validate commit format (NEW)

Before executing commits, validate each message against the extracted format:

### Validation rules

1. **Type validation**: Must match types from `.goji.json` (feat, fix, docs, chore, etc.)
2. **Emoji validation**: Emoji must match the type in `.goji.json`
3. **Scope validation**: Must be in `scopes` array from `.goji.json` (or no scope)
4. **Subject validation**:
   - Max length from `jasper.toml[commit].subjectMaxLength`
   - Must not be empty
   - Must be lowercase (except proper nouns)
5. **Issue pattern validation** (provider-specific):
   - Jira: Must include `<PROJECTKEY>-<number>` pattern
   - GitHub: Must include `(#<number>)` suffix
   - GitLab: Must include `(#<number>)` suffix

### Validation regex patterns (by style)

```ts
// Jira style: <type> <emoji> (<scope>): <PROJECTKEY>-<number> <subject>
JIRA_PATTERN =
  "^([a-z]+) ([✨🐛📚🎨💄🧹🧪🚑⚡⚰🛠📦🔍⏪👷📝])( \([a-z]+\))?: [A-Z]+-[0-9]+ .+";

// GitHub style: <type> <emoji> (<scope>): <subject> (#<number>)
GITHUB_PATTERN =
  "^([a-z]+) ([✨🐛📚🎨💄🧹🧪🚑⚡⚰🛠📦🔍⏪👷📝])( \([a-z]+\))?: .+ \(#[0-9]+\)$";

// GitLab style: <type> <emoji> (<scope>): <subject> (#<number>)
GITLAB_PATTERN =
  "^([a-z]+) ([✨🐛📚🎨💄🧹🧪🚑⚡⚰🛠📦🔍⏪👷📝])( \([a-z]+\))?: .+ \(#[0-9]+\)$";
```

### Validation script

```bash
validate_commit() {
  local msg="$1"
  local style="$2"
  local pattern

  case "$style" in
    jira) pattern="$JIRA_PATTERN" ;;
    github) pattern="$GITHUB_PATTERN" ;;
    gitlab) pattern="$GITLAB_PATTERN" ;;
  esac

  if ! echo "$msg" | grep -Eq "$pattern"; then
    echo "ERROR: Commit message does not match $style format"
    echo "Expected: $FORMAT"
    echo "Got: $msg"
    return 1
  fi
}
```

### Provider-specific examples

**Jira style** (from jasper.toml style="jira"):

```
feat ✨ (core): AR-3748 add mcp docs
fix 🐛 (core): AR-3755 handle missing env var
docs 📚 (core): AR-3760 update readme
```

**GitHub style** (from jasper.toml style="github"):

```
feat ✨ (core): add mcp docs (#123)
fix 🐛 (core): handle missing env var (#456)
```

**GitLab style** (from jasper.toml style="gitlab"):

```
feat ✨ (core): add mcp docs (#123)
fix 🐛 (core): handle missing env var (#456)
```

---

## STEP 1 — Validate (optional)

# Default: skip validation for speed. Use --validate to run full validation.

if [ "$VALIDATE" = "true" ]; then
task validate
else
echo "Validación omitida (use --validate para ejecutar)"
fi

---

## STEP 2 — Inspect working tree

```bash
git status --porcelain
git diff --name-only
git rev-parse --abbrev-ref HEAD
```

---

## STEP 3 — Bootstrap config

- ensure `.goji.json` exists

---

## STEP 4 — Semantic grouping engine (CRITICAL)

### Default grouping heuristics

```text
docs/**              → docs commit
.gitlab/**           → ci commit
.claude/**           → chore/core commit
.opencode/**         → prompt/core commit
Taskfile.yml         → build/ci commit
data/**              → chore/core
pkg/internal/core    → core domain commit
config/**            → core commit
tests/**             → test commit
```

### Rule

```text
group by domain coherence, not config
```

---

## STEP 5 — Type inference

- docs → docs
- ci → ci
- test → test
- core → feat or fix
- tooling → chore

---

## STEP 6 — Issue resolution (from jasper.toml)

- Jira → PROJECTKEY-123
- GitLab → #123
- GitHub → #123

---

## STEP 7 — Build commit model (per group)

```ts
Commit {
  type
  scope
  emoji (from goji.json)
  subject
  issue
  files[]
}
```

---

## STEP 8 — Format resolution (delegated)

```text
jasper.toml[commit].format
jasper.toml[commit].style
```

---

## STEP 9 — Provider enrichment

- jira → prefix issue key
- github → append (#id) + Fixes
- gitlab → append (#id) + Closes

---

## STEP 10 — Execution loop

```bash
for each group:
  # Validate commit format before execution (STEP 0b)
  validate_commit "$message" "$STYLE"
  if [ $? -ne 0 ]; then
    echo "Aborting commit due to format validation failure"
    exit 1
  fi
  git add <files>
  git commit -m "<message>" [-s]
```

## Safety rules

- Never commit secrets (examples: `.env`, `credentials.json`, private keys, tokens).
- If any suspect files appear, stop and call them out.
- Do not use `git commit --amend` unless explicitly requested.
- Do not run destructive git commands (`reset --hard`, force-push) unless explicitly requested.