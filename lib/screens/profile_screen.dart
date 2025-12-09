import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:walk_your_dog_ios/services/google_auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // App Theme Colors
    final Color kPaleYellowBg = const Color(0xFFF9F8D0);
    final Color kCardCream = const Color(0xFFFEFDE7);
    final Color kDarkGreen = const Color(0xFF2D3E2E);
    final Color kLimeGreen = const Color(0xFFAED581);
    final Color kGoldYellow = const Color(0xFFFFD54F);
    final Color kOrangeAccent = const Color(0xFFFF7043); // For the "Strava-like" orange highlights if needed

    final GoogleAuthService authService = GoogleAuthService();
    final userPhotoUrl = authService.getUserPhotoUrl();
    final userName = authService.getUserDisplayName() ?? 'Pete Kim';

    return Scaffold(
      backgroundColor: kPaleYellowBg,
      appBar: AppBar(
        backgroundColor: kPaleYellowBg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: kDarkGreen),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share_outlined, color: kDarkGreen),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search, color: kDarkGreen),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings_outlined, color: kDarkGreen),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Profile Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: kLimeGreen, width: 3),
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
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: kDarkGreen,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Memphis, Tennessee",
                          style: TextStyle(
                            fontSize: 14,
                            color: kDarkGreen.withValues(alpha: 0.7),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildCountStat("Following", "65", kDarkGreen),
                            const SizedBox(width: 24),
                            _buildCountStat("Followers", "22", kDarkGreen),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 2. Action Buttons (QR / Edit)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: kOrangeAccent),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.qr_code, color: kOrangeAccent, size: 20),
                          const SizedBox(width: 8),
                          Text("Share my QR Code", style: TextStyle(color: kOrangeAccent, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: kDarkGreen.withValues(alpha: 0.3)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit_outlined, color: kDarkGreen, size: 20),
                          const SizedBox(width: 8),
                          Text("Edit", style: TextStyle(color: kDarkGreen, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 3. Photo Carousel
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildPhotoItem('assets/images/onboard1.png'),
                  _buildPhotoItem('assets/images/onboard2.png'),
                  _buildPhotoItem('assets/images/onboard3.png'),
                  Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text("All media", style: TextStyle(color: kDarkGreen, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Divider(height: 1, color: kDarkGreen.withValues(alpha: 0.1)),
            
            const SizedBox(height: 20),

            // 4. Activity Selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _buildActivityTab("Walk", true, kOrangeAccent),
                  const SizedBox(width: 12),
                  _buildActivityTab("Ride", false, kDarkGreen),
                  const SizedBox(width: 12),
                  _buildActivityTab("Run", false, kDarkGreen),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 5. This Week Stats
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("This week", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kDarkGreen)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       _buildWeekStat("Distance", "12.4 km"),
                       _buildWeekStat("Time", "3h 12m"),
                       _buildWeekStat("Elevation", "45 m"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 6. Graph (Placeholder using fl_chart simply or just a container if complex)
            // Adding a simple line chart
            Container(
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 1),
                        const FlSpot(1, 1.5),
                        const FlSpot(2, 0.8),
                        const FlSpot(3, 4), // Peak
                        const FlSpot(4, 2),
                        const FlSpot(5, 2.5),
                        const FlSpot(6, 1.8),
                      ],
                      isCurved: true,
                      color: kOrangeAccent,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: kOrangeAccent.withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            Divider(height: 1, color: kDarkGreen.withValues(alpha: 0.1)),

            // 7. Menu List Items
            _buildMenuItem(Icons.show_chart, "Activities", "Yesterday", kDarkGreen),
            _buildMenuItem(Icons.bar_chart, "Statistics", "This year: 317.9 km", kDarkGreen),
            _buildMenuItem(Icons.route_outlined, "Routes", "—", kDarkGreen),
            _buildMenuItem(Icons.emoji_events_outlined, "Best Efforts", "See All", kDarkGreen),
            _buildMenuItem(Icons.straighten, "Gear", "—", kDarkGreen),

            const SizedBox(height: 30),

            // 8. Trophy Case
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Trophy Case", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kDarkGreen)),
                  Text("12", style: TextStyle(fontSize: 18, color: kDarkGreen.withValues(alpha: 0.6))),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildTrophyItem("150", Colors.orange),
                  _buildTrophyItem("100", Colors.teal),
                  _buildTrophyItem("75", Colors.blue),
                  _buildTrophyItem("Start", Colors.green),
                ],
              ),
            ),

            const SizedBox(height: 30),

             // 9. Clubs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Clubs", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kDarkGreen)),
                  Text("4", style: TextStyle(fontSize: 18, color: kDarkGreen.withValues(alpha: 0.6))),
                ],
              ),
            ),
            const SizedBox(height: 16),
             SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildClubItem("Ride901", Colors.black87),
                  _buildClubItem("REI", Colors.brown),
                  _buildClubItem("Crank", Colors.black),
                ],
              ),
            ),         
            
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildCountStat(String label, String count, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: color.withValues(alpha: 0.7))),
        Text(count, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _buildPhotoItem(String path) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(path),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildActivityTab(String label, bool isSelected, Color activeColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? activeColor.withValues(alpha: 0.1) : Colors.transparent,
        border: Border.all(color: isSelected ? activeColor : Colors.grey.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            label == "Walk" ? Icons.directions_walk : label == "Ride" ? Icons.directions_bike : Icons.directions_run,
            size: 18,
            color: isSelected ? activeColor : Colors.grey,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? activeColor : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildWeekStat(String label, String value) {
     return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2D3E2E))),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: color)),
      subtitle: Text(subtitle, style: TextStyle(color: color.withValues(alpha: 0.6))),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      onTap: () {},
    );
  }

  Widget _buildTrophyItem(String label, Color color) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          // Hexagon shape approx
          Container(
             height: 80,
             decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/google_logo.png'), fit: BoxFit.contain, opacity: 0.2), // Placeholder for hexagon
                // Simple shape placeholder
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 4),
             ),
             alignment: Alignment.center,
             child: Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          ),
          const SizedBox(height: 8),
          Text("Best $label", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildClubItem(String name, Color color) {
     return Container(
       width: 80,
       margin: const EdgeInsets.only(right: 16),
       child: Column(
         children: [
           Container(
             height: 60,
             width: 60,
             decoration: BoxDecoration(
               color: color,
               borderRadius: BorderRadius.circular(10),
             ),
             alignment: Alignment.center,
             child: Text(name[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
           ),
           const SizedBox(height: 8),
           Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
         ],
       ),
     );
  }
}
