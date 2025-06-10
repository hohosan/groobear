---
## Intro
1. 팀 소개
2. 프로젝트 소개
3. 설계 시 중요점
4. 개발환경
5. 맡은 기능
6. ERD
---
<br/>
<br/>

## 1️⃣ 팀 소개

### 👩🏻‍💻 7FS 👩🏻‍💻
> **7** **F**ull **S**tack
> 
> **-** 저희 프로젝트는 총 7명으로 구성된 팀으로 진행 되었습니다.
> 
> **-** 모두가 **Full Stack 개발자**가 되자는 목표 아래 팀명을 7FS로 정했습니다.
<br/>
<br/>


## 2️⃣ 프로젝트 소개

#### 🔸 그룹웨어, 그루베어
#### 🔸 회사 조직의 업무 효율성을 UP ! 
#### 🔸 직원들의 협업 및 소통할 수 있도록 지원
![그루베어 로고](https://github.com/hohosan/groobear/blob/main/%E1%84%80%E1%85%B3%E1%84%85%E1%85%AE%E1%84%87%E1%85%A6%E1%84%8B%E1%85%A5_%E1%84%85%E1%85%A9%E1%84%80%E1%85%A9.png)

#### 그룹웨어를 주제로 선정한 이유 ?
> 실무에서 바로 활용 가능한 시스템을 직접 구현할 수 있는 경험
>
> 개발자로서의 역량을 골고루 다져볼 수 있는 기회
>

<br/>
<br/>


## 3️⃣ 설계 시 중요하게 생각한 점
#### 🔸 접근성
  메뉴를 직관적으로 구성하여 누구나 쉽게 사용할 수 있도록 하여 접근성을 높였습니다.

#### 🔸 편의성
  100% 웹 기반으로 설계해, 모든 구성원이 언제 어디서든 실시간으로 최신 자료를 확인할 수 있도록 했습니다.

#### 🔸 오류 최소화
  다양한 테스트를 통해 발견된 오류들을 지속적으로 수정하여, 사용자 불편을 최소화했습니다.

<br/>
<br/>

## 4️⃣ 개발환경
![그루베어 개발환경](https://github.com/hohosan/groobear/blob/main/%E1%84%80%E1%85%B3%E1%84%85%E1%85%AE%E1%84%87%E1%85%A6%E1%84%8B%E1%85%A5_%E1%84%80%E1%85%A2%E1%84%87%E1%85%A1%E1%86%AF%E1%84%92%E1%85%AA%E1%86%AB%E1%84%80%E1%85%A7%E1%86%BC_%E1%84%8E%E1%85%AC%E1%84%8C%E1%85%A9%E1%86%BC.png)

<br/>
<br/>

## 5️⃣ 맡은 기능
1. 조직도
2. 부서 및 사원 관리
3. 비밀번호 변경
4. 근태 현황
5. 연차 현황 및 관리

<details>
  <summary>
    <h2>🔸 조직도</h2>
  </summary>

  ![조직도 gif](https://github.com/hohosan/groobear/blob/main/%E1%84%8C%E1%85%A9%E1%84%8C%E1%85%B5%E1%86%A8%E1%84%83%E1%85%A9_gif.gif)

  - jsTree API, 공통코드 테이블, 비동기 fetch문 사용
  - 다른 기능에서도 조직도를 사용할 수 있도록 재사용성을 고려하여 구현
  - keydown 이벤트로 로그인된 사용자의 이름을 자동 검색되도록 구현
</details>

---

<details>
  <summary>
    <h2>🔸 부서 및 사원 관리</h2>
  </summary>

<div align=center><h2>▪️ 부서 관리 ▪️</h2></div>

![부서관리gif](https://github.com/hohosan/groobear/blob/main/%E1%84%87%E1%85%AE%E1%84%89%E1%85%A5%E1%84%83%E1%85%B3%E1%86%BC%E1%84%85%E1%85%A9%E1%86%A8gif.gif)


<br/>
<br/>

---

<br/>
<br/>


<div align=center><h2>▪️ 사원 관리 ▪️</h2></div>

![사원관리gif](https://github.com/hohosan/groobear/blob/main/%E1%84%89%E1%85%A1%E1%84%8B%E1%85%AF%E1%86%AB%E1%84%80%E1%85%AA%E1%86%AB%E1%84%85%E1%85%B5gif.gif)

- 로그인된 사용자가 관리자일 경우 부서 및 사원을 CRUD 할 수 있도록 구현
- 부서 등록 시 입력 필드 많지 않기 때문에 Modal 창으로 띄워지도록 구현
- 부서 및 사원 등록 시 필수 데이터가 누락되지 않도록 밸리데이션 처리
  
</details>

---

<details>
  <summary>
    <h2>🔸 비밀번호 변경</h2>
  </summary>

![비번변경gif](https://github.com/hohosan/groobear/blob/main/%E1%84%87%E1%85%B5%E1%84%87%E1%85%A5%E1%86%AB%E1%84%87%E1%85%A7%E1%86%AB%E1%84%80%E1%85%A7%E1%86%BC_gif.gif)

- 조건문을 활용하여 현재 비밀번호와 일치한지 확인 여부
- 변경 할 비밀번호 조합을 조건문으로 처리하여 사용 가능 여부에 따라 글자 색이 바뀌도록 구현
- 비밀번호 변경 실패 여부를 sweetalert를 활용하여 경고창 출력
  
</details>

---

<details>
  <summary>
    <h2>🔸 근태 현황</h2>
  </summary>

![근태현황gif](https://github.com/hohosan/groobear/blob/main/%E1%84%80%E1%85%B3%E1%86%AB%E1%84%90%E1%85%A2%E1%84%92%E1%85%A7%E1%86%AB%E1%84%92%E1%85%AA%E1%86%BCgif.gif)

- 등록된 출, 퇴근 시간으로 하루 총 근무시간 등 근태 현황 조회 가능
- 월 별 근태 현황 데이터 조회 가능
  
</details>

---

<details>
  <summary>
    <h2>🔸 연차 현황 및 관리</h2>
  </summary>

  <div align=center><h2>▪️ 연차 현황 ▪️</h2></div>

![연차현황조회gif](https://github.com/hohosan/groobear/blob/main/%E1%84%8B%E1%85%A7%E1%86%AB%E1%84%8E%E1%85%A1%E1%84%92%E1%85%A7%E1%86%AB%E1%84%92%E1%85%AA%E1%86%BC_gif.gif)

- 이번년도 연차 개수 현황 조회
- 월 별 연차 사용 내역 조회
- 공가, 병가, 연가 등 keydown 이벤트 엔터로 검색 가능

<br/>
<br/>

---

<br/>
<br/>

  <div align=center><h2>▪️ 연차 관리 ▪️</h2></div>

![연차관리gif](https://github.com/hohosan/groobear/blob/main/%E1%84%8B%E1%85%A7%E1%86%AB%E1%84%8E%E1%85%A1%E1%84%80%E1%85%AA%E1%86%AB%E1%84%85%E1%85%B5_gif.gif)

- 관리자가 사원에게 성과 , 보상 연차 지급 및 차감 가능
- Modal창으로 각 사원의 연차 개수 현황 조회 가능
- 페이지네이션 , 검색 기능 구현

<br/>
<br/>

---

<br/>
<br/>

<div align=center><h2>▪️ 연차 관리 - 엑셀 다운 ▪️</h2></div>

![연차엑셀gif](https://github.com/hohosan/groobear/blob/main/%E1%84%8B%E1%85%A7%E1%86%AB%E1%84%8E%E1%85%A1%E1%84%80%E1%85%AA%E1%86%AB%E1%84%85%E1%85%B5_%E1%84%8B%E1%85%A6%E1%86%A8%E1%84%89%E1%85%A6%E1%86%AF%E1%84%83%E1%85%A1%E1%84%8B%E1%85%AE%E1%86%AB_gif.gif)

- Apache POI 라이브러리 사용하여 엑셀 다운로드 구현
- 검색한 keyword에 따라 엑셀의 제목과 데이터가 동적으로 변환 되도록 구현
  
</details>

<br/>
<br/>

## 6️⃣ERD
![ERD](https://github.com/hohosan/groobear/blob/main/%E1%84%80%E1%85%B3%E1%84%85%E1%85%AE%E1%84%87%E1%85%A6%E1%84%8B%E1%85%A5_ERD.png)

- 총 48개의 테이블




