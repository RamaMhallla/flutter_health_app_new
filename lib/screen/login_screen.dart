import 'package:flutter/material.dart';
import 'package:flutter_health_app_new/screen/forgetPassword_screen.dart';
import 'package:flutter_health_app_new/screen/patientInput_screen.dart';
import 'package:flutter_health_app_new/providers/user_provider.dart';
import 'package:flutter_health_app_new/screen/signUp_screen.dart';
import 'package:flutter_health_app_new/utility/MyCostants.dart';

import 'package:provider/provider.dart';

import 'package:amplify_flutter/amplify_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
      _rememberMe = false;
      super.dispose();
  }
  // Email validation regex
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final result = await Amplify.Auth.signIn(
          username: _emailController.text.trim(),
          password: _passwordController.text,
        );
        final user = await Amplify.Auth.getCurrentUser();
        final id= user.userId;
        if (result.isSignedIn && mounted) {
          Provider.of<UserProvider>(
            context,
            listen: false,
          ).login(_rememberMe,_emailController.text.trim());
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const PatientInputDashboard()),
           );
          

        } else {
          _showError('Sign in not complete. Please verify your credentials.');
        }
      } on AuthException catch (e) {
        _showError(e.message);
      } catch (e) {
        _showError('An unknown error occurred: $e');
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: MyCostants.error,
        action: SnackBarAction(
          label: 'Retry',
          textColor: MyCostants.secondary,
          onPressed: _login,
        ),
      ),
    );
  }

  void _navigateToSignUp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SignUpScreen()),
    );
  }

  void _forgotPassword() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Forgot Password'),
        content: const Text(
          'Do you sure to reset the password?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => {Navigator.pop(context),Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen(),
                          ),
                        )},
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  MyCostants.background2,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyCostants.primary,
        centerTitle: true,
        title: const Text(
          'Login',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
            color:  MyCostants.secondary,
          ),
        ),
        elevation: 2,
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: // depending on the orientation of the device run _buildPortrait or _buildLandscape
          (context, orientation) => orientation == Orientation.portrait
              ? _buildPortrait()
              : _buildLandscape(),
        ),
      ),
    );
  }

  Widget _buildLandscape() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo and title section
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Hero(
                    tag: 'heart_logo',
                    child: Image.asset(
                      "assets/images/heart_logo.png",
                      width: 120,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Heart Health Monitor',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: MyCostants.inEvidence,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Welcome back! Please sign in to continue.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 30),
            // Form section
            Expanded(flex: 1, child: _buildFormCard()),
          ],
        ),
      ),
    );
  }

  Widget _buildPortrait() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 40),
            Hero(
              tag: 'heart_logo',
              child: Image.asset(
                "assets/images/heart_logo.png",
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Heart Health Monitor',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: MyCostants.inEvidence,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Welcome back! Please sign in to continue.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: MyCostants.textSubtitle),
            ),
            const SizedBox(height: 40),
            _buildFormCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Email field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!_isValidEmail(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Password field
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),

            // Remember me and forgot password row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    const Text('Remember me', style: TextStyle(fontSize: 14)),
                  ],
                ),
                TextButton(
                  onPressed: _forgotPassword,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Login button
            ElevatedButton(
              onPressed: _isLoading ? null : _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: MyCostants.primary,
                foregroundColor:  MyCostants.secondary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color:  MyCostants.secondary,
                      ),
                    )
                  : const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color:  MyCostants.secondary,
                      ),
                    ),
            ),
            const SizedBox(height: 16),

            // Divider
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'OR',
                    style: TextStyle(color: MyCostants.textSubtitle, fontSize: 12),
                  ),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 16),

            // Sign up link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account? ',
                  style: TextStyle(fontSize: 14),
                ),
                TextButton(
                  onPressed: _navigateToSignUp,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Sign up here',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
