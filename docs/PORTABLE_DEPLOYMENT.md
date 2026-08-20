# Portable deployment

This guide keeps installation-specific values outside version control. Direct
STDIO is preferred when the MCP client and simulator run on the same machine.
An HTTP bridge is optional for clients that cannot launch STDIO servers.

## Prerequisites

- Python 3.11 or later.
- `uv` for dependency and environment management.
- LTspice, ngspice, or another simulator supported by the server.
- `mcp-proxy` only when an HTTP transport is required.

The repository does not include simulator binaries or third-party Python
packages.

## Run from this source tree

From the repository root:

```powershell
uv sync
uv run ltspice-mcp --help
```

Copy `ltspice-mcp.example.toml` to `ltspice-mcp.toml`. The real file is ignored
by Git. Keep its sandbox narrow:

```toml
[simulator]
default = "ltspice"
enabled = ["ltspice"]
path = ""

[security]
allowed_paths = ["."]
```

An empty simulator path enables normal auto-detection. If auto-detection cannot
find the simulator, set the path in the untracked configuration file or use the
`LTSPICE_MCP_SIMULATOR_EXE` environment variable. The working directory and
allowed paths can similarly be supplied through `LTSPICE_MCP_WORKING_DIR` and
`LTSPICE_MCP_ALLOWED_PATHS`.

## Register a local MCP client

For Codex, copy `examples/codex-stdio.config.toml` into the circuit workspace's
`.codex/config.toml`. Place the untracked `ltspice-mcp.toml` in that workspace,
or adjust the argument locally. Project-scoped MCP configuration should only be
enabled for a trusted workspace.

Other MCP clients can launch the equivalent command:

```text
ltspice-mcp --config ltspice-mcp.toml
```

## Optional HTTP bridge

Install the bridge independently:

```powershell
uv tool install "mcp-proxy==0.12.0" --with "mcp>=1.27,<2"
```

Then run the parameterized launcher:

```powershell
.\scripts\start-http-bridge.ps1 `
  -CircuitRoot 'D:\circuits' `
  -ConfigPath 'D:\circuits\ltspice-mcp.toml'
```

It binds to `127.0.0.1` by default. A compatible Streamable HTTP client uses
`http://127.0.0.1:8765/mcp`; see `examples/codex-http.config.toml`.

Binding to a non-loopback interface or publishing the endpoint is a separate
security decision. Use authentication and a network boundary you control. The
server can write files and start simulator processes within `allowed_paths`, so
do not expose it directly to an untrusted network.

## Verification

1. Confirm the configured endpoint or STDIO process initializes.
2. Call `server_status` and inspect the simulator and allowed-path report.
3. Call `recent` or validate a known circuit without modifying it.
4. Run a disposable fixture and query its numeric results.
5. Confirm generated files remain under the selected circuit root.

Do not claim simulator or hardware validation unless those checks were actually
performed on the target installation.
