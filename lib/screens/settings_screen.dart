import 'package:flutter/material.dart';
import 'package:walk_your_dog_ios/widgets/island_header.dart';
import 'package:walk_your_dog_ios/widgets/gradient_button.dart';
import 'package:walk_your_dog_ios/services/google_auth_service.dart';
import 'package:walk_your_dog_ios/screens/onboarding_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Colors
    final Color kPaleYellowBg = const Color(0xFFF9F8D0);
    final Color kCardCream = const Color(0xFFFEFDE7);
    final Color kTextDark = const Color(0xFF2D3E2E);
    final Color kGoldYellow = const Color(0xFFFFD54F);

    return Scaffold(
      backgroundColor: kPaleYellowBg,
      body: Column(
        children: [
          // Header
          const IslandHeader(
            child: SizedBox(
              width: double.infinity,
              child: Text(
                "Settings",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFFFF9C4),
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),

          // Scrollable Settings List
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  _buildSettingsItem("Change Email", Icons.email_outlined, kCardCream, kTextDark),
                  const SizedBox(height: 12),
                  _buildSettingsItem("Help", Icons.help_outline, kCardCream, kTextDark),
                  const SizedBox(height: 12),
                  _buildSettingsItem("Appearance", Icons.dark_mode_outlined, kCardCream, kTextDark),
                  const SizedBox(height: 12),
                  _buildSettingsItem("Privacy Controls", Icons.privacy_tip_outlined, kCardCream, kTextDark),
                  const SizedBox(height: 12),
                  _buildSettingsItem("Units of Measurement", Icons.straighten, kCardCream, kTextDark), // Custom icon choice
                  const SizedBox(height: 12),
                  _buildSettingsItem("Temperature", Icons.thermostat, kCardCream, kTextDark),
                  const SizedBox(height: 12),
                  _buildSettingsItem("Weather", Icons.cloud_outlined, kCardCream, kTextDark),
                  const SizedBox(height: 12),
                  _buildSettingsItem("Push Notification", Icons.notifications_none, kCardCream, kTextDark),
                  const SizedBox(height: 12),
                  _buildSettingsItem("Email Notification", Icons.mark_email_read_outlined, kCardCream, kTextDark),
                  
                  const SizedBox(height: 24), // Extra space at bottom of list
                ],
              ),
            ),
          ),

          // Log Out Button (Pinned to Bottom)
          GradientButton(
            text: "Log Out",
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24, top: 8),
            onTap: () async {
              final authService = GoogleAuthService();
              await authService.signOut();
              
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const OnboardingScreen(),
                  ),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(String title, IconData icon, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4A6559), size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: textColor,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.black26),
        ],
      ),
    );
  }
}
