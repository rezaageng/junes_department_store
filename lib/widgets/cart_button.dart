import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../screens/cart_screen.dart';

class CartButton extends StatelessWidget {
  const CartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
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
        onPressed: () => Navigator.of(context).pushNamed(CartScreen.routeName),
        icon: const Icon(Icons.shopping_cart_rounded),
        enableFeedback: false,
      ),
    );
  }
}
