# Claude Code Project Context

This project uses **[AGENTS.md](./AGENTS.md)** as the canonical context file.
That file is read by both Claude Code and Codex CLI, and any other agent that
follows the AGENTS.md convention.

Read AGENTS.md first. It contains:

- Project overview and scope
- Communication style and code conventions
- Dual-agent workflow (you share this repo with Codex CLI)
- Data model schema and the Universal Gate rule
- Verification commands to run before every commit
- Pending work (see also `CHANGELOG.md` Unreleased section)

When committing, prefix your commit messages with `[claude]` so the git log
makes it obvious which agent did what.
