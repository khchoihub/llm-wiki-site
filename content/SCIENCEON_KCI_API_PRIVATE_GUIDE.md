# HERMES Private Guide: ScienceON and KCI API

> Private credential guide. Do not publish, paste into public chats, or commit to a shared repository.
> This file intentionally contains real API credentials so another AI/operator can call ScienceON and KCI immediately from this HERMES workspace.

## 1. Credential Summary

### ScienceON API Gateway

```env
SCIENCEON_CLIENT_ID=5432568856b2d233933274d758b606338e06a1c803b8422d8d01ad16057585fe
SCIENCEON_API_KEY=8e46420cb88142509b13d5fdbd3946f9
SCIENCEON_AES_KEY=8e46420cb88142509b13d5fdbd3946f9
SCIENCEON_MAC_ADDRESS=1C-79-2D-87-CD-37
SCIENCEON_CLIENT_IP=36.38.51.198
SCIENCEON_SESSION_ID=hermes
```

Authorized service areas:

- `ARTI`: papers/articles
- Researcher
- Institution

HERMES currently uses the `ARTI` paper/article service.

### KCI Open API

```env
KCI_OPEN_API_KEY=39001873
```

## 2. Local HERMES Integration Points

Primary script:

```powershell
work\hermes-home\scripts\paper_apis.py
```

Paper tool plugin:

```powershell
work\hermes-home\plugins\paper-tool
```

Runtime credential file:

```powershell
work\hermes-home\.env
```

ScienceON token cache:

```powershell
work\hermes-home\cache\scienceon_token.json
```

Paper metadata cache:

```powershell
work\hermes-home\cache\paper_search_cache.json
```

## 3. Recommended HERMES Commands

Run from the repository root:

```powershell
cd C:\Users\USER\Documents\Codex\2026-05-31\https-hermes-agent-nousresearch-com-docs
```

### Check ScienceON token issuance

```powershell
& "C:\Users\USER\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe" `
  "work\hermes-home\scripts\paper_apis.py" scienceon-token
```

Expected:

- JSON response with masked `access_token`
- No `E4006`
- No missing env keys

### Search papers through ScienceON

```powershell
& "C:\Users\USER\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe" `
  "work\hermes-home\scripts\paper_apis.py" search "공공서비스동기" `
  --provider scienceon `
  --limit 5 `
  --format json
```

### Search by field

Supported HERMES fields:

- `all`
- `title`
- `author`
- `abstract`
- `keyword`
- `doi`
- `year`
- `cn`

Example:

```powershell
& "C:\Users\USER\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe" `
  "work\hermes-home\scripts\paper_apis.py" search "policy feedback" `
  --provider scienceon `
  --field title `
  --limit 10 `
  --format json
```

### Search with year bounds

```powershell
& "C:\Users\USER\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe" `
  "work\hermes-home\scripts\paper_apis.py" search "인과추론" `
  --provider scienceon `
  --year-from 2015 `
  --year-to 2026 `
  --limit 20 `
  --format json
```

### Get ScienceON detail by CN

```powershell
& "C:\Users\USER\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe" `
  "work\hermes-home\scripts\paper_apis.py" scienceon-detail `
  --cn NART140251961 `
  --format json
```

### Integrated paper detail enrichment

Use this after choosing a candidate from search results:

```powershell
& "C:\Users\USER\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe" `
  "work\hermes-home\scripts\paper_apis.py" detail `
  --title "논문 제목" `
  --doi "10.xxxx/xxxxx" `
  --format json
```

### Research-update JSON

```powershell
& "C:\Users\USER\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe" `
  "work\hermes-home\scripts\paper_apis.py" research-update `
  --topic "공공서비스동기" `
  --query "공공서비스동기" `
  --query "public service motivation" `
  --exclude "뉴스" `
  --provider scienceon `
  --year-from 2015 `
  --year-to 2026 `
  --max-results 50 `
  --output "outputs\research_update_psm.json"
