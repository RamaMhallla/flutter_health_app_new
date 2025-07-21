import 'package:flutter/material.dart';
import 'package:flutter_health_app_new/patientDashboard.dart';
import 'package:flutter_health_app_new/providers/user_provider.dart';
import 'package:flutter_health_app_new/screen/login_screen.dart';

import 'package:provider/provider.dart';
enum AuthStatus{notLoggedIn, loggedIn}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;
   bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.rememberMe && userProvider.userEmail.isNotEmpty) {
      setState(() => _authStatus = AuthStatus.loggedIn);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      _checkLoginStatus(); // Call async method safely
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _authStatus == AuthStatus.loggedIn
          ? const PatientDashboard()
          : const LoginScreen(),
    );
  }
}
