# publish.ps1 — wiki 업데이트 후 실행하면 GitHub + 웹사이트 동시 배포

param([string]$msg = "update wiki")

# 1. llm-wiki 푸시
Set-Location "C:\Users\USER\Desktop\llm-wiki"
git add -A
git commit -m $msg
git push

# 2. llm-wiki → llm-wiki-site/content/ 콘텐츠 동기화 (핵심 수정)
Write-Host "`n콘텐츠 동기화 중..." -ForegroundColor Cyan
robocopy "C:\Users\USER\Desktop\llm-wiki" "C:\Users\USER\Desktop\llm-wiki-site\content" "*.md" /S /IS /IT /NFL /NDL /NJH /NJS /NC /NS | Out-Null

# 3. Quartz 사이트 배포
Set-Location "C:\Users\USER\Desktop\llm-wiki-site"
git add -A
git commit -m "sync content: $msg" --allow-empty
npx quartz sync

Write-Host "`n배포 완료! https://khchoihub.github.io/llm-wiki-site" -ForegroundColor Green
