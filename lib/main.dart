import 'package:flutter/material.dart';
import 'package:junes_department_store/screens/auth_screen.dart';
import 'package:junes_department_store/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'navigations/bottom_nav.dart';
import 'providers/auth.dart';
import 'providers/cart.dart';
import 'providers/orders.dart';
import 'providers/products.dart';
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
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) => Products(null, null, [], []),
          update: (context, auth, previous) => Products(
            auth.token,
            auth.userId,
            previous != null ? previous.items : [],
            previous != null ? previous.userItems : [],
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => Orders(null, null, []),
          update: (context, auth, previous) => Orders(
            auth.token,
            auth.userId,
            previous != null ? previous.orders : [],
          ),
        )
      ],
      child: Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Junes',
          theme: lightTheme,
          darkTheme: darkTheme,
          home: auth.isAuth
              ? const BottomNav()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SplashScreen();
                    } else {
                      return const AuthScreen();
                    }
                  },
                ),
          routes: {
            ProductDetails.routeName: (context) => const ProductDetails(),
            CartScreen.routeName: (context) => const CartScreen(),
            UserProducts.routeName: (context) => const UserProducts(),
            UserProductForm.routeName: (context) => const UserProductForm(),
          },
        ),
      ),
    );
  }
}
