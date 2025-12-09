import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:walk_your_dog_ios/widgets/island_header.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int _selectedPeriodIndex = 0; // 0: This Week, 1: This Month

  @override
  Widget build(BuildContext context) {
    // Colors
    final Color kPaleYellowBg = const Color(0xFFF9F8D0);
    final Color kDarkGreenHeader = const Color(0xFF4A6559);
    final Color kCardCream = const Color(0xFFFEFDE7);
    final Color kLimeGreen = const Color(0xFFAED581);
    final Color kGoldYellow = const Color(0xFFFFD54F);

    return Scaffold(
      backgroundColor: kPaleYellowBg,
      body: Column(
        children: [
          // 1. Header (Custom shape with Toggle)
          // 1. Header (Custom shape with Toggle)
          IslandHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Statistics",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFFFF9C4),
                    fontFamily: 'Roboto',
                  ),
                ),
                const SizedBox(height: 20),
                // Toggle Switch
                Container(
                  height: 45,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      _buildToggleItem("This Week", 0, kLimeGreen),
                      _buildToggleItem("This Month", 1, kLimeGreen),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Summary Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          title: "Total Distance",
                          value: "23.4 km",
                          icon: Icons.show_chart,
                          iconColor: Colors.green,
                          bgColor: kCardCream,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildSummaryCard(
                          title: "Total Walks",
                          value: "7 walks",
                          icon: Icons.calendar_today,
                          iconColor: Colors.orange,
                          bgColor: kCardCream,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // 3. Weekly Activity Chart
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: kCardCream,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Weekly Activity",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3E2E),
                            fontFamily: 'Roboto',
                          ),
                        ),
                        const SizedBox(height: 24),
                        AspectRatio(
                          aspectRatio: 1.5,
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              maxY: 20,
                              barTouchData: BarTouchData(enabled: false),
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      const style = TextStyle(
                                        color: Color(0xFF556B55),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      );
                                      String text;
                                      switch (value.toInt()) {
                                        case 0: text = 'Mon'; break;
                                        case 1: text = 'Tue'; break;
                                        case 2: text = 'Wed'; break;
                                        case 3: text = 'Thu'; break;
                                        case 4: text = 'Fri'; break;
                                        case 5: text = 'Sat'; break;
                                        case 6: text = 'Sun'; break;
                                        default: text = '';
                                      }
                                      return SideTitleWidget(
                                        meta: meta,
                                        child: Text(text, style: style),
                                      );
                                    },
                                    reservedSize: 30,
                                  ),
                                ),
                                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              ),
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(show: false),
                              barGroups: [
                                _makeGroupData(0, 8, kGoldYellow, kLimeGreen),
                                _makeGroupData(1, 10, kGoldYellow, kLimeGreen),
                                _makeGroupData(2, 6, kGoldYellow, kLimeGreen),
                                _makeGroupData(3, 14, kGoldYellow, kLimeGreen),
                                _makeGroupData(4, 10, kGoldYellow, kLimeGreen),
                                _makeGroupData(5, 18, kGoldYellow, kLimeGreen), // Highest
                                _makeGroupData(6, 12, kGoldYellow, kLimeGreen),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 4. Recent Walks List
                  const Text(
                    "Recent Walks",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3E2E),
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildWalkItem(
                    date: "Dec 8, 2025",
                    stats: "3.7 km  •  45 min",
                    imagePath: "assets/images/onboard1.png", // Placeholder
                    bgColor: kCardCream,
                  ),
                  const SizedBox(height: 12),
                  _buildWalkItem(
                    date: "Dec 7, 2025",
                    stats: "5.2 km  •  62 min",
                    imagePath: "assets/images/onboard2.png", // Placeholder
                    bgColor: kCardCream,
                  ),
                  const SizedBox(height: 12),
                  _buildWalkItem(
                    date: "Dec 5, 2025",
                    stats: "2.1 km  •  20 min",
                    imagePath: "assets/images/onboard3.png", // Placeholder
                    bgColor: kCardCream,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleItem(String text, int index, Color activeColor) {
    final bool isSelected = _selectedPeriodIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedPeriodIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? activeColor.withValues(alpha: 0.9) : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? const Color(0xFF2D3E2E) : Colors.white.withValues(alpha: 0.7),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: iconColor.withValues(alpha: 0.7)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF556B55),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3E2E),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y, Color color1, Color color2) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          width: 16,
          borderRadius: BorderRadius.circular(8),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: Colors.transparent, // Or a light track color
          ),
        ),
      ],
    );
  }

  Widget _buildWalkItem({
    required String date,
    required String stats,
    required String imagePath,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3E2E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  stats,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF556B55),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.pets, color: Color(0xFF4A6559), size: 24),
        ],
      ),
    );
  }
}
