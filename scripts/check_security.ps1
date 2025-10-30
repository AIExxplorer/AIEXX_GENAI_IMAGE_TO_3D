# Script de verificação de segurança
# Verifica se há arquivos sensíveis antes de commit

param(
    [switch]$Fix = $false,
    [switch]$Verbose = $false
)

$ErrorActionPreference = "Stop"
$baseDir = Split-Path -Parent (Split-Path -Parent $PSCommandPath)

Write-Host "=== Verificacao de Seguranca ===" -ForegroundColor Cyan
Write-Host "Diretorio: $baseDir`n" -ForegroundColor Gray

$issues = @()
$warnings = @()

# Padrões perigosos para procurar
$dangerousPatterns = @(
    @{Pattern = "hf_[a-zA-Z0-9]{20,}"; Description = "Token Hugging Face"},
    @{Pattern = "ghp_[a-zA-Z0-9]{36,}"; Description = "Token GitHub (Classic)"},
    @{Pattern = "github_pat_[a-zA-Z0-9]{22}_[a-zA-Z0-9]{59}"; Description = "Token GitHub (Fine-grained)"},
    @{Pattern = "sk-[a-zA-Z0-9]{48}"; Description = "API Key OpenAI"},
    @{Pattern = "AIza[0-9A-Za-z-_]{35}"; Description = "API Key Google"},
    @{Pattern = "AKIA[0-9A-Z]{16}"; Description = "AWS Access Key"},
    @{Pattern = "aws_secret_access_key\s*=\s*[A-Za-z0-9/+=]{40}"; Description = "AWS Secret Key"},
    @{Pattern = "password\s*=\s*['\`"][^'\`"]+['\`"]"; Description = "Password hardcoded"},
    @{Pattern = "api[_-]?key\s*[=:]\s*['\`"][^'\`"]+['\`"]"; Description = "API Key hardcoded"}
)

# Arquivos para verificar (excluindo node_modules, venv, etc)
$filesToCheck = Get-ChildItem -Path $baseDir -Recurse -File -Include *.py,*.ps1,*.js,*.ts,*.json,*.md,*.txt,*.sh,*.yaml,*.yml |
    Where-Object {
        $_.FullName -notmatch "node_modules" -and
        $_.FullName -notmatch "venv" -and
        $_.FullName -notmatch ".venv" -and
        $_.FullName -notmatch "__pycache__" -and
        $_.FullName -notmatch ".git" -and
        $_.FullName -notmatch "ComfyUI\\models" -and
        $_.FullName -notmatch "exports\\"
    }

Write-Host "Verificando $($filesToCheck.Count) arquivos...`n" -ForegroundColor Gray

foreach ($file in $filesToCheck) {
    if ($Verbose) {
        Write-Host "Verificando: $($file.Name)" -ForegroundColor DarkGray
    }

    try {
        $content = Get-Content $file.FullName -Raw -ErrorAction SilentlyContinue

        if ($null -eq $content) { continue }

        foreach ($pattern in $dangerousPatterns) {
            if ($content -match $pattern.Pattern) {
                $relativePath = $file.FullName.Replace($baseDir, ".")
                $issue = @{
                    File = $relativePath
                    Type = $pattern.Description
                    Severity = "CRITICAL"
                }
                $issues += $issue

                Write-Host "[CRITICAL] $($pattern.Description) encontrado em:" -ForegroundColor Red
                Write-Host "           $relativePath`n" -ForegroundColor Yellow
            }
        }
    } catch {
        Write-Host "[AVISO] Nao foi possivel ler: $($file.Name)" -ForegroundColor Yellow
    }
}

# Verificar se .env existe e não está no .gitignore
$envFile = Join-Path $baseDir ".env"
$gitignoreFile = Join-Path $baseDir ".gitignore"

if (Test-Path $envFile) {
    if (Test-Path $gitignoreFile) {
        $gitignoreContent = Get-Content $gitignoreFile -Raw
        if ($gitignoreContent -notmatch "\.env") {
            $warnings += "Arquivo .env existe mas pode nao estar no .gitignore!"
        }
    }
}

# Verificar se há arquivos staged com conteúdo sensível
try {
    $stagedFiles = git diff --cached --name-only 2>$null
    if ($stagedFiles) {
        Write-Host "`nArquivos staged para commit:" -ForegroundColor Yellow
        $stagedFiles | ForEach-Object { Write-Host "  - $_" -ForegroundColor Gray }
    }
} catch {
    # Git não disponível ou não é um repositório git
}

# Resumo
Write-Host "`n=== Resumo ===" -ForegroundColor Cyan

if ($issues.Count -eq 0 -and $warnings.Count -eq 0) {
    Write-Host "OK Nenhum problema de seguranca encontrado!" -ForegroundColor Green
    exit 0
} else {
    if ($issues.Count -gt 0) {
        Write-Host "`n[!] $($issues.Count) problema(s) CRITICO(S) encontrado(s)!" -ForegroundColor Red
        Write-Host "`nACAO NECESSARIA:" -ForegroundColor Yellow
        Write-Host "1. Remova os tokens/credenciais dos arquivos" -ForegroundColor White
        Write-Host "2. Use variaveis de ambiente (.env)" -ForegroundColor White
        Write-Host "3. Se ja commitou, revogue os tokens imediatamente" -ForegroundColor White
        Write-Host "4. Force push para reescrever historico (perigoso!)" -ForegroundColor White
    }

    if ($warnings.Count -gt 0) {
        Write-Host "`n[!] $($warnings.Count) aviso(s):" -ForegroundColor Yellow
        foreach ($warning in $warnings) {
            Write-Host "  - $warning" -ForegroundColor Yellow
        }
    }

    Write-Host "`nConsulte: SECURITY.md para mais informacoes" -ForegroundColor Cyan
    exit 1
}
