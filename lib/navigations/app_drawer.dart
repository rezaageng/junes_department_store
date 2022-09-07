import 'package:flutter/material.dart';
import 'package:junes_department_store/screens/user_products.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/p4.jpg'),
                    fit: BoxFit.cover),
              ),
              child: SizedBox(),
            ),
          ),
          ListTile(
            onTap: () =>
                Navigator.of(context).pushNamed(UserProducts.routeName),
            enableFeedback: false,
            leading: const Icon(Icons.store_rounded),
            title: const Text('Manage Your Products'),
          ),
        ],
      ),
    );
  }
}
