# 보안 대책 실행 계획

## 현재 상황
- Git 히스토리에 Firebase 설정 파일(GoogleService-Info.plist)이 노출됨
- Google OAuth Client ID가 코드에 하드코딩됨
- GitHub 원격 저장소에 푸시된 상태

---

## 즉시 조치 사항 (CRITICAL)

### 1. Firebase 프로젝트 보안 조치 ⚠️

#### A. API 키 교체
```bash
# Firebase Console에서 수행
1. https://console.firebase.google.com 접속
2. 프로젝트: first-vibe-app-walk-your-dog 선택
3. Project Settings > General
4. 현재 노출된 API 키 비활성화/삭제
5. 새로운 API 키 생성
```

#### B. Firebase Security Rules 강화
```bash
# Firestore Database Rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;  // 인증된 사용자만
    }
  }
}

# Realtime Database Rules
{
  "rules": {
    ".read": "auth != null",
    ".write": "auth != null"
  }
}

# Storage Rules
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

#### C. OAuth 클라이언트 ID 재생성
```bash
# Google Cloud Console에서 수행
1. https://console.cloud.google.com 접속
2. APIs & Services > Credentials
3. 현재 클라이언트 ID 삭제: 320698938442-5movhk7i02p4j50h2oboce9v0ivteq3k
4. 새로운 OAuth 2.0 Client ID 생성
```

---

## 단계 2: Git 히스토리 정리

### Option A: Git History 완전 삭제 (권장)

```bash
# 1. BFG Repo-Cleaner 설치 (가장 빠른 방법)
brew install bfg

# 2. 저장소 백업
cd /Users/pete/Desktop/playground
cp -r walk-your-dog-android walk-your-dog-android-backup

# 3. GoogleService-Info.plist 완전 제거
cd walk-your-dog-android
bfg --delete-files GoogleService-Info.plist

# 4. Git 히스토리 정리
git reflog expire --expire=now --all
git gc --prune=now --aggressive

# 5. 강제 푸시 (주의: 협업자가 있다면 사전 공지 필요)
git push origin --force --all
git push origin --force --tags
```

### Option B: git filter-repo 사용 (더 안전)

```bash
# 1. git filter-repo 설치
brew install git-filter-repo

# 2. 파일 완전 제거
git filter-repo --path ios/Runner/GoogleService-Info.plist --invert-paths

# 3. 강제 푸시
git push origin --force --all
```

### Option C: 새 저장소로 마이그레이션 (가장 안전)

```bash
# 1. 현재 작업 상태만 새 저장소로 복사
cd /Users/pete/Desktop/playground
mkdir walk-your-dog-android-clean
cd walk-your-dog-android-clean
git init

# 2. 필요한 파일만 복사 (민감 파일 제외)
rsync -av --exclude='.git' \
  --exclude='GoogleService-Info.plist' \
  --exclude='google-services.json' \
  ../walk-your-dog-android/ ./

# 3. 새 저장소 설정
git add .
git commit -m "Initial clean commit"

# 4. GitHub에서 기존 저장소 삭제 후 새로 생성
# 5. 새 원격 저장소 연결
git remote add origin git@github.com:distilledchild/walk-your-dog-android.git
git push -u origin main
```

---

## 단계 3: 코드 수정

### A. GoogleService-Info.plist 제거 및 .gitignore 확인

```bash
# 1. 현재 파일 확인
ls -la ios/Runner/GoogleService-Info.plist

# 2. Git tracking 제거 (파일은 로컬에 유지)
git rm --cached ios/Runner/GoogleService-Info.plist

# 3. .gitignore에 이미 추가되어 있는지 확인
grep "GoogleService-Info.plist" .gitignore
```

### B. OAuth Client ID 환경 변수로 이동

현재 코드 (lib/services/google_auth_service.dart:8):
```dart
final GoogleSignIn _googleSignIn = GoogleSignIn(
  serverClientId: '320698938442-5movhk7i02p4j50h2oboce9v0ivteq3k.apps.googleusercontent.com',
);
```

수정 방안:

#### 방법 1: flutter_dotenv 사용
```yaml
# pubspec.yaml에 추가
dependencies:
  flutter_dotenv: ^5.1.0
