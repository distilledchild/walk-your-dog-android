import 'package:flutter/material.dart';
import 'package:walk_your_dog_ios/widgets/island_header.dart'; // Import added

class WalkSummaryScreen extends StatelessWidget {
  const WalkSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Colors
    final Color kPaleYellowBg = const Color(0xFFF9F8D0);
    // final Color kDarkGreenHeader = const Color(0xFF4A6559); // Handled by IslandHeader
    final Color kLimeGreen = const Color(0xFFAED581);
    final Color kGoldYellow = const Color(0xFFFFD54F);

    return Scaffold(
      backgroundColor: kPaleYellowBg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 60), // Generous padding for scrolling
        child: Column(
          children: [
            // 1. Header Area
            IslandHeader(
              child: Column(
                children: [
                  const Text(
                    "Great Walk!",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFFFF9C4),
                      fontFamily: 'Nunito',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "You and Max did amazing",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // 2. Map Snapshot Card
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2F4F4F), // Match map bg
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: CustomPaint(
                              painter: MiniMapPainter(), // Simple reuse/variation
                            ),
                          ),
                          // Fog gradient at bottom
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            height: 60,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    const Color(0xFF2F4F4F).withValues(alpha: 0.8),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 3. Badge Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          kGoldYellow,
                         const Color(0xFF8BC34A), // Greenish
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                       boxShadow: [
                        BoxShadow(
                          color: kGoldYellow.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Badge Icon Circle
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.emoji_events_rounded,
                            color: Color(0xFFE65100), // Dark Orange/Gold
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "New Badge Unlocked!",
                                style: TextStyle(
                                  color: Color(0xFF2D3E2E), // Dark Green
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "3km Explorer",
                                style: TextStyle(
                                  color: Color(0xFF2D3E2E),
                                  fontWeight: FontWeight.w900, // Extra bold
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                         const Icon(Icons.workspace_premium, color:Colors.white, size: 40, ), // Trophy BG deco
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 4. Stats Grid
                  Row(
                    children: [
                      _buildStatCard("Distance", "3.2", "km"),
                      const SizedBox(width: 16),
                      _buildStatCard("Duration", "42", "min"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildStatCard("Calories", "156", "kcal"),
                      const SizedBox(width: 16),
                      _buildStatCard("Avg Speed", "4.5", "km/h"),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 5. Feedback Section
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF9C4).withValues(alpha: 0.5), // Lighter yellow
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "How was Max today?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3E2E),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildEmojiBtn("😋"),
                            _buildEmojiBtn("😃"),
                            _buildEmojiBtn("🥰"),
                            _buildEmojiBtn("😌"),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 6. Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          text: "Share",
                          icon: Icons.share_outlined,
                          color: const Color(0xFFFEFDE7),
                          textColor: const Color(0xFF2D3E2E),
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildActionButton(
                          text: "Done",
                          icon: Icons.check,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFDD835), // Gold Yellow
                              Color(0xFF8BC34A), // Lime Green
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                           textColor: const Color(0xFF2D3E2E),
                          onTap: () {
                             Navigator.pop(context); // Go back to Home
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, String unit) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFFEFDE7), // Cream
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
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF556B55),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF2D3E2E),
                      fontFamily: 'Nunito',
                    ),
                  ),
                  TextSpan(
                    text: " $unit",
                    style: const TextStyle(
                      fontSize: 14,
                       fontWeight: FontWeight.bold,
                      color: Color(0xFF556B55),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmojiBtn(String emoji) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
           BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        emoji,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required IconData icon,
    required Color textColor,
    required VoidCallback onTap,
    Color? color,
    Gradient? gradient,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        borderRadius: BorderRadius.circular(28),
         boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 20),
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MiniMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
     // 1. Draw Grid
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1;

    const double gridSize = 30;
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    
    // 2. Draw Curve
    final pathPaint = Paint()
      ..color = const Color(0xFFAED581) // Neon Green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

      final path = Path();
    path.moveTo(size.width * 0.1, size.height * 0.8);
    path.quadraticBezierTo(
      size.width * 0.5, size.height * 0.2, 
      size.width * 0.9, size.height * 0.6, 
    );
    canvas.drawPath(path, pathPaint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
