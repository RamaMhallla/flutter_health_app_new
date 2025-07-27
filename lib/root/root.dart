import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_app_new/screen/patientInput_screen.dart';
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

  @override
  void initState() {
    super.initState();
    authCheck();
  }

   Future<void> authCheck() async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.loadFromPrefs();
    final session = await Amplify.Auth.fetchAuthSession();
    if (userProvider.rememberMe && userProvider.userEmail.isNotEmpty){
      setState(() => _authStatus = AuthStatus.loggedIn);
    }else{
      if(session.isSignedIn){
        userProvider.signOut();
      }
       setState(() => _authStatus = AuthStatus.notLoggedIn);
    }
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: _authStatus == AuthStatus.loggedIn
          ? const PatientInputDashboard()
          : const LoginScreen(),
    );
  }
}
