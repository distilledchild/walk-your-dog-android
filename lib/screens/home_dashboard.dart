import 'package:flutter/material.dart';
import 'package:walk_your_dog_ios/screens/home_view.dart';
import 'package:walk_your_dog_ios/screens/stats_screen.dart';
import 'package:walk_your_dog_ios/screens/community_screen.dart';
import 'package:walk_your_dog_ios/screens/market_screen.dart';
// import 'package:walk_your_dog_ios/screens/settings_screen.dart';  // Future

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
    Center(child: Text('Settings Screen (Coming Soon)')),
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2D3E2E), // Dark Green
        unselectedItemColor: Colors.grey.withValues(alpha: 0.6),
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
