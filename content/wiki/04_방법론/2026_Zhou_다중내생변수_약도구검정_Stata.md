---
tags: [트랙B, 방법론, IV, Stata]
저장일: 2026-05-28
title: "다중내생변수·약도구검정·Stata (Zhou 2026)"
---

# 다중 내생변수 약한 도구 강건 검정 Stata 구현 (A Robust Test for Weak Instruments with Multiple Endogenous Regressors in Stata)

## 메타데이터
- **저자:** Lingyun Zhou
- **연도:** 2026
- **저널:** The Stata Journal, 26(1), 90–110
- **DOI:** 10.1177/1536867X261425792
- **연구 유형:** 방법론 Stata 명령어 개발 (weakivtest2)
- **파일 참고:** 처리대기목록상 `Olea, J. L. M., & Pflueger, C. (2013) STAT.pdf`로 저장되었으나 내용은 Zhou(2026)임

---

## 연구 질문

Lewis & Mertens(Forthcoming, RES)의 다중 내생변수 강건 약한 도구 검정을 Stata에서 어떻게 구현하는가? weakivtest2 명령어는 어떻게 작동하는가?

---

## 이론적 틀

- **배경:** Montiel Olea & Pflueger(2013)의 weakivtest 명령어는 단일 내생변수에 한정 — 다중 내생변수는 Sanderson & Windmeijer(2016), 더 일반적으로는 Lewis & Mertens(Forthcoming)
- **핵심 방법:** Lewis & Mertens의 Nagar 편향 기반 약한 도구 검정 — H0: 2SLS 점근 편향이 허용 수준 τ 초과
- **편향 기준 두 가지:** (1) 절대 편향 기준(Babs), (2) 상대 편향 기준(Brel, OLS 최악 사례 대비) — Stock-Yogo 및 Montiel Olea-Pflueger 확장

---

## 방법론
- **Stata 명령어:** `weakivtest2` — ivreg2, xtivreg2, ivreghdfe 사후 추정 명령어
- **분석 방법:** 몬테카를로 시뮬레이션으로 MATLAB 구현과 수치 일관성 확인 + Ramey & Zubairy(2018) 거시경제 모형 실증 적용
- **특이사항:** avar 패키지 필요; 개별 β 추정치 및 전체 벡터 동시 검정 가능

---

## 핵심 발견

1. **weakivtest2 명령어 구현:** 다중 내생변수(N ≥ 2) 경우 이분산·직렬상관 조건에서 Lewis-Mertens 약한 도구 검정 수행
2. **기존 명령어와 연속성:** weakivtest(Pflueger & Wang 2015, 단일 내생변수)의 다변수 확장 — 일관된 인터페이스
3. **두 편향 기준:** 절대(Babs)·상대(Brel) 기준 모두 지원 — 사용자가 허용 편향 수준 τ 지정
4. **실증 예시:** Ramey-Zubairy 거시 모형에서 weakivtest2가 기존 방법과 다른 결과 도출 가능성 예시

---

## 이론적 기여

Zhou(2026)는 Andrews et al.(2019)이 지적한 다중 내생변수 약한 도구 검정 공백을 Lewis & Mertens의 이론을 Stata로 구현하여 메운다. 이분산·군집 오차 환경에서 다변수 IV 설계의 표준 진단 도구로 기능한다.

---

## 재현·발전 가능성 [AI 분석]

- **방법론:** 복수의 사회정책 변수 또는 군복지 변수를 내생 처리하는 연구에서 weakivtest2 활용 가능
- **Stata 실무:** ivreg2 + weakivtest2 + ar2 조합이 현재 다중 내생변수 IV 검정의 모범 관행

---

## 관련 개념 노드

[[도구변수]] [[약한도구변수]] [[인과추론방법론]]
