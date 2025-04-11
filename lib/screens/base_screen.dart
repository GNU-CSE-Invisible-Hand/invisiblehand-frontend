import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:invisiblehand/screens/screens.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),        // 홈
    WatchlistScreen(),   // 관심
    ExploreScreen(),     // 탐색
    MypageScreen(),      // 마이페이지
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xFF2E7D32),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.heart),
            label: '관심',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.compass),
            label: '탐색',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.user),
            label: '마이',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
