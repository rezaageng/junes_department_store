import 'package:flutter/material.dart';

class Filter extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const Filter({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: Theme.of(context).cardTheme.color,
        child: InkWell(
          enableFeedback: false,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(title),
          ),
        ),
      ),
    );
  }
}
