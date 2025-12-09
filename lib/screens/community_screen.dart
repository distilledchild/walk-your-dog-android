import 'package:flutter/material.dart';
import 'package:walk_your_dog_ios/widgets/island_header.dart';
import 'package:walk_your_dog_ios/widgets/gradient_button.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Colors
    final Color kPaleYellowBg = const Color(0xFFF9F8D0);
    final Color kCardCream = const Color(0xFFFEFDE7);
    final Color kTextDark = const Color(0xFF2D3E2E);
    final Color kTextMuted = const Color(0xFF556B55);

    return Scaffold(
      backgroundColor: kPaleYellowBg,
      body: Column(
        children: [
          // Header
          IslandHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Community",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFFFF9C4), // Light text on dark header
                    fontFamily: 'Roboto',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.search, color: Colors.white),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Leaderboard Preview
                  _buildSectionHeader("Leaderboard", "See All"),
                  const SizedBox(height: 12),
                  _buildLeaderboardCard(kCardCream, kTextDark, kTextMuted),
                  
                  const SizedBox(height: 24),
                  
                  // Clubs / Groups
                  _buildSectionHeader("Local Clubs", "Explore"),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 160,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      children: [
                        _buildClubCard("Gangnam Walkers", "12 Members", kCardCream, kTextDark),
                        const SizedBox(width: 16),
                        _buildClubCard("Maltese Lovers", "8 Members", kCardCream, kTextDark),
                        const SizedBox(width: 16),
                        _buildClubCard("Early Birds", "25 Members", kCardCream, kTextDark),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Recent Activity Feed
                  const Text(
                    "Recent Activity",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3E2E),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildActivityCard("Sarah & Max", "Just walked 3km!", kCardCream, kTextDark, kTextMuted),
                  const SizedBox(height: 12),
                  _buildActivityCard("John & Bella", "Earned 'Marathoner' badge", kCardCream, kTextDark, kTextMuted),
                ],
              ),
            ),
          ),
          
          // Create Post / Action Button
          GradientButton(
            text: "Create Post",
            icon: const Icon(Icons.add, color: Color(0xFF2D3E2E)),
            onTap: () {
              // Create post action
            },
            // padding removed, using default from widget
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3E2E),
          ),
        ),
        Text(
          action,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF556B55),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardCard(Color bgColor, Color textColor, Color mutedColor) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        children: [
          _buildRankItem(1, "GoldenRetriever_Fan", "125 km", textColor, true),
          const Divider(),
          _buildRankItem(2, "Poodle_Power", "110 km", textColor, false),
          const Divider(),
          _buildRankItem(3, "Husky_Run", "98 km", textColor, false),
        ],
      ),
    );
  }

  Widget _buildRankItem(int rank, String name, String score, Color textColor, bool isFirst) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 30,
            alignment: Alignment.center,
            child: Text(
              "#$rank",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isFirst ? const Color(0xFFFFD54F) : textColor, // Gold for #1
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            radius: 16,
            child: const Icon(Icons.person, size: 20, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: textColor,
                fontSize: 15,
              ),
            ),
          ),
          Text(
            score,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClubCard(String name, String members, Color bgColor, Color textColor) {
    return Container(
      width: 140,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.pets, color: Colors.grey),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                members,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(String user, String action, Color bgColor, Color textColor, Color mutedColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontSize: 15,
                ),
              ),
              Text(
                action,
                style: TextStyle(
                  color: mutedColor,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.favorite_border, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}
