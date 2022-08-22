import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigations/bottom_nav.dart';
import 'providers/products.dart';
import 'screens/product_details.dart';
import 'themes/dark_theme.dart';
import 'themes/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Junes',
        theme: lightTheme,
        darkTheme: darkTheme,
        routes: {
          '/': (context) => const BottomNav(),
          ProductDetails.routeName: (context) => const ProductDetails(),
        },
      ),
    );
  }
}
