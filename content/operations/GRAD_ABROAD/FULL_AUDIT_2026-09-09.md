---
tags: [GRAD_ABROAD_운영, 품질감사]
최종수정: 2026-09-10
규격버전: "4.0"
password: "0310"
---

# GRAD/ABROAD 전체 품질 감사 — 2026-09-09

## 판정

**최종 본문은 77/77개가 완료 상태다.** GRAD 34개와 ABROAD 43개를 전수 검사한 결과 자동검사 `PASS` 66개, 범위 모델의 문서화된 경고를 포함한 `PASS WITH WARNINGS` 11개, `FAIL` 0개였다. 2026-09-10 후속 포렌식에서 변환 전 전체 기준본 77개도 복원해 메타데이터와 기존 링크를 전수 대조했다.

## 감사 범위와 방법

- 두 관문에서 도달되는 세부문서: GRAD 34/34, ABROAD 43/43.
- 문서ID·경로·STATUS 대응: 77/77 일치.
- 외부 증거 패키지: 문서별 `DISCOVERY.md`, `SOURCE_CARDS.md`, `INFORMATION_UNITS.md`, `CLAIM_GRAPH.md`, `QA.md` 5종이 77/77 존재하며 비어 있지 않음.
- 자동검사: `tools/validate_grad_abroad_note.py`를 각 문서와 지정 DB에 대해 재실행.
- 구조 감사: frontmatter, 원본건수, 각주 정의·호출, DB 게시물·댓글 ID와 댓글 부모, 소분류 범위, 내부링크, 개인정보·URL 패턴, 굵은 강조와 각주 더미를 검사.
- 내용 감사: 중복 문단, 관문 도달성, 정보단위 장부의 V4 필드, QA 판정의 현재성, STATUS 일관성을 점검.
- 금지사항 준수: 웹 검색·외부 자료 보충·`publish.ps1`·commit·push를 실행하지 않음.

## 자동검사 결과

| 결과 | 문서 수 | 해석 |
|---|---:|---|
| PASS | 66 | 자동 규칙상 미해소 경고 없음 |
| PASS WITH WARNINGS | 11 | 아래 범위 예외가 있으며 QA/근거 장부로 해소 |
| FAIL | 0 | 차단 오류 없음 |

남은 경고는 다음 다섯 종류다.

1. NULL 또는 합집합 범위를 검증기가 단일 `primary/sub_category`로 추론하지 못함: G-REVIEW-008, G-023, A-REVIEW-008, A-033.
2. 의도적으로 인접 소분류의 반론·세부 사례를 인용함: G-021, A-027, A-025, A-032.
3. 교차 1차분류 근거를 GMAT 비교에 사용함: A-037.
4. 보존 원본 스냅샷 36건 이후 DB가 40건으로 증가함: G-025.
5. 실행 체크리스트 문장을 보수적 휴리스틱이 구체 주장으로 탐지함: A-003. 이 문장은 사건·수치·연도의 사실 주장이 아니라 비교 항목을 제시하는 편집 지침이므로 수동 통과한다.

## 이번 직권 보완

- A-024의 동일 행 근거 누락 4곳에 직접 각주를 연결했다. 재검사 결과 `PASS`로 전환됐다.
- G-REVIEW-002, G-REVIEW-004, G-REVIEW-005, G-REVIEW-006, G-REVIEW-007, G-REVIEW-008의 정보단위 장부를 V4 필수 필드 7종으로 정규화했다.
- 대표 일반문서 G-026과 시범문서 G-014의 정보단위 장부도 같은 필드로 보완했다.
- G-024의 “자동검사 예정”, G-014·G-015의 “사용자 승인 대기”, A-024의 과거 수동 경고 판정을 현재 결과에 맞게 교정했다.
- `GRAD/index.md`, `ABROAD/index.md`의 감사일을 갱신하고 A-003의 낡은 `[재확인]` 표지를 제거했다.
- `STATUS.md`의 현재 단계를 전체 감사 완료 상태로 정정했다.
- `CURRENT_MANIFEST_2026-09-09.md`에 현재 완성본 77개의 SHA-256을 기록해 이후 변경의 전향적 기준점을 만들었다.
- 2026-09-10 내부 turn-diff tree에서 변환 전 기준본 77/77을 복원하고 안정된 로컬 ref 두 개와 `BASELINE_RECOVERY_2026-09-09.md`에 고정했다.
- 복원 대조에서 빠진 기존 링크 20개를 발견했다. 유효 링크 19개는 원래 대상으로 복구하고, 과거부터 dangling이던 `군인사정책` 1개는 기존 노드의 별칭 링크로 정상화했다.
- 정보단위 장부 77개·1,583단위를 동일한 V4 10열 스키마로 통일했다. 빈 필드·중복 활성 스키마는 0건이다.
- 두 관문의 77개 한 줄 설명을 최종 문서의 판단·메커니즘·실행 결론 중심으로 전면 재작성했다. 링크·별칭·원본건수는 모두 보존했다.

## 후속 핵심과제 완료

### 1. 기준본 복원

초기에는 일반 Git 경로 이력만 확인해 대부분의 기준본을 복원할 수 없다고 판단했다. 2026-09-10 내부 Codex turn-diff의 전체 tree까지 조사한 결과 2026-09-07 시점의 77개 전체 스냅샷 두 개를 회수했다. 이를 `refs/grad-abroad/baselines/pre-v4-initial`과 `refs/grad-abroad/baselines/pre-v4-followup`으로 고정하고, 두 ref를 독립 bundle `GRAD_ABROAD_BASELINES_2026-09-10.bundle`로도 보존했다. 문서별 blob은 `BASELINE_RECOVERY_2026-09-09.md`, 전후 구조 대조는 `BASELINE_COMPARISON_AUDIT_2026-09-10.md`에 기록했다.

### 2. 정보단위 필드 통일

77개 `INFORMATION_UNITS.md`의 활성 표를 `unit_id`, `type`, `content`, `source_ids`, `importance`, `target_claim`, `retained_location`, `omission_reason`, `presentation_layer`, `footnote_role`로 통일했다. 실제 ID가 기존 장부에 없던 경우에는 추정하지 않고 SOURCE_CARDS·CLAIM_GRAPH 참조로 표시했다. 원본 장부는 `GRAD_ABROAD_EVIDENCE_PRE_SCHEMA_2026-09-10.zip`에 보존했다. 세부 결과는 `EVIDENCE_SCHEMA_AUDIT_2026-09-10.md`에 있다.

### 3. 관문 설명 재편집

GRAD 34개와 ABROAD 43개의 한 줄 설명을 모두 최종 문서의 핵심 결론 중심으로 다시 썼다. 링크 대상·별칭·원본건수는 기준본과 일치하며, 결과는 `GATEWAY_EDITORIAL_AUDIT_2026-09-10.md`에 기록했다.

## 최종 결론

77개 최종 문서는 사용 가능한 완료 상태이며 차단 오류는 없다. 기준본 복원, 기존 링크 보존, 증거 장부 표준화, 관문 결론 중심 재편집까지 완료했다. 남은 11개 자동 경고는 NULL·합집합·교차분류·시점별 DB 건수처럼 이미 근거 장부에 설명된 범위 모델 예외이며, 미해소 본문 결함은 아니다.
