# Review status

Status date: 2026-08-20

The integration work was approved for publication as
`ossenna-hq/MCP_LTSpice`. The retained `upstream` remote points to the original
public repository; the publication repository is configured separately as
`origin`.

## Provenance checks

- Checked out upstream tag `v0.5.0` at commit
  `4dc456000e1a436ef37a585c23ab35954a8caf04e`.
- Compared all 64 installed package source/assets files with `src/ltspice_mcp`.
  Their content matches after normalizing checkout line endings.
- Confirmed no tracked server source, tests, lockfile, project metadata, or
  license file was changed on the review branch.

## Public-data checks

- Searched the repository outside `.git` for the private installation's user
  name, host name, tailnet domain, project paths, and endpoint suffix.
- No private installation strings were found.
- Parsed both Codex TOML examples and the upstream server TOML example.
- Parsed `scripts/start-http-bridge.ps1` with the PowerShell language parser.
- `git diff --check` reported no whitespace errors.

## Automated validation

Commands run from the repository root:

```powershell
uv sync --frozen
uv run ruff check .
uv run pyright
uv run pytest -q
```

Results:

- Ruff: passed.
- Pyright: 0 errors and 2 existing protected/private-use warnings.
- Pytest: 2,215 passed, 49 skipped, 16 failed, 5 warnings; total coverage
  88.13%, above the configured 80% threshold.

The 16 failures occur in the unchanged upstream suite on native Windows. They
cover POSIX/WSL path expectations, CRLF handling, locale-default source reads,
Windows symlink privilege requirements, URI construction from POSIX-looking
paths, and an embedded-NUL expectation that differs on this platform. One
concurrency test also emitted a Windows file-replacement permission warning.
No failures reference the deployment files added by this branch.

No live simulator run or MCP client connection was performed as part of this
repository-preparation pass.

## Publication decisions

- The upstream PyPI publishing workflows are retained as source, but should be
  disabled or deliberately adapted before creating any `v*` tag in a fork.
- Python package URLs and Claude plugin metadata continue to identify the
  upstream project because this publication does not claim ownership of the
  upstream PyPI packages or Claude plugin releases.
- Retain `upstream` as the read-only source for future updates and use `origin`
  only for the `ossenna-hq` integration fork.
