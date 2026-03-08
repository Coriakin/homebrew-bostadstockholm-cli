---
name: bostadcli-tap-release
description: Use this skill when updating this homebrew tap for a new bostadcli release. Trigger with a command-style prompt like `bostadcli-tap-release --version 0.1.3 --source-repo-path /abs/path/to/bostadcli [--owner Coriakin] [--repo bostadcli] [--commit]`.
---

# Bostadcli Tap Release

Use this skill to update `Formula/bostadcli.rb` in this tap after a new `bostadcli` GitHub release.

## Required Trigger Shape

Use a command-style request:

```text
bostadcli-tap-release --version <x.y.z> --source-repo-path </absolute/path/to/bostadcli> [--owner Coriakin] [--repo bostadcli] [--commit]
```

Defaults:
- `--owner`: `Coriakin`
- `--repo`: `bostadcli`
- `--commit`: disabled unless explicitly provided

## Workflow

1. Validate context and inputs.
- Confirm current working directory is the tap repo by checking `Formula/bostadcli.rb` exists.
- Confirm `--version` matches `^[0-9]+\.[0-9]+\.[0-9]+$`.
- Confirm `--source-repo-path` exists and contains `scripts/generate-homebrew-formula.mjs`.

2. Resolve checksums.
- Download `SHA256SUMS` from:
  - `https://github.com/<owner>/<repo>/releases/download/v<version>/SHA256SUMS`
- Extract:
  - `bostadcli_<version>_macos_arm64.tar.gz`
  - `bostadcli_<version>_macos_x64.tar.gz`
- If either checksum is missing, stop with an actionable error.

3. Generate formula content from source repo script.
- Run:
```bash
node <source-repo-path>/scripts/generate-homebrew-formula.mjs \
  --owner <owner> \
  --repo <repo> \
  --version <version> \
  --macos-arm64-sha <ARM64_SHA256> \
  --macos-x64-sha <X64_SHA256>
```
- Replace tap formula with generated output:
  - `Formula/bostadcli.rb`

4. Validate before commit.
- Syntax check formula:
```bash
ruby -c Formula/bostadcli.rb
```
- If Homebrew is available, run:
```bash
brew audit --strict Formula/bostadcli.rb
```

5. Commit when `--commit` is provided.
- Stage only relevant files (normally `Formula/bostadcli.rb`, plus `README.md` only if intentionally changed).
- Commit message:
```text
bump bostadcli to v<version>
```
- Never push automatically.

## Output Requirements

Always report:
- version updated to
- arm64/x64 checksums used
- files changed
- validation commands run and results
- whether commit was created
