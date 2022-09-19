import 'package:flutter/material.dart';

import '../widgets/login.dart';
import '../widgets/sign_up.dart';

enum AuthMode { login, signUp }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool _isLoading = false;
  AuthMode _authMode = AuthMode.login;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    _formKey.currentState!.save();

    if (_authMode == AuthMode.login) {
      // login handler
    } else {
      // sign up handler
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: deviceSize.width,
          height: deviceSize.height - MediaQuery.of(context).viewInsets.bottom,
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
                key: _formKey,
                child: SizedBox(
                  width: 240,
                  child: Column(
                    children: [
                      _authMode == AuthMode.login
                          ? Login(
                              authData: _authData,
                              passwordController: _passwordController,
                            )
                          : SignUp(
                              authData: _authData,
                              passwordController: _passwordController,
                            ),
                      const SizedBox(height: 32),
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _submit,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _authMode == AuthMode.login
                                        ? 'Login'
                                        : 'Sign Up',
                                  ),
                                  if (_isLoading)
                                    Container(
                                      margin: const EdgeInsets.only(left: 8),
                                      width: 12,
                                      height: 12,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 3,
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                _authMode == AuthMode.login
                                    ? 'Don\'t have an account?'
                                    : 'Already have an account?',
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (_authMode == AuthMode.login) {
                                      _authMode = AuthMode.signUp;
                                    } else {
                                      _authMode = AuthMode.login;
                                    }
                                  });
                                },
                                child: Text(
                                  _authMode == AuthMode.login
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
      ),
    );
  }
}
