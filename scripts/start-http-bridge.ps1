[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$CircuitRoot,

    [string]$ConfigPath,

    [ValidateRange(1, 65535)]
    [int]$Port = 8765,

    [string]$HostAddress = '127.0.0.1',

    [string]$McpProxyCommand = 'mcp-proxy',

    [string]$LtspiceMcpCommand = 'ltspice-mcp'
)

$ErrorActionPreference = 'Stop'

$resolvedCircuitRoot = (Resolve-Path -LiteralPath $CircuitRoot).Path
if (-not $ConfigPath) {
    $ConfigPath = Join-Path $resolvedCircuitRoot 'ltspice-mcp.toml'
}
$resolvedConfigPath = (Resolve-Path -LiteralPath $ConfigPath).Path

$mcpProxy = Get-Command $McpProxyCommand -CommandType Application -ErrorAction Stop
$ltspiceMcp = Get-Command $LtspiceMcpCommand -CommandType Application -ErrorAction Stop

& $mcpProxy.Path `
    --host $HostAddress `
    --port $Port `
    --cwd $resolvedCircuitRoot `
    -- `
    $ltspiceMcp.Path `
    --config $resolvedConfigPath

exit $LASTEXITCODE
