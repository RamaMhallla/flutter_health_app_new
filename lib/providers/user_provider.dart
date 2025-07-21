// 📄 lib/providers/user_provider.dart

import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class UserProvider extends ChangeNotifier {
  String _userEmail = '';
  bool _rememberMe = false;

  String get userEmail => _userEmail;
  bool get rememberMe=>_rememberMe;
  
  void login(bool remember, String email) async {
    _rememberMe=remember;
    _userEmail=email;
  }

Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
      _userEmail = ''; // Clear user data
      _rememberMe=false;
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
