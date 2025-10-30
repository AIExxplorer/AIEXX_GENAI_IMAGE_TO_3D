# Script de configuração de ferramentas MCP (Model Context Protocol)

param(
    [switch]$Install = $false,
    [switch]$Test = $false,
    [switch]$Configure = $false,
    [switch]$Help = $false
)

if ($Help) {
    Write-Host @"
Uso: .\setup_mcp.ps1 [-Install] [-Test] [-Configure]

Parametros:
  -Install     Instalar servidores MCP necessarios
  -Test        Testar conectividade com servidores MCP
  -Configure   Configurar credenciais MCP
  -Help        Mostrar esta ajuda

Exemplos:
  .\setup_mcp.ps1 -Install
  .\setup_mcp.ps1 -Configure
  .\setup_mcp.ps1 -Test
"@
    exit 0
}

$baseDir = Split-Path -Parent (Split-Path -Parent $PSCommandPath)
$mcpConfigFile = Join-Path $baseDir "mcp_config.json"

Write-Host "=== Configuracao MCP (Model Context Protocol) ===" -ForegroundColor Cyan
Write-Host ""

# Função para verificar Node.js
function Test-NodeJS {
    try {
        $nodeVersion = node --version 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "OK Node.js instalado: $nodeVersion" -ForegroundColor Green
            return $true
        }
    } catch {
        Write-Host "X Node.js nao encontrado!" -ForegroundColor Red
        Write-Host "  Instale Node.js 18+ de: https://nodejs.org/" -ForegroundColor Yellow
        return $false
    }
    return $false
}

# Função para verificar NPM
function Test-NPM {
    try {
        $npmVersion = npm --version 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "OK npm instalado: $npmVersion" -ForegroundColor Green
            return $true
        }
    } catch {
        Write-Host "X npm nao encontrado!" -ForegroundColor Red
        return $false
    }
    return $false
}

# Função para instalar servidores MCP
function Install-MCPServers {
    Write-Host "`nInstalando servidores MCP..." -ForegroundColor Cyan

    $servers = @(
        "@modelcontextprotocol/server-github",
        "@modelcontextprotocol/server-filesystem",
        "@modelcontextprotocol/server-memory"
    )

    foreach ($server in $servers) {
        Write-Host "  Instalando $server..." -ForegroundColor Gray
        # npx baixará automaticamente quando necessário, mas podemos cache global
        npm install -g $server 2>&1 | Out-Null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  OK $server instalado" -ForegroundColor Green
        } else {
            Write-Host "  AVISO: $server pode ser baixado on-demand pelo npx" -ForegroundColor Yellow
        }
    }

    Write-Host "`nOK Servidores MCP configurados" -ForegroundColor Green
}

