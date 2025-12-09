import 'package:flutter/material.dart';
import 'package:walk_your_dog_ios/services/google_auth_service.dart';
import 'dart:math' as math;
import 'package:walk_your_dog_ios/screens/walk_tracking_screen.dart';
import 'package:walk_your_dog_ios/screens/profile_screen.dart';
import 'package:walk_your_dog_ios/widgets/island_header.dart';
import 'package:walk_your_dog_ios/widgets/gradient_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final GoogleAuthService authService = GoogleAuthService();
    // Colors from the design
    // final Color kPaleYellowBg = const Color(0xFFF9F8D0); // Background - handled by parent Scaffold if needed, or here
    final Color kDarkGreenHeader = const Color(0xFF4A6559); // Header Background
    final Color kLimeGreen = const Color(0xFFAED581); // Highlighting
    final Color kGoldYellow = const Color(0xFFFFD54F); // Accents
    final Color kCardCream = const Color(0xFFFEFDE7); // Stat cards

    final userPhotoUrl = authService.getUserPhotoUrl();
    final userName = authService.getUserDisplayName() ?? 'Max'; 

    return SingleChildScrollView(
      child: Column(
        children: [
          // 1. IslandHeader: Custom Header Card
          IslandHeader(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // Align items in the middle from the bottom baseline
              children: [
                // Left Column: Avatar
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: kLimeGreen, width: 3),
                    image: userPhotoUrl != null
                        ? DecorationImage(
                            image: NetworkImage(userPhotoUrl),
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            image: AssetImage('assets/images/onboard1.png'), // Fallback dog image
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Right Column: Name/Edit & Level/Gauge
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Center vertically in fixed height header
                    children: [
                      // Row 1: Name and Edit Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              userName,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFF9C4), // Pale text
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                          IconButton(
                            alignment: Alignment.centerRight, // Align icon to the far right visually
                            padding: EdgeInsets.fromLTRB(0, 9, 0, 0), // Remove internal padding to match gauge edge
                            icon: const Icon(Icons.edit, color: Color(0xFFFFF9C4)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ProfileScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 2), // Small gap
                      
                      // Row 2: Level Text and Gauge
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Level 12",
                            style: TextStyle(
                              fontSize: 14,
                              color: kLimeGreen,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Level Progress Bar
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: 0.65,
                                backgroundColor: Colors.black.withValues(alpha: 0.2),
                                valueColor: AlwaysStoppedAnimation<Color>(kLimeGreen),
                                minHeight: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // 2. Circular Step Counter
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 260,
                height: 260,
                child: CustomPaint(
                  painter: GradientRingPainter(
                    progress: 0.68,
                    gradient: LinearGradient(
                      colors: [kGoldYellow, kLimeGreen],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    backgroundColor: Colors.white.withValues(alpha: 0.3),
                    strokeWidth: 24,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "5,420",
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF2D3E2E),
                        fontFamily: 'Roboto',
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "/ 8,000 steps",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF556B55),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "68%",
                      style: TextStyle(
                        fontSize: 28,
                        color: kLimeGreen.withValues(alpha: 0.9), // Darker lime for text visibility
                        fontWeight: FontWeight.bold,
                        shadows: [
                            Shadow(
                                offset: Offset(1,1),
                                blurRadius: 2,
                                color: Colors.black.withValues(alpha: 0.1),
                            )
                        ]
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 27),

          // 3. Stats Row (3 items)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard("12", "Walks\nThis Week", kCardCream),
                _buildStatCard("24.5", "km Total\nDistance", kCardCream),
                _buildStatCard("8", "New Badges\nEarned", kCardCream),
              ],
            ),
          ),

          const SizedBox(height: 17),

          // 4. Achievement Banner
          Container(
            margin: EdgeInsets.fromLTRB(17.0, 12.0, 17.0, 17.0),
            padding: const EdgeInsets.all(22.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                    kGoldYellow.withValues(alpha: 0.4),
                    kLimeGreen.withValues(alpha: 0.4),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1),
            ),
            child: Row(
              children: [
                // Trophy Icon Container
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFA4B42B), // Darker gold/green
                    shape: BoxShape.circle,
                    boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0,2),
                        )
                    ],
                  ),
                  child: const Icon(Icons.emoji_events, color: Colors.white, size: 24),
                ),

                const SizedBox(width: 18),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "New Badge Unlocked!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF2D3E2E),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Week Warrior - 7 days streak",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF556B55),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // const SizedBox(height: 2),

          // 5. Start Walk Button
          GradientButton(
            text: "Start Walk",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WalkTrackingScreen(),
                ),
              );
            },
            // padding removed, using default from widget
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color bgColor) {
    return Container(
      width: 100,
      height: 110,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3E2E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF556B55),
              height: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for the Gradient Ring
class GradientRingPainter extends CustomPainter {
  final double progress;
  final Gradient gradient;
  final Color backgroundColor;
  final double strokeWidth;

  GradientRingPainter({
    required this.progress,
    required this.gradient,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;

    // Draw background ring (Top half mostly) - Actually full circle in design
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Draw gradient progress ring
    final rect = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(rect);

    // Start from top (-pi/2)
    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
