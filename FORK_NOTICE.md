# Fork and source notice

This repository was prepared from the public
[`cognitohazard/ltspice-mcp`](https://github.com/cognitohazard/ltspice-mcp)
repository.

- Upstream release: `v0.5.0`
- Upstream commit: `4dc456000e1a436ef37a585c23ab35954a8caf04e`
- Upstream license: GNU General Public License v3.0 or later
- Local preparation date: 2026-08-19

The upstream source, tests, fixtures, packaging metadata, documentation, and
license are retained. This integration fork adds generic deployment
documentation, MCP client examples, a parameterized HTTP bridge launcher, and
requirements for preparing a public fork. These additions deliberately contain
no private hostnames, user profiles, circuit-project paths, credentials, or
network-provider-specific configuration.

`mcp-proxy`, LTspice, ngspice, and other dependencies are not vendored. They
retain their own upstream licenses and release processes.
