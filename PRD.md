# Walk Your Dog — 개선된 제품 요구사항 문서 (Advanced PRD)

> **버전:** 1.1  
> **작성일:** 2025-12-05  
> **변경사항:** Sequential Thinking을 통한 상세 기획, 유저 스토리, 데이터 모델 및 안드로이드 기술 명세 추가

---

## 1. 제품 개요 (Product Overview)
### 1.1 제품 비전
"단순한 산책 기록을 넘어, 반려견과 함께하는 모든 순간을 가치 있게 만드는 올인원 펫 피트니스 & 소셜 플랫폼."
반려견의 건강 관리(칼로리, 산책량)와 반려인의 동기부여(뱃지, 랭킹)를 결합하여 지속 가능한 산책 습관을 형성합니다.

### 1.2 핵심 목표 (Goals)
*   **User Goal:** 직관적인 산책 기록, 동기부여(게이미피케이션), 반려견 건강 모니터링.
*   **Business Goal:** 충성도 높은 커뮤니티 구축, 지역 기반 데이터 확보, 프리미엄 구독 모델 도입.

---

## 2. 유저 페르소나 (User Personas)
*   **A. 꼼꼼한 기록형 (Data Nerd):** 산책 경로, 거리, 시간, 칼로리 소모량 등 정확한 데이터를 원함. 통계 그래프 보는 것을 즐김.
*   **B. 동기부여 필요형 (Motivator):** 매일 산책이 귀찮음. 뱃지나 레벨업, 연속 산책일(Streak) 알림이 있어야 움직임.
*   **C. 소셜 교류형 (Socializer):** 우리 동네 강아지 순위, 다른 강아지들이 다니는 산책 코스 공유에 관심이 많음.
*   **D. 커뮤니티 리더 (Community Leader):** 지역 모임이나 견종 모임을 주최하고, 사람들과 소통하며 정보를 나누는 것을 좋아함.

---

## 3. 유저 스토리 (User Stories)
| ID | 액터 | 스토리 | 기대 효과 |
|:---|:---|:---|:---|
| US-01 | 사용자 | 앱을 켜지 않고도 산책을 빨리 시작하고 싶다. | 위젯 또는 퀵 액션을 통한 접근성 향상 |
| US-02 | 사용자 | 산책 도중 배터리가 부족해도 기록이 끊기지 않기를 원한다. | 백그라운드 위치 추적 안정성 및 로컬 DB 캐싱 |
| US-03 | 사용자 | 여러 마리의 강아지와 동시에 산책하고 싶다. | 멀티 프로필 선택 기능 및 개별 칼로리 계산 |
| US-04 | 사용자 | 산책 중 마킹한 장소나 배변 활동을 기록하고 싶다. | 핀(Pin) 드롭 기능 제공 (배변, 뷰포인트) |
| US-05 | 사용자 | 다른 사용자와 이번 주 산책 거리를 비교하고 싶다. | 주간 리더보드 및 친구 랭킹 시스템 |
| US-06 | 사용자 | 같은 동네 또는 같은 견종을 키우는 사람들과 소통하고 싶다. | 커뮤니티(클럽) 가입 및 게시판 기능 |
| US-07 | 사용자 | 산책 친구와 실시간으로 약속을 잡고 싶다. | 1:1 채팅 및 클럽 단체 채팅 |
| US-08 | 사용자 | 안 쓰는 강아지 용품을 믿을 수 있는 이웃에게 팔고 싶다. | '댕댕장터' - 인증된 사용자(10회/10마일 이상) 전용 마켓 |
| US-09 | 사용자 | 산책 경로 주변에서 저렴한 강아지 용품을 득템하고 싶다. | 지도 기반 물품 탐색 (오프라인/위치 기반 검색 한정) |

---

## 4. 상세 기능 명세 (Detailed Specifications)

### 4.1 트래킹 엔진 (Core Feature)
*   **실시간 GPS 추적:** `Geolocator` 패키지 활용.
    *   **Foreground:** 지도 위에 실시간 경로(Polyline) 드로잉.
    *   **Background:** 안드로이드 Foreground Service + Notification을 활용하여 화면이 꺼져도 위치 수집.
