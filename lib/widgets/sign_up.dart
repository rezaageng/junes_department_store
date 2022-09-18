import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Email',
            filled: true,
            fillColor: Theme.of(context).cardTheme.color,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            hintText: 'Password',
            filled: true,
            fillColor: Theme.of(context).cardTheme.color,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          textInputAction: TextInputAction.go,
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            hintText: 'Confirm Password',
            filled: true,
            fillColor: Theme.of(context).cardTheme.color,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          textInputAction: TextInputAction.go,
        ),
      ],
    );
  }
}
