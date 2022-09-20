import 'package:flutter/material.dart';
import 'package:junes_department_store/navigations/bottom_nav.dart';
import 'package:provider/provider.dart';

import 'providers/auth.dart';
import 'providers/cart.dart';
import 'providers/orders.dart';
import 'providers/products.dart';
import 'screens/auth_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/product_details.dart';
import 'screens/user_product_form.dart';
import 'screens/user_products.dart';
import 'themes/dark_theme.dart';
import 'themes/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Auth(),
          ),
          ChangeNotifierProvider(
            create: (context) => Products(),
          ),
          ChangeNotifierProvider(
            create: (context) => Cart(),
          ),
          ChangeNotifierProvider(
            create: (context) => Orders(),
          )
        ],
        child: Consumer<Auth>(
          builder: (context, auth, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Junes',
            theme: lightTheme,
            darkTheme: darkTheme,
            home: auth.isAuth ? const BottomNav() : const AuthScreen(),
            routes: {
              ProductDetails.routeName: (context) => const ProductDetails(),
              CartScreen.routeName: (context) => const CartScreen(),
              UserProducts.routeName: (context) => const UserProducts(),
              UserProductForm.routeName: (context) => const UserProductForm(),
            },
          ),
        ));
  }
}