*   **정확도 보정:**
    *   GPS 잡음 제거 (Kalman Filter 또는 이동 거리 Threshold 적용).
    *   자동 일시정지 (일정 시간 움직임 없을 시 타이머 멈춤).
*   **활동 기록:** 거리(km), 시간(분), 고도, 평균 속도.

### 4.2 펫 관리 및 건강 (Pet Health)
*   **프로필:** 이름, 견종(Breed), 나이, 체중, 성별, 중성화 여부.
*   **칼로리 알고리즘:**
    *   METs(Metabolic Equivalent of Task) 기반 공식 적용.
    *   `(반려견 체중) x (거리) x (계수)` + 견종 특성 가중치 적용.

### 4.3 게이미피케이션 (Gamification)
*   **뱃지 시스템:**
    *   *얼리버드:* 아침 6-8시 산책 10회.
    *   *마라토너:* 1회 산책 5km 이상 달성.
    *   *레인워커:* 비 오는 날 산책 달성 (날씨 API 연동).
*   **레벨 시스템:** 누적 거리에 따라 브론즈 → 실버 → 골드 → 다이아몬드 등급 부여.

### 4.4 소셜 & 커뮤니티 (Social & Community)
*   **친구 (Friends):**
    *   친구 검색(닉네임/ID) 및 QR 코드로 친구 추가.
    *   친구 활동 알림 및 넛지(Nudge - 콕 찌르기) 보내기.
*   **채팅 (Chat):**
    *   **1:1 채팅:** 친구 간 산책 약속 잡기, 사진 공유.
    *   **그룹 채팅:** 커뮤니티(클럽) 멤버 간 실시간 대화.
*   **커뮤니티(클럽) (Clubs):**
    *   **유형:** 
        1.  **지역 커뮤니티:** "서울 강남구 산책 모임" (위치 기반).
        2.  **견종 커뮤니티:** "말티즈는 참지않긔" (관심사 기반).
    *   **기능:** 모임 생성/가입, 게시판(정보 공유), 정기 산책 모임 일정(Event) 생성.
*   **맵 기능 (Map):**
    *   **히트맵(Heatmap):** 인기 산책로 열지도 표시.
    *   **친구 위치 공유:** (동의 시) 실시간 산책 중인 친구 위치 표시.

### 4.5 댕댕장터 (Dog Market) - *Walk to Buy*
*   **컨셉:** "찐 산책러들을 위한, 발로 뛰는 중고거래".
*   **사용 조건 (Unlock):** 
    *   **진입 장벽:** 누적 산책 **10회 이상** AND 누적 거리 **10마일(약 16km) 이상** 달성 시 메뉴 해금.
    *   *목적:* 허위 매물 방지 및 실제 반려인 인증(Proof of Walk).
*   **거래 품목 제한:** 오직 **강아지 관련 용품**만 등록 가능 (사료, 옷, 장난감 등). AI 이미지 분석으로 비관련 물품 자동 필터링 도입 고려.
*   **오프라인 중심 검색 (Walk-to-Search):**
    *   **검색 제한:** 텍스트 키워드 검색 불가(또는 제한적).
    *   **지도 탐색:** 내 주변 반경(Geo-fencing) 내에 '드랍'된 물건만 지도상 핀으로 확인 가능.
    *   **거래 방식:** 100% 직거래 유도 (동네 인증 기반).
*   **특전:** 거래 완료 시 '산책 포인트' 추가 지급.

---

## 5. 안드로이드 기술 구현 전략 (Technical Details)

### 5.1 아키텍처 (Clean Architecture)
*   **Presentation:** Flutter (BLoC or Riverpod for State Management).
*   **Domain:** UseCases, Entities, Repository Interfaces.
*   **Data:**
    *   *Remote:* Firebase Firestore (NoSQL).
    *   *Local:* ObjectBox 또는 Hive (오프라인 우선 지원을 위해 로컬에 먼저 저장 후 네트워크 연결 시 동기화).

### 5.2 위치 서비스 최적화 (Android Specific)
*   **권한:** `ACCESS_FINE_LOCATION`, `ACCESS_BACKGROUND_LOCATION` (안드로이드 10+ 대응 필요).
*   **배터리 최적화 예외 처리:** `REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` 인텐트 사용하여 트래킹 중 Doze 모드 방지.
*   **Notification:** '산책 중' 상태를 알리는 고정 알림(Ongoing Notification) 필수.

