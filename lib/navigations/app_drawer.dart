import 'package:flutter/material.dart';
import 'package:junes_department_store/providers/auth.dart';
import 'package:provider/provider.dart';

import '../screens/user_products.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  void _navigate(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
    Scaffold.of(context).closeDrawer();
  }

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
            onTap: () => _navigate(context, UserProducts.routeName),
            enableFeedback: false,
            leading: const Icon(Icons.store_rounded),
            title: const Text('Manage Your Products'),
          ),
          ListTile(
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
              Scaffold.of(context).closeDrawer();
            },
            enableFeedback: false,
            leading: const Icon(Icons.logout_rounded),
            title: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}
