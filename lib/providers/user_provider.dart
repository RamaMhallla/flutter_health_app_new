// 📄 lib/providers/user_provider.dart

import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String _userEmail = '';
  bool _rememberMe = false;

  String get userEmail => _userEmail;
  bool get rememberMe=>_rememberMe;
  
  Future<void> login(bool remember, String email) async {
    _rememberMe=remember;
    _userEmail=email;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', _rememberMe);
    prefs.setString('userEmail', _userEmail);
    notifyListeners();
  }
  
  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _rememberMe = prefs.getBool('rememberMe') ?? false;
    _userEmail = prefs.getString('userEmail') ?? '';
    notifyListeners();
  }

  Future<void> signOut() async {
      try {
        await Amplify.Auth.signOut();
        _userEmail = ''; // Clear user data
        _rememberMe=false;
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('rememberMe');
        await prefs.remove('userEmail');

        safePrint('User signed out successfully.');
      } on AuthException catch (e) {
        safePrint('❌ Sign out failed: $e');
      } finally {
        notifyListeners(); // Notify listeners after sign out
      }
  }

  @override
  void dispose() {
    _userEmail = '';
    _rememberMe = false;
    super.dispose();

  }
}
