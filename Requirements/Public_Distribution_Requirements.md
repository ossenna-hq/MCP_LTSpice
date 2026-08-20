# Public distribution requirements

## Source provenance

- **REQ-PUB-001:** The repository shall retain the upstream GPL license and
  identify the upstream release and commit from which it was prepared.
- **REQ-PUB-002:** The repository shall contain the complete upstream v0.5.0
  source, tests, fixtures, packaging files, and documentation needed to build
  and review the MCP server.
- **REQ-PUB-003:** Third-party applications and Python packages shall remain
  external dependencies unless their sources and licenses are intentionally
  reviewed for vendoring.

## Portable configuration

- **REQ-PUB-010:** Committed configuration shall not contain a real user-profile
  path, circuit-project path, private hostname, credential, or network-specific
  endpoint.
- **REQ-PUB-011:** The server sandbox shall default to the selected working
  directory and require an explicit choice before access is broadened.
- **REQ-PUB-012:** Simulator and helper executable locations shall be discovered
  from `PATH`, auto-detected by the server, or supplied by the operator.

## Client access

- **REQ-PUB-020:** The repository shall document direct STDIO access as the
  preferred local MCP transport.
- **REQ-PUB-021:** The repository shall provide an optional, parameterized local
  HTTP bridge without prescribing a particular private-network product.
- **REQ-PUB-022:** Network publication shall be treated as a separate deployment
  concern and shall not weaken the server's filesystem sandbox.

## Review and publication

- **REQ-PUB-030:** Local changes shall remain uncommitted until reviewed by the
  repository owner.
- **REQ-PUB-031:** The review shall include automated tests, a secret/path scan,
  and confirmation that no unintended remote named `origin` exists before the
  first publication.
