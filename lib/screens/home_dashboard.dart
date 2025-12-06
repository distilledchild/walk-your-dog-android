import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:walk_your_dog_ios/services/google_auth_service.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  final GoogleAuthService _authService = GoogleAuthService();

  @override
  Widget build(BuildContext context) {
    final userPhotoUrl = _authService.getUserPhotoUrl();
    final userName = _authService.getUserDisplayName() ?? 'User';
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Light grey/white background like the image
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF2D3E2E),
                      fontFamily: 'Nunito',
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.settings, color: Color(0xFF2D3E2E)),
                      onPressed: () {
                        // Settings action
                      },
                    ),
                  ),
                ],
              ),
            ),

            // 2. Pet Profile Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Avatar
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                            image: userPhotoUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(userPhotoUrl),
                                    fit: BoxFit.cover,
                                  )
                                : const DecorationImage(
                                    image: AssetImage('assets/images/onboard1.png'),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2D3E2E),
                                  fontFamily: 'Nunito',
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "1,200 / 2,000 XP",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFFFB74D), // Orange/Gold text
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Edit Button
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8E1), // Light Yellow
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.edit, size: 14, color: Color(0xFF8D6E63)),
                              SizedBox(width: 4),
                              Text(
                                "Edit",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF8D6E63),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: 0.6, // 1200/2000
                        backgroundColor: const Color(0xFFFFF9C4), // Very light yellow
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF81C784)), // Green
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // 3. Center Gauge (Activity Ring)
            Stack(
              alignment: Alignment.center,
              children: [
                // Ring
                SizedBox(
                  width: 220,
                  height: 220,
                  child: CustomPaint(
                    painter: GradientRingPainter(
                      progress: 0.75,
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFDD835), // Yellow
                          Color(0xFF66BB6A), // Green
                        ],
                      ),
                      backgroundColor: Colors.grey[200]!,
                      strokeWidth: 20,
                    ),
                  ),
                ),
                // Center Content
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.pets, size: 40, color: Color(0xFFFDD835)), // Paw Icon
                    SizedBox(height: 8),
                    Text(
                      "7,500",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF2D3E2E),
                        fontFamily: 'Nunito',
                      ),
                    ),
                    Text(
                      "/ 10,000 Steps",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF757575),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const Spacer(),

            // 4. Info Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildInfoCard(
                      icon: Icons.straighten,
                      value: "3.5 km",
                      label: "Distance",
                      iconColor: const Color(0xFFF9A825), // Dark Yellow
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInfoCard(
                      icon: Icons.timer,
                      value: "45 Min",
                      label: "Active Time",
                      iconColor: const Color(0xFFF9A825),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 5. Start Walk Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                height: 56,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFDD835), // Yellow/Gold
                      Color(0xFF66BB6A), // Green
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      // Start Walk Action
                    },
                    child: const Center(
                      child: Text(
                        "Start Walk",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required IconData icon, required String value, required String label, required Color iconColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3E2E),
              fontFamily: 'Nunito',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFFFFB74D), // Light Orange
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

    // Draw background ring
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
