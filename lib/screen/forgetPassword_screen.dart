import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_health_app_new/screen/login_screen.dart';
import 'package:flutter_health_app_new/utility/MyCostants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _isLoading = false;
  bool _codeSent = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Step 1: Send reset code to email
  Future<void> _sendResetCode() async {
    if (_emailController.text.trim().isEmpty) {
      _showSnackBar("Please enter your email address");
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      await Amplify.Auth.resetPassword(username: _emailController.text.trim());
      setState(() => _codeSent = true);
      _showSnackBar("📨 Reset code sent to your email");
    } on AuthException catch (e) {
      _showSnackBar("❌ Error: ${e.message}");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Step 2: Confirm reset with code and new password
  Future<void> _resetPassword() async {
    if (_codeController.text.trim().isEmpty) {
      _showSnackBar("Please enter the confirmation code");
      return;
    }
    
    if (_newPasswordController.text.trim().isEmpty) {
      _showSnackBar("Please enter a new password");
      return;
    }
    
    if (_newPasswordController.text != _confirmPasswordController.text) {
      _showSnackBar("Passwords don't match");
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      await Amplify.Auth.confirmResetPassword(
        username: _emailController.text.trim(),
        confirmationCode: _codeController.text.trim(),
        newPassword: _newPasswordController.text.trim(),
      );
      
      _showSnackBar("✅ Password reset successfully!");
      
      // Navigate back to login screen
      Navigator.of(context).pop();
    } on AuthException catch (e) {
      _showSnackBar("❌ Error: ${e.message}");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyCostants.background2,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Reset Password",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
            color: MyCostants.secondary,
          ),
        ),
        backgroundColor: MyCostants.primary,
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _codeSent 
                        ? "Enter the code sent to your email and your new password:"
                        : "Enter your email address to receive a reset code:",
                      style: const TextStyle(
                        fontSize: 16,
                        color: MyCostants.inEvidence,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    
                    // Email Field (always visible)
                    TextFormField(
                      controller: _emailController,
                      enabled: !_codeSent, // Disable after code is sent
                      decoration: const InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    
                    // Show these fields only after code is sent
                    if (_codeSent) ...[
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _codeController,
                        decoration: const InputDecoration(
                          labelText: "Confirmation Code",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock_outline),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _newPasswordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: "New Password",
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          labelText: "Confirm New Password",
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                            onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ),
                        ),
                      ),
                    ],
                    
                    const SizedBox(height: 30),
                    
                    // Main Action Button
                    ElevatedButton(
                      onPressed: _isLoading 
                        ? null 
                        : (_codeSent ? _resetPassword : _sendResetCode),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyCostants.primary,
                        foregroundColor: MyCostants.secondary,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 4,
                      ),
                      child: _isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            _codeSent ? "Reset Password" : "Send Reset Code",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text("Cancel resent password"),
                  content: const Text(
                    "Are you sure you want to cancel the resent password process?",
                    style: TextStyle(color: MyCostants.textPrimary),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "No",
                        style: TextStyle(color: MyCostants.textPrimary),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog first
                        Navigator.of(
                          context,
                        ).pop(); // Go back to previous screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Yes",
                        style: TextStyle(color: MyCostants.error),
                      ),
                    ),
                  ],
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: MyCostants.error,
                foregroundColor: MyCostants.secondary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
              ),
              child: const Text(
                "Go back",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyCostants.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}