```

```.env
# .env 파일 생성 (이 파일은 .gitignore에 추가됨)
GOOGLE_SERVER_CLIENT_ID=새로운-클라이언트-ID.apps.googleusercontent.com
```

```dart
// lib/services/google_auth_service.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  serverClientId: dotenv.env['GOOGLE_SERVER_CLIENT_ID'],
);
```

#### 방법 2: 별도 config 파일 (git에서 제외)
```dart
// lib/config/api_keys.dart (이 파일은 .gitignore에 추가됨)
class ApiKeys {
  static const String googleServerClientId = '새로운-클라이언트-ID';
}
```

```dart
// lib/services/google_auth_service.dart
import '../config/api_keys.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  serverClientId: ApiKeys.googleServerClientId,
);
```

---

## 단계 4: 검증

### A. 로컬 확인
```bash
# 1. 민감 파일이 Git에서 제외되었는지 확인
git ls-files | grep -E 'GoogleService-Info|google-services|\.env'

# 2. .gitignore 작동 확인
git status

# 3. 히스토리에 민감 파일이 없는지 확인
git log --all --full-history -- "**/GoogleService-Info.plist"
```

### B. 원격 저장소 확인
```bash
# GitHub에서 히스토리 확인
# https://github.com/distilledchild/walk-your-dog-android/search?q=AIzaSyD
```

---

## 단계 5: 모니터링 및 예방

### A. GitHub Secret Scanning 활성화
- Private 저장소라면 Advanced Security 활성화
- Push Protection 설정

### B. Pre-commit Hook 설정
```bash
# .git/hooks/pre-commit 생성
#!/bin/bash
# 민감 파일 커밋 방지
if git diff --cached --name-only | grep -E 'google-services\.json|GoogleService-Info\.plist|\.env$'; then
  echo "ERROR: 민감한 파일이 커밋에 포함되어 있습니다!"
  exit 1
fi
```

### C. 정기 보안 감사
```bash
# git-secrets 설치 및 설정
brew install git-secrets
git secrets --install
git secrets --register-aws
```

---

## 체크리스트

### 즉시 실행 (오늘)
- [ ] Firebase API 키 재발급
- [ ] Google OAuth Client ID 재발급
- [ ] Firebase Security Rules 설정
- [ ] Git 히스토리에서 민감 파일 제거
- [ ] 강제 푸시로 원격 저장소 정리

### 코드 수정 (오늘)
- [ ] GoogleService-Info.plist Git tracking 제거
- [ ] OAuth Client ID 환경 변수로 이동
- [ ] .env 파일 생성 및 설정
- [ ] 새로운 API 키로 테스트

### 검증 (내일)
- [ ] 로컬에서 앱 빌드 및 실행 테스트
- [ ] Firebase 연결 확인
- [ ] OAuth 로그인 기능 테스트
- [ ] Git 히스토리 정리 확인

### 장기 대책
- [ ] Pre-commit hook 설정
- [ ] 팀원들에게 보안 가이드라인 공유
- [ ] 정기 보안 감사 일정 수립

---

## 주의사항

1. **강제 푸시 전 팀원 공지**: 다른 협업자가 있다면 반드시 사전에 공지
2. **백업 필수**: Git 히스토리 정리 전 저장소 전체 백업
3. **테스트**: 새로운 API 키로 모든 기능 테스트 후 배포
4. **문서화**: 새로운 개발자를 위한 설정 가이드 작성

---

## 참고 자료
- [Firebase Security Rules](https://firebase.google.com/docs/rules)
- [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/)
- [git-filter-repo](https://github.com/newren/git-filter-repo)
- [GitHub Secret Scanning](https://docs.github.com/en/code-security/secret-scanning)