### 5.3 데이터 모델 (Firestore Draft)
```json
// Users Collection
users/{uid}: {
  nickname: "String",
  totalDist: "Number",
  level: "Number",
  createdAt: "Timestamp"
}

// Pets Collection
users/{uid}/pets/{petId}: {
  name: "Dooboo",
  breed: "Maltese",
  weight: "3.5",
  birthdate: "Date"
}

// Walks Collection (Global or Subcollection)
walks/{walkId}: {
  userId: "uid",
  petIds: ["petId1", "petId2"],
  startTime: "Timestamp",
  endTime: "Timestamp",
  distanceMeter: 1250,
  pathPoints: [{lat: 37.5, lng: 127.0}, ...], // 압축 저장 필요 (Polyline alg)
  caloriesBurned: 55,
  images: ["url1", "url2"]
}

// Clubs Collection
clubs/{clubId}: {
  name: "Gangnam Dog Walkers",
  description: "Walking together in Gangnam",
  type: "LOCAL" | "BREED", // 지역 기반 or 견종 기반
  region: "Gangnam-gu", // 위치 필터용
  targetBreed: "All" | "Maltese", // 견종 필터용
  ownerId: "uid",
  memberCount: 15,
  createdAt: "Timestamp"
}

// ChatRooms Collection
chatRooms/{roomId}: {
  type: "DIRECT" | "GROUP",
  participants: ["uid1", "uid2"],
  lastMessage: "Shall we meet at 5?",
  lastMessageTime: "Timestamp"
}

// Messages Subcollection
chatRooms/{roomId}/messages/{messageId}: {
  senderId: "uid",
  content: "Hello world",
  createdAt: "Timestamp",
  readBy: ["uid1"]
}

// MarketItems Collection
marketItems/{itemId}: {
  sellerId: "uid", // User must meet criteria (walks > 10, dist > 10mi)
  title: "Small Dog Raincoat",
  category: "Clothing", // Must be dog related
  price: 5000,
  location: {lat: 37.51, lng: 127.04}, // GeoPoint
  status: "ON_SALE" | "RESERVED" | "SOLD",
  description: "Used only once",
  images: ["url"]
}
```

---

## 6. 수익화 전략 (Monetization) - 부분 유료화(Freemium)
1.  **Free:** 기본 산책 기록, 최근 1개월 히스토리, 기본 뱃지.
2.  **Premium ($4.99/mo):**
    *   무제한 히스토리 조회.
    *   심층 건강 리포트 (월간 체중 변화, 권장 활동량 분석).
    *   다중 프로필 관리 (3마리 이상).
    *   전용 뱃지 및 테마 맵 제공.
    *   **마켓 프리미엄:** '댕댕장터' 판매 게시물 강조(Highlight) 효과, 키워드 알림 기능.

---

## 7. 로드맵 (Roadmap)
*   **Phase 1 (MVP):** 단일 반려견 산책 기록, 로컬 저장소 우선, 기본 통계.
*   **Phase 2 (Cloud Sync & Social Basic):** 회원가입, Firebase 연동, 친구 추가 및 1:1 채팅, 클라우드 백업.
*   **Phase 3 (Community & Market):** 클럽(커뮤니티) 기능, 댕댕장터(마켓) 오픈, 리더보드.
*   **Phase 4 (Expansion):** 웨어러블(워치) 앱 연동, 소모품(사료/배변봉투) 커머스 연동.

---

## 8. 리스크 및 대응 (Risks & Mitigation)
*   **GPS 튐 현상:** 경로 스무딩 알고리즘 필수 구현. 실내/지하 진입 시 위치 추적 일시 정지 로직 추가.
*   **배터리 소모:** 위치 업데이트 주기를 상황(이동 속도)에 따라 가변적으로 조절 (Adaptive Interval).
*   **프라이버시:** 산책 경로 공유 시 시작점/끝점(집 위치) 주변 반경 100m는 자동으로 마스킹 처리하여 노출 방지.
