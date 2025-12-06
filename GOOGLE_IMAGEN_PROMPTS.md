## 1. 공통 스타일 프롬프트 (Base Style)
모든 프롬프트의 앞이나 뒤에 붙여서 일관된 톤을 유지할 수 있습니다.
> "A high-fidelity, modern mobile app UI design in a premium glassmorphism style. The color palette features energetic orange and fresh mint green on a clean off-white background."

---

## 2. 화면별 프롬프트 (Screen Prompts)

### 2.1 스플래시 & 온보딩 (Splash & Onboarding)
**설명:** 귀여운 3D 캐릭터와 환영 메시지.

```text
A high-quality mobile app onboarding screen design for a dog walking application. The screen features a cute, high-quality 3D cartoon-style dog character walking happily in the center. The background is a soft, dreamy gradient of pastel orange and mint colors. At the bottom, there is a large, pill-shaped button labeled "Get Started" in vibrant orange. The typography is modern, rounded, and clean. The overall vibe is friendly and inviting.
```

### 2.2 홈 대시보드 (Home Dashboard)
**설명:** 대형 활동 링과 산책 시작 버튼.

```text
A modern mobile app dashboard design for a pet fitness app. In the center, there is a large, glowing circular progress ring displaying daily step goals with a 3D paw print icon inside it. Below the ring, a large, prominent floating action button (FAB) in bright coral orange with the text "Start Walk". The top of the screen shows a small, rounded card with a cute dog avatar and a level progress bar. The interface uses a clean white background with soft shadows and glassmorphism effects on the cards.
```

### 2.3 산책 트래킹 (Active Walking Mode)
**설명:** 지도 중심의 직관적인 인터페이스.

```text
A mobile app UI design for a GPS tracking screen used during dog walking. The background is a full-screen custom map with dark roads and a bright, glowing mint-green path line representing the walking route. Overlaid at the top is a semi-transparent frosted glass card displaying large, readable numbers for "Time", "Distance", and "Calories". At the bottom, there is a control panel with a large circular "Pause" button and a slide-to-stop slider. The design is high-contrast and easy to read outdoors.
```

### 2.4 산책 종료 및 요약 (Walk Summary)
**설명:** 축하 분위기와 데이터 요약.

```text
A rewarding success screen design for a mobile app after finishing a workout. The screen is festive with colorful confetti effects falling in the background. In the center, a detailed map card shows the route path just walked. Below the map, a grid layout displays statistics like Distance, Calories, and Time using colorful rounded icons. A golden medal notification pops out saying "New Badge Unlocked". The design feels celebratory, bright, and encouraging.
```

### 2.5 통계 및 리포트 (Stats & History)
**설명:** 깔끔한 그래프와 히스토리 목록.

```text
A minimal and clean analytics screen for a fitness app. The upper section features a sleek bar chart with rounded tops, showing weekly walking activity. The bars use a gradient from orange to teal. Below the chart, there is a vertical list of past walks, each shown with a date and a small square map thumbnail. The UI uses plenty of whitespace, distinct section headers, and a modern sans-serif font. The layout is professional and organized.
```

### 2.6 커뮤니티 & 리더보드 (Community)
**설명:** 포디움과 랭킹 리스트.

```text
A gamified leaderboard screen design for a social app. The top section features a 3D-style podium with three dog avatars standing on gold, silver, and bronze platforms. Below the podium, a scrollable list shows user profiles with their ranks and scores. The user's own profile card is fixed at the very bottom of the screen with a highlighted glow effect. The style is playful, social, and vibrant with rounded profile pictures.
```

---

## 3. 사용 팁 (Tips for Google Models)
1.  **자세한 묘사:** 구글 모델은 "Dribbble style" 같은 키워드보다 "soft shadows and rounded corners (부드러운 그림자와 둥근 모서리)"처럼 구체적인 묘사를 더 잘 이해합니다.
2.  **텍스트 렌더링:** Imagen 3는 이미지 내의 텍스트(예: "Start Walk")를 비교적 정확하게 그려냅니다. 프롬프트에 텍스트 내용을 명확히 따옴표("")로 묶어주세요.
3.  **비율 설정:** 모바일 UI이므로 생성 시 비율(Aspect Ratio)을 **9:16**으로 설정하는 것을 잊지 마세요.