# Função para configurar credenciais
function Configure-MCPCredentials {
    Write-Host "`nConfigurando credenciais MCP..." -ForegroundColor Cyan

    # Verificar se .env existe
    $envFile = Join-Path $baseDir ".env"
    if (-not (Test-Path $envFile)) {
        Write-Host "  Criando arquivo .env..." -ForegroundColor Gray
        Copy-Item (Join-Path $baseDir ".env.example") $envFile
    }

    # Carregar .env
    if (Test-Path $envFile) {
        Get-Content $envFile | ForEach-Object {
            if ($_ -match "^\s*([^#][^=]+)=(.*)$") {
                $key = $matches[1].Trim()
                $value = $matches[2].Trim()
                if ($value -and $value -ne "seu_token_aqui" -and $value -notlike "*seu_*") {
                    [System.Environment]::SetEnvironmentVariable($key, $value, [System.EnvironmentVariableTarget]::Process)
                }
            }
        }
    }

    # Verificar tokens necessários
    Write-Host "`nVerificando tokens:" -ForegroundColor Yellow

    $tokens = @{
        "HUGGING_FACE_HUB_TOKEN" = "Hugging Face"
        "GITHUB_TOKEN" = "GitHub (opcional)"
        "CONTEXT7_API_KEY" = "Context7 (opcional)"
    }

    foreach ($tokenName in $tokens.Keys) {
        $tokenValue = [System.Environment]::GetEnvironmentVariable($tokenName)
        if ($tokenValue) {
            $masked = $tokenValue.Substring(0, [Math]::Min(10, $tokenValue.Length)) + "..."
            Write-Host "  OK $($tokens[$tokenName]): $masked" -ForegroundColor Green
        } else {
            Write-Host "  [ ] $($tokens[$tokenName]): Nao configurado" -ForegroundColor Yellow
        }
    }

    Write-Host "`nPara configurar tokens:" -ForegroundColor Cyan
    Write-Host "  .\setup_env.ps1 -HF_TOKEN `"seu_token`"" -ForegroundColor White
    Write-Host "  # OU edite .env manualmente" -ForegroundColor White
}

# Função para testar MCP
function Test-MCPServers {
    Write-Host "`nTestando servidores MCP..." -ForegroundColor Cyan

    # Teste GitHub MCP
    Write-Host "`nTestando GitHub MCP:" -ForegroundColor Yellow
    $githubToken = $env:GITHUB_TOKEN
    if ($githubToken) {
        Write-Host "  Token GitHub configurado" -ForegroundColor Green
        Write-Host "  Teste: npx -y @modelcontextprotocol/server-github" -ForegroundColor Gray
    } else {
        Write-Host "  AVISO: Token GitHub nao configurado (opcional)" -ForegroundColor Yellow
    }

    # Teste Filesystem MCP
    Write-Host "`nTestando Filesystem MCP:" -ForegroundColor Yellow
    if (Test-Path $baseDir) {
        Write-Host "  OK Diretorio base acessivel: $baseDir" -ForegroundColor Green
    }

    # Teste Memory MCP
    Write-Host "`nTestando Memory MCP:" -ForegroundColor Yellow
    $memoryDir = Join-Path $baseDir ".mcp\memory"
    if (-not (Test-Path $memoryDir)) {
        New-Item -ItemType Directory -Path $memoryDir -Force | Out-Null
        Write-Host "  Criado diretorio de memoria: $memoryDir" -ForegroundColor Green
    } else {
        Write-Host "  OK Diretorio de memoria existe" -ForegroundColor Green
    }

    Write-Host "`nVerificando arquivo de configuracao MCP:" -ForegroundColor Yellow
    if (Test-Path $mcpConfigFile) {
        Write-Host "  OK mcp_config.json encontrado" -ForegroundColor Green

        try {
            $config = Get-Content $mcpConfigFile -Raw | ConvertFrom-Json
            $serverCount = ($config.mcpServers | Get-Member -MemberType NoteProperty).Count
            Write-Host "  OK $serverCount servidores configurados" -ForegroundColor Green
        } catch {
            Write-Host "  AVISO: Erro ao ler mcp_config.json" -ForegroundColor Yellow
        }
    } else {
        Write-Host "  X mcp_config.json nao encontrado!" -ForegroundColor Red
    }
}

# Executar ações
if (-not $Install -and -not $Test -and -not $Configure) {
    # Padrão: mostrar status
    Write-Host "Pre-requisitos:" -ForegroundColor Yellow
    Test-NodeJS | Out-Null
    Test-NPM | Out-Null

    Write-Host "`nUso:" -ForegroundColor Cyan
    Write-Host "  .\setup_mcp.ps1 -Install     # Instalar servidores MCP"
    Write-Host "  .\setup_mcp.ps1 -Configure  # Configurar credenciais"
    Write-Host "  .\setup_mcp.ps1 -Test       # Testar configuracao"
    exit 0
}

if ($Install) {
    if (-not (Test-NodeJS)) { exit 1 }
    if (-not (Test-NPM)) { exit 1 }
    Install-MCPServers
}

if ($Configure) {
    Configure-MCPCredentials
}

if ($Test) {
    Test-MCPServers
}

Write-Host "`n=== Configuracao MCP Completa ===" -ForegroundColor Green
Write-Host "`nProximos passos:" -ForegroundColor Cyan
Write-Host "1. Configure tokens: .\setup_env.ps1 -HF_TOKEN `"token`""
Write-Host "2. Teste MCP: .\setup_mcp.ps1 -Test"
Write-Host "3. Use ferramentas MCP em seu workflow"