```

## 4. ScienceON Token Flow

ScienceON access tokens expire quickly, so do not hardcode access tokens in long-running jobs.

The stable credentials are:

- `SCIENCEON_CLIENT_ID`
- `SCIENCEON_API_KEY` / `SCIENCEON_AES_KEY`
- `SCIENCEON_MAC_ADDRESS`

HERMES token logic:

1. Load `.env`
2. Use cached valid access token if it has more than about 120 seconds left
3. If expired, try refresh token from `.env` or `cache\scienceon_token.json`
4. If refresh fails, generate a new token by AES-encrypting the `accounts` payload
5. On API auth error such as `401` / `E4103`, force a new token and retry once

Token request endpoint:

```text
https://apigateway.kisti.re.kr/tokenrequest.do
```

Data request endpoint:

```text
https://apigateway.kisti.re.kr/openapicall.do
```

### AES accounts payload

ScienceON expects the `accounts` parameter to be:

```text
URIEncode(Base64UrlSafe(AES256-CBC-PKCS7(JSON)))
```

HERMES uses:

- AES key: `SCIENCEON_API_KEY`
- IV: `jvHJ1EFA0IXBrxxz`
- JSON body:

```json
{"datetime":"yyyyMMddHHmmss","mac_address":"1C-79-2D-87-CD-37"}
```

HERMES implementation:

```python
body = json.dumps(
    {"datetime": datetime.now().strftime("%Y%m%d%H%M%S"), "mac_address": mac_address.strip()},
    ensure_ascii=False,
).replace(" ", "")
```

The fixed IV and URL-safe base64 are based on the ScienceON sample client.

## 5. Raw ScienceON Request Shape

Token request:

```text
https://apigateway.kisti.re.kr/tokenrequest.do?client_id={SCIENCEON_CLIENT_ID}&accounts={ENCRYPTED_ACCOUNTS}
```

Refresh request:

```text
https://apigateway.kisti.re.kr/tokenrequest.do?refreshToken={REFRESH_TOKEN}&client_id={SCIENCEON_CLIENT_ID}
```

Paper search request:

```text
https://apigateway.kisti.re.kr/openapicall.do?client_id={SCIENCEON_CLIENT_ID}&token={ACCESS_TOKEN}&version=1.0&action=browse&target=ARTI&searchQuery={SEARCH_QUERY_JSON}&curPage=1&rowCount=10&session_id={SCIENCEON_SESSION_ID}
```

HERMES field mapping:

| HERMES field | ScienceON field |
|---|---|
| `all` | `BI` |
| `title` | `TI` |
| `author` | `AU` |
| `abstract` | `AB` |
| `keyword` | `KW` |
| `publisher` | `PB` |
| `issn` | `SN` |
| `isbn` | `BN` |
| `year` | `PY` |
| `cn` | `CN` |
| `doi` | `DI` |

Example search query JSON before URL encoding:

```json
[{"BI":"공공서비스동기"}]
```

## 6. KCI Usage

KCI endpoint:

```text
https://open.kci.go.kr/po/openapi/openApiSearch.kci
```

Use KCI mainly for Korean article enrichment:

- `articleSearch`
- `articleDetail`
- `referenceSearch`
- `citation`

HERMES strategy:

1. Use ScienceON first for general collection.
2. Normalize and dedupe candidates.
3. Use KCI for domestic paper detail, DOI, abstract, citation count, and references.
4. Use CNU proxy only for original full-text PDF retrieval, never for ordinary metadata search.

## 7. Known Operational Notes

### Provider choice

For backfill and normal searching, prefer:

```text
--provider scienceon
```

Current observation:

- `--provider scienceon` works.
- `--provider all` returned 0 results during sample validation and should not be used as the primary backfill path until fixed.

### Authorized ScienceON APIs only

Earlier tests showed unauthorized API responses such as `E4302` for non-approved ScienceON capabilities.

Do not expose or rely on:

- resolver/link-resolution APIs not approved for this account
- volume/table-of-contents APIs not approved for this account

Use only approved paper/article search/detail flows.

### Token errors

| Error | Meaning | Response |
|---|---|---|
| `E4006` | MAC address cannot be extracted from encrypted `accounts` | Check AES key, fixed IV, JSON body, URL encoding, and `SCIENCEON_MAC_ADDRESS` |
| `E4103` / `401` | Access token invalid/expired | Force new token issuance and retry once |
| `E4302` | API not authorized for this account | Do not add that capability to HERMES |

## 8. Backfill Search Seed Terms

Use ScienceON first, then KCI enrichment.

### Korean

```text
정책 효과
제도 신뢰
공공서비스동기
관료재량
민군관계
인과추론
성과관리
행정책임
문민통제
도구변수
```

### English

```text
policy feedback
public service motivation
bureaucratic discretion
civil-military relations
causal inference
performance management
accountability
civilian control
instrumental variable
```

## 9. Google Drive Backfill Sheets

Drive folder:

```text
https://drive.google.com/drive/folders/1mutPWUsvDMY6FBt1JNYd8HMcYbUGpGlY
```

Sheets:

```text
HERMES_국문논문_평가표
https://docs.google.com/spreadsheets/d/1NMGXB04D6hOz8ifvIaTAmVqD0RKSlrXz4RMaX7wLbdI/edit

HERMES_영문논문_평가표
https://docs.google.com/spreadsheets/d/1_zwWGZRzCC5Q3JOuJn4LApYK5sqhzab3XhL-TO3dJns/edit

HERMES_백필_색인
https://docs.google.com/spreadsheets/d/1uW-XtiasfZ_xnr5WCjFwgXJAyFEAkLzVvNI_sTgnEy8/edit
```

Sample validation already wrote:

- 5 Korean sample rows
- 3 English sample rows
- 8 baseline index rows

## 10. Safety Rules for Future AI Operators

1. Do not print access tokens, refresh tokens, API keys, or this file's credential block in final answers.
2. Do not commit this file.
3. Do not use CNU proxy for metadata search.
4. Do not use unauthorized ScienceON APIs after receiving `E4302`.
5. Treat the first large backfill as baseline construction, not as new-paper alerts.
6. Always write every collected paper key to `HERMES_백필_색인` before enabling monitoring cron.
7. Use UTF-8 explicitly when reading generated files from PowerShell:

```powershell
Get-Content path\to\file.json -Encoding UTF8
```

