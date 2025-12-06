# Walk Your Dog — UI/UX Design & 화면 구성 명세서

> **문서 목적:** PRD 1.1을 기반으로 실제 앱의 디자인 가이드라인과 화면 흐름을 정의합니다. 생성형 AI(Midjourney, DALL-E 3 등)를 활용하여 시안을 제작할 수 있도록 **최적화된 프롬프트**를 포함합니다.

---

## 1. 디자인 컨셉 (Design System)

### 1.1 핵심 키워드
*   **Energetic & Friendly:** 반려견과의 산책은 즐거운 활동입니다. 밝고 경쾌한 무드를 유지합니다.
*   **Clean & Premium:** 복잡한 데이터(통계, 지도)를 깔끔하게 정리하고, 글래스모피즘(Glassmorphism)과 부드러운 그림자를 사용하여 고급스러운 느낌을 줍니다.
*   **Gamified:** 뱃지, 프로그레스 바 등 게임 요소가 돋보이게 디자인합니다.

### 1.2 컬러 팔레트 (Color Palette)
*   **Primary:** `Energetic Orange (#FF6B6B)` - 행동 유도(Start Button), 강조.
*   **Secondary:** `Fresh Mint (#4ECDC4)` - 건강, 지도 경로, 긍정적 수치.
*   **Background:** `Clean White (#FAFAFA)` (Light Mode) / `Deep Charcoal (#222831)` (Dark Mode).
*   **Surface:** 살짝 투명한 흰색 배경 + 블러 효과 (Glassmorphism).

---

## 2. 주요 화면 구성 (Screen Flow)

### 2.1 스플래시 & 온보딩 (Splash & Onboarding)
*   **설명:** 앱의 첫인상. 감성적인 일러스트와 함께 앱의 핵심 가치(추적, 건강, 소셜)를 소개하고 반려견 프로필 설정을 유도합니다.
*   **주요 요소:**
    *   3D 스타일의 귀여운 강아지 캐릭터.
    *   부드러운 페이지 인디케이터.
    *   "시작하기" 큰 버튼.
*   **AI Design Prompt:**
    ```text
    Mobile app onboarding screen design for a dog walking app, high quality UI, cute 3D cartoon style dog character walking happily, vibrant orange and mint color scheme. Minimalist layout, large rounded 'Get Started' button at the bottom, soft gradient background, clean typography. UX/UI design, Dribbble trend 2024, high fidelity, 4k.
    ```

### 2.2 홈 대시보드 (Home Dashboard)
*   **설명:** 앱의 메인 허브. 사용자가 가장 많이 보게 될 화면으로, "산책 시작"이 가장 쉬워야 합니다.
*   **주요 요소:**
    *   **상단:** 현재 선택된 반려견의 미니 프로필 & 레벨/경험치 바.
    *   **중앙:** 오늘의 목표 달성률(걸음 수/거리)을 보여주는 대형 원형 프로그레스 링.
    *   **하단:** 매우 크고 직관적인 "산책 시작(Start Walk)" 버튼 (Floating Action Button).
    *   **위젯:** 이번 주 통계 요약 카드, 읽지 않은 뱃지 알림.
*   **AI Design Prompt:**
    ```text
    Mobile app UI design, Home Dashboard for 'Walk Your Dog' app. Centerpiece is a large, glowing circular progress ring showing daily steps goal with a 3D paw print icon inside. Bottom center features a massive, pulsating orange 'Start Walk' button with soft shadow. Top section shows a cute dog avatar card with a level bar. Clean white background, slight glassmorphism on cards, modern and energetic vibe. UX/UI, IOS 17 style.
    ```

### 2.3 산책 트래킹 (Active Walking Mode)
*   **설명:** 산책 중 실제 사용하는 화면. 지도가 메인이며 조작 실수를 방지하기 위해 UI가 큼직해야 합니다.
*   **주요 요소:**
    *   **배경:** 전체 화면 구글 지도 (경로는 Mint 색상 Polyline으로 표시).
    *   **상단:** 현재 산책 시간, 거리, 칼로리 정보가 담긴 반투명 플로팅 카드.
    *   **하단 컨트롤 패널:** 일시정지(Pause), 종료(Stop), 사진 촬영(Camera) 버튼.
    *   **제스처:** 지도를 스와이프하여 크게 보기 가능.
*   **AI Design Prompt:**
    ```text
    Mobile app UI design, Active GPS tracking screen for dog walking. Full-screen custom map with dark roads and a glowing bright mint-green path line. Top floating glassmorphism card displaying large typography for 'Time', 'Distance', and 'Calories'. Bottom control panel with a slide-to-stop button and large circular pause button. High contrast for outdoor visibility, premium map interface design.
    ```

### 2.4 산책 종료 및 요약 (Walk Summary)
*   **설명:** 산책 완료 후 보상을 받는 화면. 성취감을 극대화해야 합니다.
*   **주요 요소:**
    *   이동한 경로의 썸네일 지도 이미지.
    *   획득한 뱃지나 아이템이 있을 경우 폭죽(Confetti) 효과와 함께 팝업.
    *   상세 수치 그리드 (시간, 거리, 평균 속도, 태운 칼로리).
    *   반려견의 기분/배변 횟수 기록 태그 선택.
