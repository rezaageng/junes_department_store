import 'package:flutter/material.dart';

import '../widgets/login.dart';

enum AuthMode { login, signUp }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode authMode = AuthMode.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome to Junes',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 16),
            Form(
              child: SizedBox(
                width: 240,
                child: Column(
                  children: [
                    const Login(),
                    const SizedBox(height: 32),
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              authMode == AuthMode.login ? 'Login' : 'Sign Up',
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(authMode == AuthMode.login
                                ? 'Don\'t have an account?'
                                : 'Already have an account?'),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (authMode == AuthMode.login) {
                                    authMode = AuthMode.signUp;
                                  } else {
                                    authMode = AuthMode.login;
                                  }
                                });
                              },
                              child: Text(
                                authMode == AuthMode.login
                                    ? ' Sign Up'
                                    : ' Login',
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
