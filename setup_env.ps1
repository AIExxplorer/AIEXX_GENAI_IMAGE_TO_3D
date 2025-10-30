# Script de configuração de variáveis de ambiente para ComfyUI 3D Pipeline
# Execute como Administrador para configuração permanente do sistema
# Ou execute normalmente para configuração da sessão atual

param(
    [string]$HF_TOKEN = "",
    [switch]$SystemWide = $false,
    [switch]$Help = $false
)

if ($Help) {
    Write-Host @"
Uso: .\setup_env.ps1 [-HF_TOKEN <seu_token>] [-SystemWide]

Parâmetros:
  -HF_TOKEN     Token do Hugging Face Hub (obrigatório)
  -SystemWide   Configurar para todo o sistema (requer Admin)
  -Help         Mostrar esta ajuda

Exemplos:
  .\setup_env.ps1 -HF_TOKEN "hf_xxxxx"
  .\setup_env.ps1 -HF_TOKEN "hf_xxxxx" -SystemWide
"@
    exit 0
}

# Verificar se token foi fornecido
if ([string]::IsNullOrWhiteSpace($HF_TOKEN)) {
    Write-Host "ERRO: Token do Hugging Face não fornecido!" -ForegroundColor Red
    Write-Host "Use: .\setup_env.ps1 -HF_TOKEN `"seu_token_aqui`"" -ForegroundColor Yellow
    Write-Host "Obtenha seu token em: https://huggingface.co/settings/tokens" -ForegroundColor Cyan
    exit 1
}

# Validar formato do token
if (-not ($HF_TOKEN -match '^hf_[a-zA-Z0-9]{20,}$')) {
    Write-Host "AVISO: O token não parece estar no formato esperado (hf_...)" -ForegroundColor Yellow
    $confirm = Read-Host "Deseja continuar mesmo assim? (S/N)"
    if ($confirm -ne 'S' -and $confirm -ne 's') {
        exit 1
    }
}

# Configurar variável de ambiente
try {
    if ($SystemWide) {
        # Verificar privilégios de administrador
        $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

        if (-not $isAdmin) {
            Write-Host "ERRO: Configuração system-wide requer privilégios de Administrador!" -ForegroundColor Red
            Write-Host "Execute o PowerShell como Administrador ou remova o parâmetro -SystemWide" -ForegroundColor Yellow
            exit 1
        }

        [System.Environment]::SetEnvironmentVariable("HUGGING_FACE_HUB_TOKEN", $HF_TOKEN, [System.EnvironmentVariableTarget]::Machine)
        Write-Host "✓ Variável HUGGING_FACE_HUB_TOKEN configurada no sistema (permanente)" -ForegroundColor Green
    } else {
        [System.Environment]::SetEnvironmentVariable("HUGGING_FACE_HUB_TOKEN", $HF_TOKEN, [System.EnvironmentVariableTarget]::User)
        $env:HUGGING_FACE_HUB_TOKEN = $HF_TOKEN
        Write-Host "✓ Variável HUGGING_FACE_HUB_TOKEN configurada para o usuário atual" -ForegroundColor Green
    }

    # Criar arquivo .env também
    $envFile = Join-Path $PSScriptRoot ".env"
    "HUGGING_FACE_HUB_TOKEN=$HF_TOKEN" | Out-File -FilePath $envFile -Encoding utf8 -Force
    Write-Host "✓ Arquivo .env criado em: $envFile" -ForegroundColor Green

    # Verificar
    Write-Host "`nVerificando configuração..." -ForegroundColor Cyan
    $currentValue = [System.Environment]::GetEnvironmentVariable("HUGGING_FACE_HUB_TOKEN", [System.EnvironmentVariableTarget]::User)
    if ($currentValue -eq $HF_TOKEN) {
        Write-Host "✓ Configuração verificada com sucesso!" -ForegroundColor Green
    } else {
        Write-Host "⚠ Token configurado na sessão atual, mas pode precisar reiniciar o terminal" -ForegroundColor Yellow
    }

} catch {
    Write-Host "ERRO ao configurar variável de ambiente: $_" -ForegroundColor Red
    exit 1
}

Write-Host "`n=== Próximos passos ===" -ForegroundColor Cyan
Write-Host "1. Reinicie seu terminal/PowerShell para carregar a variável"
Write-Host "2. Execute: .\download_models.ps1 para baixar os modelos necessários"
Write-Host "3. Verifique o progresso em: downloads_status.log"
