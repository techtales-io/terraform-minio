# AGENTS.md

## CRITICAL — MANDATORY FIRST ACTION (NO EXCEPTIONS)

**BEFORE doing anything else — before reading files, asking questions, or starting any task — run this command:**

```bash
ls .agents/skills/ 2>/dev/null || npx skills experimental_install
```

Do NOT proceed until this has been executed and confirmed.

After skills are installed, ask the user to restart the coding assistant.

## Section 1: Core Directives & Rules

### RESPONSES

- Keep responses concise and to the point - unless the user asks otherwise.

### PLANNING_MODE

- Always ask clarifying questions.
- Never assume design, tech stack or features.
- Use deep-dive sub-agents to assist with research and to review different aspects of your plan before presenting to the user.

### CHANGE_EDIT_MODE

- Never implement features yourself when possible - use sub-agents.
- Identify changes from the plan that can be implemented in parallel, and use sub-agents to implement the features efficiently.
- When using sub-agents to implement features, act as a coordinator only.
- Use the best model for the task.

### GIT_COMMIT

- Use `git-commit` skill for all git commit messages.

### SUBAGENT_DEVELOPMENT

When using the `writing-plans` skill to generate an implementation plan or when writing specs:

- **Git Commits in Plans**: Ensure the git commit commands specified in the plan STRICTLY follow the `GIT_COMMIT` rules.
- **Spec Flexibility for Linters/Types**: Explicitly include a note in your plan that the implementer subagent is **authorized and expected** to add necessary type hints, docstrings, linting suppression comments,
  and repository configuration updates required to pass the project's CI, type-checkers, and linters.

## Section 2: Repository Specifics

### TOOLING_AUTOMATION

All automation and scripts are managed via Task. Always use `task` to execute workflows. You can discover available tasks by running `task --list` or exploring the `.taskfiles/` directory. Do not write custom bash scripts for standard operations.

### QUALITY_VERIFICATION

- Tooling versions are strictly managed using `mise` (`.mise.toml`).
- This repository uses `pre-commit` and MegaLinter. Ensure changes are properly formatted and pass linting before committing.

### SECRET_MANAGEMENT

- **Primary**: The vast majority of secrets are stored in OpenBao. Terraform provisions these secrets dynamically where applicable.
- **Secondary**: SOPS (with age encryption) might be used sparingly.

### CRITICAL-SECURITY

Never commit plaintext secrets to the repository.
