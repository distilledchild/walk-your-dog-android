import 'package:flutter/material.dart';
import 'package:walk_your_dog_ios/widgets/gradient_button.dart';
import 'package:walk_your_dog_ios/services/google_auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GoogleAuthService _authService = GoogleAuthService();
  bool _isLoading = false;

  Future<void> _handleGoogleSignUp() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userCredential = await _authService.signInWithGoogle();

      if (userCredential != null && mounted) {
        // 회원가입 성공 - 홈 대시보드로 이동
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('회원가입 실패: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleFacebookSignUp() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userCredential = await _authService.signInWithFacebook();

      if (userCredential != null && mounted) {
        // 회원가입 성공 - 홈 대시보드로 이동
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Facebook 회원가입 실패: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFDFEBD), // Pale Yellow
              Color(0xFFC4EBC8), // Mint Green
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Image Section
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
                            // Placeholder for an image if needed
                          ),
                        ),
                        // Text Section
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.0),
                          child: Column(
                            children: [
                              Text(
                                "Step in, wag on!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF2D3E2E),
                                  height: 1.2,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                "Connect with pups and people, one joyful walk at a time.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF556B55),
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(flex: 1),
                        
                        const SizedBox(height: 40),
                        
                        // Buttons
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            children: [
                              _isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF66BB6A)),
                                      ),
                                    )
                                  : GradientButton(
                                      text: "Google",
                                      icon: Image.asset(
                                        "assets/images/google_logo.png",
                                        height: 24, width: 24,
                                        errorBuilder: (context, error, stackTrace) => const SizedBox(width: 24, height: 24),
                                      ),
                                      onTap: _handleGoogleSignUp,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                              const SizedBox(height: 16),
                              GradientButton(
                                text: "Facebook",
                                icon: Image.asset(
                                  "assets/images/facebook_logo.png",
                                  height: 24, width: 24,
                                  errorBuilder: (context, error, stackTrace) => const SizedBox(width: 24, height: 24),
                                ),
                                onTap: _handleFacebookSignUp,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
