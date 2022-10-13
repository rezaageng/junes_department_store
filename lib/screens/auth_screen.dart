import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/http_exception.dart';
import '../providers/auth.dart';
import '../widgets/login.dart';
import '../widgets/sign_up.dart';

enum AuthMode { login, signUp }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool _isLoading = false;
  AuthMode _authMode = AuthMode.login;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late final Animation<Offset> _slideAnimationLogin = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(
    CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
  );

  late final Animation<Offset> _slideAnimationSignUp = Tween<Offset>(
    begin: const Offset(-1.5, 0.0),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
  );

  Future<void> _submit(BuildContext context) async {
    final scaffold = ScaffoldMessenger.of(context);

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    _formKey.currentState!.save();

    try {
      if (_authMode == AuthMode.login) {
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email']!, _authData['password']!);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signup(_authData['email']!, _authData['password']!);
      }
    } on HttpException catch (error) {
      if (error.toString().contains('EMAIL_EXISTS')) {
        scaffold.showSnackBar(
          const SnackBar(
            content: Text(
              'The email address is already in use by another account',
            ),
          ),
        );
      } else if (error.toString().contains('OPERATION_NOT_ALLOWED')) {
        scaffold.showSnackBar(
          const SnackBar(
            content: Text(
              'Password sign-in is disabled for this project.',
            ),
          ),
        );
      } else if (error.toString().contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
        scaffold.showSnackBar(
          const SnackBar(
            content: Text(
              'We have blocked all requests from this device due to unusual activity. Try again later.',
            ),
          ),
        );
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        scaffold.showSnackBar(
          const SnackBar(
            content: Text(
              'There is no user record corresponding to this identifier. The user may have been deleted.',
            ),
          ),
        );
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        scaffold.showSnackBar(
          const SnackBar(
            content: Text(
              'The password is invalid or the user does not have a password.',
            ),
          ),
        );
      } else if (error.toString().contains('USER_DISABLED')) {
        scaffold.showSnackBar(
          const SnackBar(
            content: Text(
              'The user account has been disabled by an administrator.',
            ),
          ),
        );
      } else {
        scaffold.showSnackBar(
          const SnackBar(
            content: Text(
              'Authentication failed',
            ),
          ),
        );
      }
    } catch (error) {
      scaffold.showSnackBar(
        const SnackBar(
          content: Text(
            'Authentication failed',
          ),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
                          ? SlideTransition(
                              position: _slideAnimationLogin,
                              child: Login(
                                key: const ValueKey('login_widget'),
                                authData: _authData,
                                passwordController: _passwordController,
                                emailRegex: _emailRegex,
                              ),
                            )
                          : SlideTransition(
                              position: _slideAnimationSignUp,
                              child: SignUp(
                                key: const ValueKey('signup_widget'),
                                authData: _authData,
                                passwordController: _passwordController,
                                emailRegex: _emailRegex,
                              ),
                            ),
                      const SizedBox(height: 32),
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed:
                                  _isLoading ? null : () => _submit(context),
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
                                onTap: () async {
                                  if (!_isLoading &&
                                      _authMode == AuthMode.login) {
                                    setState(() {
                                      _authMode = AuthMode.signUp;
                                      _animationController.forward();
                                    });
                                  } else if (!_isLoading &&
                                      _authMode == AuthMode.signUp) {
                                    setState(() {
                                      _authMode = AuthMode.login;
                                      _animationController.reverse();
                                    });
                                  } else {
                                    null;
                                  }
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
