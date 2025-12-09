import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        // indicatorShape: const CircleBorder(), 
        // 선택된 항목의 배경(원형) 위치와 크기를 조절하기 위해 커스텀 Shape 사용
        // indicatorShape: const CircleBorder(), 
        // 선택된 항목의 배경(원형) 위치와 크기를 조절하기 위해 커스텀 Widget(_buildSelectedIcon) 사용
        // 따라서 여기서는 별도 Shape 지정 불필요 (기본값 사용하거나 무시됨)
        
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2D3E2E));
          }
          return const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF556B55));
        }),
      ),
      child: NavigationBar(
        height: 70, 
        backgroundColor: const Color(0xFFFEFDE7),
        indicatorColor: Colors.transparent, // 기본 인디케이터 투명 처리
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          NavigationDestination(
            icon: _buildIcon(Icons.home_outlined),
            selectedIcon: _buildSelectedIcon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: _buildIcon(Icons.bar_chart_outlined),
            selectedIcon: _buildSelectedIcon(Icons.bar_chart),
            label: 'Stats',
          ),
          NavigationDestination(
            icon: _buildIcon(Icons.people_outline),
            selectedIcon: _buildSelectedIcon(Icons.people),
            label: 'Community',
          ),
          NavigationDestination(
            icon: _buildIcon(Icons.shopping_bag_outlined),
            selectedIcon: _buildSelectedIcon(Icons.shopping_bag),
            label: 'Market',
          ),
          NavigationDestination(
            icon: _buildIcon(Icons.settings_outlined),
            selectedIcon: _buildSelectedIcon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  // 기본 아이콘 (선택되지 않았을 때) - 위치 조정을 위해 Padding/Transform 사용 가능
  Widget _buildIcon(IconData iconData) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0), // 전체적으로 아이콘을 아래로 내림
      child: Icon(iconData, size: 26),
    );
  }

  // 선택된 아이콘 (커스텀 원형 배경 포함)
  Widget _buildSelectedIcon(IconData iconData) {
    return Padding(
      // 선택된 아이콘도 unselected와 동일한 기준 위치를 잡기 위해 padding 사용
      // 필요하다면 Transform.translate를 사용하여 세밀하게 위치 조정 가능
      padding: const EdgeInsets.only(top: 13.0), 
      child: Container(
        width: 52, // 원의 너비 (크기 조절 가능)
        height: 52, // 원의 높이 (크기 조절 가능)
        decoration: const BoxDecoration(
          color: Color(0xFFAED581), // kLimeGreen
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(iconData, size: 26, color: const Color(0xFF2D3E2E)),
      ),
    );
  }
}
