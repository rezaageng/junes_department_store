import 'package:flutter/material.dart';

Future<void> onRefresh(BuildContext context, VoidCallback refresh) async {
  try {
    refresh();
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
