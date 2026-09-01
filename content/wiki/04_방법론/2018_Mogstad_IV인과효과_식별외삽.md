---
tags: [트랙B, 방법론, IV, 부분식별, 합성완료_인과추론방법론, 합성완료_도구변수]
저장일: 2026-05-28
title: "IV인과효과·식별외삽 (Mogstad 2018)"
password: "0310"
---

# 도구변수를 통한 인과효과의 식별과 외삽 (Identification and Extrapolation of Causal Effects with Instrumental Variables)

## 메타데이터
- **저자:** Magne Mogstad, Alexander Torgovitsky
- **연도:** 2018
- **저널:** Annual Review of Economics, 10, 577–613
- **DOI:** 10.1146/annurev-economics-101617-041813
- **연구 유형:** 방법론 리뷰 (LATE, 한계처리효과, 부분 식별 종합)

---

## 연구 질문

IV가 식별하는 LATE를 넘어서, 정책 관련 모집단에 대한 인과효과를 추정하려면 어떻게 외삽(extrapolation)해야 하는가?

---

## 이론적 틀

- **핵심 문제:** 자연실험 도구는 특정 순응자 집단의 LATE만 식별 — 정책이 영향을 미치는 집단과 도구가 영향을 미치는 집단이 달라 외삽 필요
- **핵심 개념:**
  - **한계처리효과(MTE; Marginal Treatment Effect):** Heckman & Vytlacil(1999, 2005) — 순응 경계에 있는 개인의 처리효과
  - **정책관련처리효과(PRTE; Policy-Relevant Treatment Effect):** Heckman & Vytlacil(2001) — 구체적 정책 변화에 영향받는 집단의 평균효과
  - **부분 식별(Partial Identification):** Mogstad et al.(2017) 일반 프레임 — 데이터 + 사전 가정을 유연하게 결합하여 목표 모수의 범위(bounds) 도출

---

## 방법론
- **분석 방법:** 문헌 리뷰 — 이진 처치·단조성 IV 모형 중심; 외삽에 필요한 조건 체계적 정리
- **특이사항:** 식별 문제를 통계적 추론 문제와 엄격히 구분 — 완전 지식 하에서 무엇을 알 수 있는지를 먼저 논의

---

## 핵심 발견

1. **LATE는 정책 관련 추정치가 아닐 수 있음:** 자연실험 도구(날씨·성별 구성)는 외적 타당도 낮음 — 정책 시사점을 위해 외삽 필수
2. **MTE 프레임워크:** 처리 확률(propensity score)에 따라 MTE를 추정하면 LATE, ATE, PRTE를 가중합으로 표현 가능
3. **부분 식별 프레임(Mogstad et al. 2017):** 외삽 범위와 가정 강도를 명시적으로 교환하면서 목표 모수 범위 도출 — 가정을 강화할수록 범위 좁아짐
4. **두 가지 점 식별 조건:** (1) 도구가 정책 영역 전체를 덮음, (2) 처리 확률이 정책과 동일 → 모두 지나치게 제한적

---

## 이론적 기여

Mogstad & Torgovitsky(2018)은 LATE 해석의 한계와 정책 외삽의 조건을 체계화하는 Annual Review 수준 종합이다. Aronow & Carnegie(2013)의 ATE 추정 시도와 보완 관계이며, 다양한 MTE 기반 연구의 이론적 기초를 제공한다.

---

## 재현·발전 가능성 [AI 분석]

- **군·정책 연구 접점:** 징병 추첨 연구(Ronconi, Getmansky, Weiss)에서 추첨 순응자 LATE를 전체 징집대상 모집단 PRTE로 외삽 시 필요한 가정 및 범위 추정
- **방법론:** MTE 프레임을 한국 정책 수혜자-비수혜자 자연실험에 적용

---

## 관련 개념 노드

[[도구변수]] [[LATE]] [[인과추론방법론]]
