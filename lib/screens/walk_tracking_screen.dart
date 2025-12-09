import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:walk_your_dog_ios/screens/walk_summary_screen.dart';
import 'package:walk_your_dog_ios/widgets/island_header.dart'; // Import added
import 'dart:async';

class WalkTrackingScreen extends StatefulWidget {
  const WalkTrackingScreen({super.key});

  @override
  State<WalkTrackingScreen> createState() => _WalkTrackingScreenState();
}

class _WalkTrackingScreenState extends State<WalkTrackingScreen> {
  // Timer logic
  Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  String _formattedTime = "00:00:00";
  // ignore: unused_field
  bool _isPaused = false;

  // Google Map
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (mounted) {
        setState(() {
          _formattedTime = _formatTime(_stopwatch.elapsedMilliseconds);
        });
      }
    });
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate() % 100;
    int seconds = (milliseconds / 1000).truncate() % 60;
    int minutes = (milliseconds / (1000 * 60)).truncate() % 60;
    int hours = (milliseconds / (1000 * 60 * 60)).truncate();

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    String hundredsStr = hundreds.toString().padLeft(2, '0');

    if (hours > 0) {
      return "$hoursStr:$minutesStr:$secondsStr.$hundredsStr";
    }
    return "$minutesStr:$secondsStr.$hundredsStr";
  }

  void _onStopPressed() {
    _stopwatch.stop();
    _timer.cancel();
    // Navigate to Summary Screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WalkSummaryScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Colors
    final Color kDarkMapBg = const Color(0xFF2F4F4F); // Dark Slate Grayish
    final Color kGlassGrey = Colors.white.withValues(alpha: 0.15); // Translucent
    final Color kLimeGreen = const Color(0xFFAED581);
    final Color kGoldYellow = const Color(0xFFFFD54F);

    return Scaffold(
      backgroundColor: kDarkMapBg,
      body: Stack(
        children: [
          // 1. Background Map Layer (Grid + Path)
          Positioned.fill(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
            ),
          ),
          
          // 2. Current Location Marker (Center)
          Center(
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: kGoldYellow,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),

          // 3. Top Stats Island
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: IslandHeader(
              // Default Top Margin is 60, works well with Positioned top:0
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              color: const Color(0xFF4A6559).withValues(alpha: 0.85), // Higher opacity
              border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Time
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formattedTime,
                        style: const TextStyle(
                          color: Color(0xFFFFF9C4), // Pale yellow text
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto', // Monospace for numbers if available
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Time",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  // Spacer
                  // KM
                  Column(
                    children: [
                      const Text(
                        "1.2", // Mock Data
                        style: TextStyle(
                          color: Color(0xFFFFF9C4),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                       const SizedBox(height: 4),
                      Text(
                        "km",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  // Kcal
                   Column(
                    children: [
                      const Text(
                        "45", // Mock Data
                        style: TextStyle(
                          color: Color(0xFFFFF9C4),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                       const SizedBox(height: 4),
                      Text(
                        "kcal",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 4. Bottom Control Panel
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: IslandHeader(
               margin: const EdgeInsets.fromLTRB(24, 0, 24, 40),
               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
               color: const Color(0xFF4A6559).withValues(alpha: 0.85), // Higher opacity
               border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Camera Button
                      _buildCircleButton(
                        icon: Icons.camera_alt_outlined,
                        color: Colors.white.withValues(alpha: 0.2),
                        iconColor: const Color(0xFFFFF9C4),
                        size: 60,
                        onTap: () {},
                      ),
                      
                      // Pause Button (Main)
                      GestureDetector(
                        onTap: () {
                          // Pause logic (Toggle)
                          if (_stopwatch.isRunning) {
                            _stopwatch.stop();
                          } else {
                            _stopwatch.start();
                          }
                          // Since timer updates specific state, we just need to ensure UI reflects generic pause state?
                          // Actually, the timer keeps ticking every 30ms to update time.
                          // Even if paused, we invoke setState just in case to refresh the icon.
                          setState(() {});
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                kGoldYellow,
                                kLimeGreen,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: kLimeGreen.withValues(alpha: 0.4),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Icon(
                            _stopwatch.isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                            size: 36,
                            color: const Color(0xFF2D3E2E), // Dark Green
                          ),
                        ),
                      ),
                      
                      // Stop Button
                      _buildCircleButton(
                        icon: Icons.stop_rounded,
                        color: Colors.white.withValues(alpha: 0.2),
                        iconColor: const Color(0xFFFF8A80), // Light Red
                        size: 60,
                        onTap: _onStopPressed,
                        isStop: true, // Custom icon handling
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Walking in progress...",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton({
    IconData? icon,
    required Color color,
    required Color iconColor,
    required double size,
    required VoidCallback onTap,
    bool isStop = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: isStop
              ? Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: iconColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                )
              : Icon(
                  icon,
                  color: iconColor,
                  size: 28,
                ),
        ),
      ),
    );
  }
}

// Custom Painter for Map Grid and Path
class WalkMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw Grid
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1;

    const double gridSize = 40;
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // 2. Draw Walk Path (Simulated Curve)
    final pathPaint = Paint()
      ..color = const Color(0xFFAED581) // Neon Green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    // Optional: Add glow effect
    final glowPaint = Paint()
      ..color = const Color(0xFFAED581).withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10)
      ..strokeCap = StrokeCap.round;

    final path = Path();
    // Start somewhere bottom left
    path.moveTo(size.width * 0.2, size.height * 0.6);
    // Bezier curve to center
    path.quadraticBezierTo(
      size.width * 0.5, size.height * 0.4, // Control point
      size.width * 0.8, size.height * 0.3, // End point (top rightish)
    );

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, pathPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
