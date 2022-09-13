import 'package:flutter/material.dart';

showAlert(BuildContext context) {
  showDialog(
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
