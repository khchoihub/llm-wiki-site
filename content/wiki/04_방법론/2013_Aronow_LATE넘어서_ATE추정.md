---
tags: [트랙B, 방법론, IV, 합성완료_인과추론방법론, 합성완료_도구변수]
저장일: 2026-05-28
title: "LATE넘어서·ATE추정 (Aronow 2013)"
password: "0310"
---

# LATE를 넘어서: 도구변수로 평균처리효과 추정 (Beyond LATE: Estimation of the Average Treatment Effect with an Instrumental Variable)

## 메타데이터
- **저자:** Peter M. Aronow, Allison Carnegie
- **연도:** 2013
- **저널:** Political Analysis, 21, 492–506
- **DOI:** 10.1093/pan/mpt013
- **연구 유형:** 방법론 연구 (ICSW 추정량 개발 + 정치학 적용 2건)

---

## 연구 질문 및 문제

IV 추정은 순응자(complier)에 대한 국소평균처리효과(LATE)만 식별한다. 연구자가 전체 모집단의 평균처리효과(ATE)에 관심을 가질 때, LATE에서 ATE로 어떻게 이동할 수 있는가?

---

## 이론적 틀

- **LATE vs ATE:** IV는 도구에 의해 행동이 변하는 순응자(complier)에 대한 LATE만 식별 — 이질적 처리효과가 있으면 LATE ≠ ATE
- **핵심 아이디어:** 순응 점수(compliance score, 즉 순응자일 조건부 확률)를 추정하고, 역순응점수가중(ICSW; Inverse Compliance Score Weighting)으로 표본 재가중
- **필요 가정:** 도구 무작위 배정 + 무시가능성(ignorability; 순응자와 비순응자 간 관측 가능한 공변량 분포 일치)

---

## 방법론
- **데이터:** 정치학 게재 논문 2편 재분석 (캠페인 광고·투표 실험 포함)
- **분석 방법:** ML 순응 점수 추정 → ICSW → ATE 추정 (불편추정량 조건 + 가정 위반 시 결과 논의)
- **특이사항:** 2004–2009년 APSR·AJPS에서 IV 사용 34편 중 LATE 명시는 2편(6%)에 불과

---

## 핵심 발견

1. **LATE ≠ ATE:** 처리효과 이질성 시 두 추정치가 실질적으로 차이날 수 있음 — 재분석 사례에서 확인
2. **ICSW 추정량 제안:** 도구의 외생성으로 순응자에 대한 인과효과를 식별 → 무시가능성 하에 전체 모집단으로 외삽
3. **실제 적용 가이드라인:** 관심 모수(LATE vs ATE)를 명시할 것, 공변량 분포 균형 확인 필요
4. **가정 위반 시 강건성:** 무시가능성 실패 시 순응자 공변량 분포 재가중이 일관 추정량 조건을 완화 가능

---

## 이론적 기여

Aronow & Carnegie(2013)는 정치학 IV 연구의 주요 맹점 — LATE를 ATE로 해석하는 관행 — 을 비판하고 ICSW를 통한 실용적 해결책을 제안한다. Mogstad & Torgovitsky(2018)의 부분 식별 프레임워크와 함께 IV 외삽(extrapolation) 문헌의 초기 기여로 위치된다.

---

## 재현·발전 가능성 [AI 분석]

- **군·정책 연구 접점:** 징병 추첨 실험(Ronconi, Getmansky, Weiss)에서 LATE(추첨에 영향받은 집단)와 전체 복무자 ATE의 차이를 ICSW로 추정 가능
- **방법론:** 정치학 저널 한국어 논문의 IV 사용 현황 점검 + LATE/ATE 명시 여부 분석

---

## 관련 개념 노드

[[도구변수]] [[LATE]] [[인과추론방법론]]
