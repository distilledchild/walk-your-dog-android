# Package Name/Bundle ID 통일 가이드

## 현재 상태
- Android: `com.example.walk_your_dog_android`
- iOS: `com.example.walkYourDogIos`

## 권장 변경
두 플랫폼 모두: `com.distilledchild.walkyourdog` 또는 `com.example.walkyourdog`

---

## 옵션 1: 새 Package Name으로 통일 (권장)

### Android 변경
1. `android/app/build.gradle.kts` 수정:
```kotlin
android {
    namespace = "com.distilledchild.walkyourdog"

    defaultConfig {
        applicationId = "com.distilledchild.walkyourdog"
        // ...
    }
}
```

2. 패키지 디렉토리 구조 변경:
```bash
# 현재
android/app/src/main/kotlin/com/example/walk_your_dog_android/MainActivity.kt

# 변경 후
android/app/src/main/kotlin/com/distilledchild/walkyourdog/MainActivity.kt
```

3. MainActivity.kt 파일의 package 선언 수정:
```kotlin
package com.distilledchild.walkyourdog
```

4. AndroidManifest.xml 확인 (자동으로 namespace 사용)

### iOS 변경
1. Xcode에서 변경 (권장):
   - Xcode로 `ios/Runner.xcworkspace` 열기
   - Runner 프로젝트 선택 > General > Identity
   - Bundle Identifier를 `com.distilledchild.walkyourdog`로 변경

2. 또는 수동으로 `ios/Runner.xcodeproj/project.pbxproj` 수정:
```
PRODUCT_BUNDLE_IDENTIFIER = com.distilledchild.walkyourdog;
```

---

## 옵션 2: 현재 Android ID로 iOS 통일

### iOS만 변경
Bundle Identifier를 `com.example.walk_your_dog_android`로 변경
(하지만 언더스코어가 포함되어 비권장)

---

## Firebase 재등록 필요

Package Name/Bundle ID를 변경하면:
1. Firebase Console에서 **새로운 Android 앱 추가**
   - Package name: `com.distilledchild.walkyourdog`
   - 새 `google-services.json` 다운로드

2. Firebase Console에서 **새로운 iOS 앱 추가**
   - Bundle ID: `com.distilledchild.walkyourdog`
   - 새 `GoogleService-Info.plist` 다운로드

---

## 추천 Package Name

```
com.distilledchild.walkyourdog
```

이유:
- distilledchild: GitHub 계정명 (본인 소유 확인)
- walkyourdog: 앱 이름 (언더스코어 제거)
- 간결하고 일관성 있음
- App Store/Play Store 출시 가능

---

## 변경 순서

1. Package Name 결정
2. Android 변경
3. iOS 변경
4. Firebase에 새 앱 등록
5. 새 설정 파일 다운로드
6. 테스트 빌드 및 실행
