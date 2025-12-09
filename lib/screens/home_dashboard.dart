import 'package:flutter/material.dart';
import 'package:walk_your_dog_ios/screens/home_view.dart';
import 'package:walk_your_dog_ios/screens/stats_screen.dart';
import 'package:walk_your_dog_ios/screens/community_screen.dart';
import 'package:walk_your_dog_ios/screens/market_screen.dart';
import 'package:walk_your_dog_ios/screens/settings_screen.dart';
import 'package:walk_your_dog_ios/widgets/bottom_nav_bar.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  int _selectedIndex = 0;

  // List of screens for each tab
  static const List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    StatsScreen(),
    CommunityScreen(),
    MarketScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Colors from the design
    final Color kPaleYellowBg = const Color(0xFFF9F8D0); 

    return Scaffold(
      backgroundColor: kPaleYellowBg,
      body: SafeArea(
        bottom: false, // Let the content go behind nav bar if transparent, but here we use opaque
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
      ),
    );
  }
}
