# publish.ps1 -- wiki 업데이트 후 실행하면 GitHub + 웹사이트 동시 배포
# 실행 방법: cd C:\Users\USER\Desktop\llm-wiki ; .\publish.ps1
# 또는:      cd C:\Users\USER\Desktop\llm-wiki ; .\publish.ps1 "커밋 메시지"

param([string]$msg = "update wiki")

$WIKI    = "C:\Users\USER\Desktop\llm-wiki"
$SITE    = "C:\Users\USER\Desktop\llm-wiki-site"
$CONTENT = "$SITE\content"

Set-Location $WIKI
Write-Host "=== [0/4] 위키 링크 정합성 점검 (wiki_maintain.py lint) ===" -ForegroundColor Cyan
if (Get-Command py -ErrorAction SilentlyContinue) {
    py tools/wiki_maintain.py lint
} else {
    Write-Host "  (py 미설치 — 점검 스킵)" -ForegroundColor Gray
}
Write-Host ""

Write-Host "=== [1/4] llm-wiki 커밋 & 푸시 ===" -ForegroundColor Cyan
git add -A
$status = git status --short
if ($status) {
    git commit -m $msg
    git push
    Write-Host "  pushed: $msg" -ForegroundColor Green
} else {
    Write-Host "  변경 없음 -- 스킵" -ForegroundColor Gray
}

Write-Host ""
Write-Host "=== [2/4] llm-wiki -> site/content 동기화 (/MIR) ===" -ForegroundColor Cyan
# /MIR: 삭제된 파일도 대상에서 제거 (완전 미러)
# /XD .git .claude: git 메타데이터 제외
# /XF *.jsonl: 대화 로그 제외
robocopy $WIKI $CONTENT /E /MIR /XD ".git" ".claude" "tools" /XF "*.jsonl" /NP /NFL /NDL /NJH /NJS /NC /NS | Out-Null
$rc = $LASTEXITCODE
if ($rc -le 3) {
    Write-Host "  동기화 완료 (robocopy exit: $rc)" -ForegroundColor Green
} else {
    Write-Host "  [경고] robocopy exit code: $rc" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== [3/4] Quartz 빌드 ===" -ForegroundColor Cyan
Set-Location $SITE
npx quartz build 2>&1 | Select-Object -Last 3
if ($LASTEXITCODE -ne 0) {
    Write-Host "  [오류] Quartz 빌드 실패 - 배포 중단" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "=== [4/4] llm-wiki-site 커밋 & 푸시 ===" -ForegroundColor Cyan
git add content/ -f 2>&1 | Out-Null
git commit -m "sync: $msg" --allow-empty
git push origin v5
Write-Host ""
Write-Host "배포 완료! https://khchoihub.github.io/llm-wiki-site" -ForegroundColor Green