*   **AI Design Prompt:**
    ```text
    Mobile app UI design, Walk Summary success screen. Celebration atmosphere with confetti effects. Center shows a stylized map card of the route just walked. Below it, a grid of stats (Distance, Calories, Time) with colorful icons. A 'New Badge Unlocked' golden medal notification pops out. Bright, cheerful, rewarding visual style. 'Share' and 'Done' buttons at the bottom.
    ```

### 2.5 통계 및 리포트 (Stats & History)
*   **설명:** 데이터 분석을 좋아하는 '꼼꼼한 기록형' 유저를 위한 화면.
*   **주요 요소:**
    *   주간/월간 탭 전환.
    *   막대 그래프(주간 활동량) 및 꺾은선 그래프(체중 변화).
    *   산책 히스토리 리스트 (날짜, 대표 이미지, 거리).
*   **AI Design Prompt:**
    ```text
    Mobile app UI design, Statistics analytics page. Clean bar charts with rounded tops showing weekly walking distance in orange and teal gradient. Below, a list view of past walks with date and mini map thumbnails. Minimalist data visualization, easy to read, plenty of whitespace. Dark mode UI, neon accents on the charts.
    ```

### 2.6 커뮤니티 & 클럽 (Community & Clubs)
*   **설명:** 동기부여를 위한 경쟁 및 로컬 커뮤니티 화면.
*   **주요 요소:**
    *   **상단 탭:** 랭킹 (Leaderboard) / 클럽 (Clubs) / 채팅 (Chats).
    *   **랭킹:** 1, 2, 3위 포디움 및 내 순위 독(Dock).
    *   **클럽:** 내 주변 모임 카드 ("강남구 산책러"), 가입 버튼.
    *   **채팅:** 1:1 대화 및 클럽 단체방 목록.
*   **AI Design Prompt:**
    ```text
    Mobile app UI design, Community and Clubs page. Top tabs for 'Ranking', 'Clubs', 'Chat'. Main view shows a list of local dog walking clubs with vibrant cover images and member counts. Bottom features a floating 'Create Club' button. Modern social networking interface, clean and friendly.
    ```

### 2.7 댕댕장터 (Dog Market)
*   **설명:** 오프라인/지도 기반의 강아지 용품 중고 거래 화면. "Walk to Shop" 컨셉을 시각화해야 합니다.
*   **주요 요소:**
    *   **메인 지도 뷰:** 내 주변에 떨어진 상품들이 '핀(Pin)' 형태로 꽂혀 있음. 핀 아이콘은 상품 카테고리(옷, 사료 등)를 나타냄.
    *   **리스트 보기:** 하단 시트(Bottom Sheet)를 끌어올려 가까운 거리 순으로 상품 목록 확인.
    *   **상품 상세:** 상품 사진(Carousel), 가격, 판매자와의 거리, "채팅하기" 버튼.
    *   **잠금 화면:** 산책 10회 미만 유저에게는 블러 처리된 화면 위에 "산책을 더 하고 오세요!" 라는 잠겨진 자물쇠 아이콘 표시.
*   **AI Design Prompt:**
    ```text
    Mobile app UI design, Dog Market map interface. Map view with custom cute pins representing dog items (bones, clothes, leash). Bottom sheet partially slightly visible showing list of items with price and distance. User interface for a location-based marketplace, clean map styles, energetic orange accent buttons. Glassmorphism effect on the item details card.
    ```

### 2.8 마이 펫 케어 (My Pet Care)
*   **설명:** 반려견의 건강과 일정을 관리하는 종합 수첩 화면.
*   **주요 요소:**
    *   **건강 타임라인:** 예방접종, 심장사상충 투약일 등을 아이콘과 선으로 연결된 타임라인으로 표시.
    *   **체중 기록 카드:** 최근 체중 변화 그래프와 '몸무게 기록하기' 버튼.
    *   **멍멍 ID:** 반려견 등록 번호, 칩 번호가 적힌 디지털 신분증 카드 디자인.
*   **AI Design Prompt:**
    ```text
    Mobile app UI design, Pet Care managment screen. Timeline interface showing vaccination schedule with cute medical icons (syringe, pill). A card displaying a digital 'Dog ID' with photo and details. Weight tracking line chart in a clean card. Soft pastel colors, organized layout, health-focused medical aesthetic but cute.
    ```

---

## 3. 아이콘 및 타이포그래피 (Assets)
*   **Icons:** Filled 스타일의 둥근 아이콘 (Rounded edges).
*   **Font:** 'Pretendard' 또는 'Nunito' (둥글고 가독성 좋은 산세리프).

---

## 4. UI 개발시 고려사항
*   **Dark Mode Support:** 야간 산책이 많으므로 다크 모드(High Contrast)가 필수적입니다.
*   **Reachability:** 한 손으로 산책줄을 잡고 있으므로, 주요 버튼(시작, 일시정지)은 엄지손가락이 닿는 하단 영역에 배치해야 합니다.
