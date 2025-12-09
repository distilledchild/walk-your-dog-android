import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/onboarding_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Google Services JSON이 확인되었으므로 초기화 활성화
  await Firebase.initializeApp(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Walk Your Dog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A6559), // Dark Green Header
          primary: const Color(0xFF4A6559),
          onPrimary: const Color(0xFFFFF9C4), // Pale text
          secondary: const Color(0xFFAED581), // Lime Green
          onSecondary: const Color(0xFF2D3E2E), // Dark Text
          tertiary: const Color(0xFFFFD54F), // Gold Yellow
          onTertiary: const Color(0xFF2D3E2E),
          surface: const Color(0xFFF9F8D0), // Pale Yellow Bg
          onSurface: const Color(0xFF2D3E2E),
        ),
        scaffoldBackgroundColor: const Color(0xFFF9F8D0),
        useMaterial3: true,
        fontFamily: 'Roboto', 
      ),
      home: const OnboardingScreen(),
      routes: {
        '/home': (context) => const HomeDashboard(),
        '/welcome': (context) => const WelcomeScreen(),
        '/signup': (context) => const SignupScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
