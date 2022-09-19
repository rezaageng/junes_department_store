import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  final Map<String, String> authData;
  final TextEditingController passwordController;

  const SignUp({
    Key? key,
    required this.authData,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: (value) {
            if (value == null ||
                value.isEmpty ||
                RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                    .hasMatch(value)) return 'Invalid E-mail!';
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
            if (value == null || value.isEmpty) return 'Invalid Password';
            return null;
          },
          onSaved: (value) => authData['password'] = value!,
          controller: passwordController,
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
        TextFormField(
          validator: (value) {
            if (value == null ||
                value.isEmpty ||
                value != passwordController.text) {
              return 'Password don\'t match';
            }
            return null;
          },
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
