import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expires;
  String? _userId;
  Timer? _authTimer;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null &&
        _expires != null &&
        _expires!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAMgGtGIFAN3zSrlwG0HPR8rxuHsjFIZwo',
    );

    try {
      final prefs = await SharedPreferences.getInstance();

      final response = await http.post(
        url,
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expires = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));

      final userData = jsonEncode({
        'token': _token,
        'userId': _userId,
        'expires': _expires!.toIso8601String(),
      });

      prefs.setString('userData', userData);

      _autoLogout();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('userData')) return false;

    final userData =
        jsonDecode(prefs.getString('userData')!) as Map<String, dynamic>;

    final expires = DateTime.parse(userData['expires']);

    if (expires.isBefore(DateTime.now())) return false;

    _token = userData['token'];
    _userId = userData['userId'];
    _expires = expires;

    _autoLogout();
    notifyListeners();

    return true;
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();

    _token = null;
    _expires = null;
    _userId = null;

    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }

    prefs.remove('userData');

    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }

    final timeExp = _expires!.difference(DateTime.now()).inSeconds;

    _authTimer = Timer(Duration(seconds: timeExp), logout);
  }
}
