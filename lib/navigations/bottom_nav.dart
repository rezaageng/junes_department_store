import 'package:flutter/material.dart';

import '../screens/home.dart';
import '../screens/orders.dart';
import '../widgets/cart_button.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final List<Map<String, Object>> _screens = [
    {
      'title': 'Junes',
      'screen': const Home(),
    },
    {
      'title': 'Orders',
      'screen': const Orders(),
    },
  ];

  int _screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_screenIndex]['title'] as String),
        actions: const [CartButton()],
      ),
      body: _screens[_screenIndex]['screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _screenIndex,
        onTap: (index) => setState(() {
          _screenIndex = index;
        }),
        enableFeedback: false,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_outlined),
            activeIcon: Icon(Icons.receipt_rounded),
            label: 'Orders',
          ),
        ],
      ),
    );
  }
}
