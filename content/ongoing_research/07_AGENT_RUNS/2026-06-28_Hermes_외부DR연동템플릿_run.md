---
날짜: 2026-06-28
유형: 시스템개선
주제: 외부 Deep Research 연동 템플릿 구축
password: "0310"
---

# 실행 개요

교수님이 ChatGPT/Claude/Gemini의 Deep Research 수준 리터러쳐 리뷰를 Hermes 파이프라인에 접목하길 원해, 외부 정찰-내부 축적 하이브리드 운영을 바로 쓸 수 있게 템플릿과 운영규칙을 추가함.

## 이번 실행에서 한 일
- 외부 Deep Research 의뢰용 템플릿 생성
- Hermes 후처리/축적 프로토콜 생성
- `HERMES_BOOTSTRAP.md`에 외부 DR 연동 규칙 추가
- `ORCHESTRATOR_BRIEF.md`에 외부 DR 병행 원칙 추가

## 생성 파일
- `00_INBOX/EXTERNAL_DEEP_RESEARCH_REQUEST_TEMPLATE.md`
- `00_INBOX/HERMES_DEEP_RESEARCH_INGEST_PROTOCOL.md`

## 갱신 파일
- `00_INBOX/HERMES_BOOTSTRAP.md`
- `ORCHESTRATOR_BRIEF.md`

## 기대 효과
- 외부 Deep Research를 1차 정찰대로 활용 가능
- Hermes가 결과를 후보표/초록정리/PDF현황/run log로 흡수 가능
- 다음 반자동 연구 요청부터 즉시 적용 가능

## 교수님이 바로 할 수 있는 명령
1. 외부 Deep Research에 `00_INBOX/EXTERNAL_DEEP_RESEARCH_REQUEST_TEMPLATE.md` 내용으로 의뢰
2. 결과를 Hermes에 붙여 넣고 `00_INBOX/HERMES_DEEP_RESEARCH_INGEST_PROTOCOL.md` 기준으로 후처리 지시

## 승인 필요 여부
- 없음. 바로 사용 가능.
