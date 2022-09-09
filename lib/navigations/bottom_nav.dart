import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/home.dart';
import '../screens/orders_screen.dart';
import '../widgets/cart_button.dart';
import 'app_drawer.dart';

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
      'screen': const OrdersScreen(),
    },
  ];

  int _screenIndex = 0;

  Future<bool> _onWillPop() async {
    if (_screenIndex == 0) {
      await SystemNavigator.pop();
    }

    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        _screenIndex = 0;
      });
    });

    return _screenIndex == 0;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu_rounded),
              onPressed: () => Scaffold.of(context).openDrawer(),
              enableFeedback: false,
            ),
          ),
          title: Text(_screens[_screenIndex]['title'] as String),
          actions: const [CartButton()],
        ),
        drawer: const AppDrawer(),
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
      ),
    );
  }
}
