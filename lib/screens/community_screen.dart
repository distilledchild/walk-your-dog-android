import 'package:flutter/material.dart';
import 'package:walk_your_dog_ios/widgets/island_header.dart';
import 'package:walk_your_dog_ios/widgets/gradient_button.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int _selectedTab = 0; // 0: Ranking, 1: Clubs, 2: Chat

  @override
  Widget build(BuildContext context) {
    // Colors
    final Color kPaleYellowBg = const Color(0xFFF9F8D0);
    final Color kDarkGreenHeader = const Color(0xFF4A6559);
    final Color kLimeGreen = const Color(0xFFAED581); // Selected tab
    final Color kGoldYellow = const Color(0xFFFFD54F);

    return Scaffold(
      backgroundColor: kPaleYellowBg,
      body: Column(
        children: [
          // 1. Header with Sub-menu
          // 1. Header with Sub-menu
          IslandHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Community",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFFFF9C4),
                    fontFamily: 'Nunito',
                  ),
                ),
                const SizedBox(height: 20),
                // Sub-menu Toggle
                Container(
                  height: 45,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      _buildTabItem("Ranking", 0, Icons.emoji_events_outlined, kLimeGreen),
                      _buildTabItem("Clubs", 1, Icons.people_outline, kLimeGreen),
                      _buildTabItem("Chat", 2, Icons.chat_bubble_outline, kLimeGreen),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. Body Content
          Expanded(
            child: _selectedTab == 0
                ? _buildRankingView()
                : _selectedTab == 1
                    ? _buildClubsView()
                    : _buildChatView(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String text, int index, IconData icon, Color activeColor) {
    final bool isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? activeColor.withValues(alpha: 0.9) : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSelected) ...[
                Icon(icon, size: 18, color: const Color(0xFF2D3E2E)),
                const SizedBox(width: 6),
              ],
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF2D3E2E) : Colors.white.withValues(alpha: 0.7),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRankingView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Podium Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 2nd Place (Mike)
              _buildPodiumItem(
                name: "Mike",
                score: "42.8km",
                rank: 2,
                color: const Color(0xFFC5E1A5), // Light Greenish Silver
                height: 140,
                avatarAsset: "assets/images/onboard2.png",
                icon: Icons.emoji_events_outlined, // Silver medal placeholder
              ),
              // 1st Place (Sarah)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildPodiumItem(
                  name: "Sarah",
                  score: "45.2km",
                  rank: 1,
                  color: const Color(0xFFFDD835), // Gold
                  height: 170,
                  avatarAsset: "assets/images/onboard1.png",
                  icon: Icons.emoji_events, // Crown/Trophy placeholder
                ),
              ),
              // 3rd Place (Emma)
              _buildPodiumItem(
                name: "Emma",
                score: "38.5km",
                rank: 3,
                color: const Color(0xFFD7CCC8), // Bronze-ish
                height: 120,
                avatarAsset: "assets/images/onboard3.png",
                icon: Icons.emoji_events_outlined, // Bronze placeholder
              ),
            ],
          ),
          
          const SizedBox(height: 40),

          // List Items
          _buildRankListItem(
            rank: 4,
            name: "You & Max",
            score: "35.2 km this week",
            isMe: true,
            avatarAsset: "assets/images/onboard1.png",
          ),
          const SizedBox(height: 16),
          _buildRankListItem(
            rank: 5,
            name: "John & Bella",
            score: "32.1 km this week",
            isMe: false,
            avatarAsset: "assets/images/onboard2.png",
          ),
          // Additional items can be added here
        ],
      ),
    );
  }

  Widget _buildPodiumItem({
    required String name,
    required String score,
    required int rank,
    required Color color,
    required double height,
    required String avatarAsset,
    required IconData icon,
  }) {
    // Colors for borders/icons based on rank
    Color accentColor;
    if (rank == 1) accentColor = const Color(0xFFFFD700);
    else if (rank == 2) accentColor = const Color(0xFFC0C0C0);
    else accentColor = const Color(0xFFCD7F32);


    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Avatar
        Container(
          width: rank == 1 ? 80 : 60,
          height: rank == 1 ? 80 : 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
            image: DecorationImage(
              image: AssetImage(avatarAsset),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3E2E),
          ),
        ),
        const SizedBox(height: 8),
        // Pedestal
        Container(
          width: rank == 1 ? 100 : 85,
          height: height,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.8), // Semi-transparent for glass effect feel? Or solid
            
             gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                color,
                color.withValues(alpha: 0.9), // Slightly darker bottom
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            boxShadow: [
               BoxShadow(
                color: buttonShadow(color),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                rank == 1 ? Icons.workspace_premium : Icons.emoji_events_outlined, // Placeholder for Crown/Medal
                color: const Color(0xFF2D3E2E).withValues(alpha: 0.6),
                size: 32,
              ),
               const SizedBox(height: 8),
              Text(
                score,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3E2E),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Color buttonShadow(Color color) {
     if(color == const Color(0xFFFDD835)) return Colors.orange.withValues(alpha: 0.3);
     return Colors.black.withValues(alpha: 0.1);
  }

  Widget _buildRankListItem({
    required int rank,
    required String name,
    required String score,
    required bool isMe,
    required String avatarAsset,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isMe ? const Color(0xFFAED581).withValues(alpha: 0.6) : const Color(0xFFFEFDE7),
        borderRadius: BorderRadius.circular(20),
        border: isMe ? Border.all(color: const Color(0xFF8BC34A), width: 1) : null,
         boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            "#$rank",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3E2E),
            ),
          ),
          const SizedBox(width: 16),
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(avatarAsset),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3E2E),
                  ),
                ),
                Text(
                  score,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF556B55),
                  ),
                ),
              ],
            ),
          ),
          if (isMe)
             const Icon(Icons.pets, color: Color(0xFF2D3E2E), size: 20) // Little paw icon for you
        ],
      ),
    );
  }

  Widget _buildClubsView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildClubCard(
            name: "Gangnam Walkers",
            members: "124",
            distance: "2.3 km",
            imageAsset: "assets/images/onboard1.png",
          ),
          const SizedBox(height: 20),
          _buildClubCard(
            name: "Morning Dog Squad",
            members: "87",
            distance: "1.5 km",
            imageAsset: "assets/images/onboard2.png",
          ),
          const SizedBox(height: 20),
          _buildClubCard(
            name: "Han River Paws",
            members: "156",
            distance: "3.8 km",
            imageAsset: "assets/images/onboard3.png",
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildClubCard({
    required String name,
    required String members,
    required String distance,
    required String imageAsset,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFEFDE7), // kCardCream
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Image Header
          Stack(
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageAsset),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
              ),
              // Text Content
              Positioned(
                bottom: 12,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "$members members • $distance away",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Button Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GradientButton(
              text: "Join Club",
              onTap: () {
                // Join action
              },
              height: 50,
              borderRadius: BorderRadius.circular(25),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3E2E), // Dark text for this button
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildChatView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFFAED581).withValues(alpha: 0.2), // Light green tint
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chat_bubble_outline_rounded,
              size: 64,
              color: Color(0xFFAED581), // Lime Green
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "No messages yet",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3E2E), // Dark Green
              fontFamily: 'Nunito',
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Join a club to start chatting!",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF556B55),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
