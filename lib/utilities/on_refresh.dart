import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

Future<void> onRefresh(BuildContext context) async {
  try {
    await Provider.of<Products>(context, listen: false).fetchProduct();
  } catch (e) {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Something went wrong'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )
        ],
      ),
    );
  }
}
