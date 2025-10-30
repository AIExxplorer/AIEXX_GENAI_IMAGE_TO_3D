# Script temporário para executar download com token configurado
$env:HUGGING_FACE_HUB_TOKEN = "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"

Write-Host "Iniciando download de modelos..." -ForegroundColor Cyan
Write-Host "Token configurado: $($env:HUGGING_FACE_HUB_TOKEN.Substring(0,10))..." -ForegroundColor Green
Write-Host ""

python download_models.py
