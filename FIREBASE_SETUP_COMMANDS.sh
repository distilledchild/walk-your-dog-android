#!/bin/bash
# Firebase 설정 후 실행할 명령어들

echo "🧹 Flutter 캐시 정리..."
flutter clean

echo "📦 의존성 재설치..."
flutter pub get

echo "🔨 앱 재빌드..."
flutter build apk --debug

echo ""
echo "✅ 완료! 이제 앱을 실행하세요:"
echo "   flutter run"
