# 개발 환경 설정 가이드

이 프로젝트를 로컬에서 실행하려면 Firebase 및 Google Cloud 설정이 필요합니다.

## 1. Firebase 설정

### Android 설정
1. [Firebase Console](https://console.firebase.google.com)에 접속
2. 프로젝트 선택 또는 새로 생성
3. **Project Settings > General > Your apps** 에서 Android 앱 추가
4. `google-services.json` 파일 다운로드
5. 다운로드한 파일을 `android/app/` 디렉토리에 복사

### iOS 설정
1. Firebase Console에서 iOS 앱 추가
2. `GoogleService-Info.plist` 파일 다운로드
3. 다운로드한 파일을 `ios/Runner/` 디렉토리에 복사

⚠️ **중요**: 이 파일들은 절대 Git에 커밋하지 마세요!

## 2. Google OAuth 설정

1. [Google Cloud Console](https://console.cloud.google.com) 접속
2. APIs & Services > Credentials로 이동
3. "Create Credentials" > "OAuth 2.0 Client ID" 선택
4. Application type: Web application
5. 생성된 Client ID 복사

## 3. API 키 설정

```bash
# 1. api_keys.dart 파일 생성
cp lib/config/api_keys.dart.example lib/config/api_keys.dart

# 2. 에디터로 lib/config/api_keys.dart 열기
# 3. 'REPLACE_WITH_NEW_CLIENT_ID'를 실제 Client ID로 교체
```

**lib/config/api_keys.dart 예시:**
```dart
class ApiKeys {
  static const String googleServerClientId = '123456789-abcdefg.apps.googleusercontent.com';
}
```

## 4. Firebase Security Rules 설정

### Firestore Database Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

### Realtime Database Rules
```json
{
  "rules": {
    ".read": "auth != null",
    ".write": "auth != null"
  }
}
```

### Storage Rules
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## 5. 의존성 설치 및 실행

```bash
# Flutter 패키지 설치
flutter pub get

# iOS CocoaPods 설치 (macOS만)
cd ios && pod install && cd ..

# 앱 실행
flutter run
```

## 체크리스트

설정을 완료했는지 확인하세요:

- [ ] `android/app/google-services.json` 파일 존재
- [ ] `ios/Runner/GoogleService-Info.plist` 파일 존재
- [ ] `lib/config/api_keys.dart` 파일 생성 및 Client ID 설정
- [ ] Firebase Console에서 Security Rules 설정
- [ ] `flutter pub get` 실행 완료
- [ ] 앱이 정상적으로 빌드 및 실행됨

## 문제 해결

### Firebase 연결 오류
- Firebase 프로젝트 ID가 올바른지 확인
- `google-services.json`과 `GoogleService-Info.plist`가 최신 버전인지 확인

### Google 로그인 실패
- Client ID가 올바르게 설정되었는지 확인
- Google Cloud Console에서 OAuth 동의 화면이 설정되어 있는지 확인

### 빌드 오류
```bash
# 캐시 정리 후 재빌드
flutter clean
flutter pub get
flutter run
```

## 보안 주의사항

⚠️ **절대 커밋하면 안 되는 파일들**:
- `google-services.json`
- `GoogleService-Info.plist`
- `lib/config/api_keys.dart`
- `*.keystore`, `*.jks`
- `.env` 파일들

이 파일들은 이미 `.gitignore`에 추가되어 있습니다.