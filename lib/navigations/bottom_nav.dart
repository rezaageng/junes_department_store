import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../screens/home.dart';
import '../screens/orders.dart';

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
        actions: [
          Consumer<Cart>(
            builder: (context, cart, child) => Badge(
              position: BadgePosition.topEnd(top: 0, end: 3),
              showBadge: cart.itemsCount > 0 ? true : false,
              badgeContent: Text(
                cart.itemsCount.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              badgeColor: Theme.of(context).colorScheme.secondary,
              animationType: BadgeAnimationType.slide,
              child: child,
            ),
            child: IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
              icon: const Icon(Icons.shopping_cart_rounded),
              enableFeedback: false,
            ),
          )
        ],
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
