import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  final Map<String, String> authData;
  final TextEditingController passwordController;
  final RegExp emailRegex;

  const SignUp({
    Key? key,
    required this.authData,
    required this.passwordController,
    required this.emailRegex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty || !emailRegex.hasMatch(value)) {
              return 'Invalid E-mail!';
            }
            return null;
          },
          onSaved: (value) => authData['email'] = value!,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: 'E-mail',
            filled: true,
            fillColor: Theme.of(context).cardTheme.color,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty || value.length <= 6) {
              return 'Invalid Password';
            }
            return null;
          },
          onSaved: (value) => authData['password'] = value!,
          controller: passwordController,
          obscureText: true,
          textInputAction: TextInputAction.next,
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
        ),
        const SizedBox(height: 16),
        TextFormField(
          validator: (value) {
            if (value == null ||
                value.isEmpty ||
                value.length <= 6 ||
                value != passwordController.text) {
              return 'Password don\'t match';
            }
            return null;
          },
          obscureText: true,
          textInputAction: TextInputAction.go,
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
        ),
      ],
    );
  }
}
