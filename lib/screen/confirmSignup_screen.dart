import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_health_app_new/screen/login_screen.dart';
import 'package:flutter_health_app_new/screen/patientInput_screen.dart';
import 'package:flutter_health_app_new/utility/MyCostants.dart';

class ConfirmSignUpScreen extends StatefulWidget {
  final String email;
  final String password;

  const ConfirmSignUpScreen({
    super.key,
    required this.email,
    required this.password,
  });
  @override
  State<ConfirmSignUpScreen> createState() => _ConfirmSignUpScreenState();
}

class _ConfirmSignUpScreenState extends State<ConfirmSignUpScreen> {
  final _codeController = TextEditingController();
  bool _isLoading = false;

  Future<void> _confirmSignUp() async {
    setState(() => _isLoading = true);
    try {
      final res = await Amplify.Auth.confirmSignUp(
        username: widget.email,
        confirmationCode: _codeController.text.trim(),
      );

      if (res.isSignUpComplete) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Account confirmed! Please login.")),
        );
        Navigator.of(context).pop(); 
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      } else {
        // Shouldn’t happen usually
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("⚠️ Confirmation not complete")),
        );
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("❌ Error: ${e.message}")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _resendCode() async {
    try {
      await Amplify.Auth.resendSignUpCode(username: widget.email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("📨 Confirmation code resent")),
      );
    } on AuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("❌ Error: ${e.message}")));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyCostants.background2,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Confirm Sign Up",
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
          SizedBox(height: 100),
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
                    const Text(
                      "Enter the confirmation code sent to your email:",
                      style: TextStyle(
                        fontSize: 18,
                        color: MyCostants.inEvidence,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: _codeController,
                      decoration: const InputDecoration(
                        labelText: "Confirmation Code",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _confirmSignUp,
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
                          : const Text(
                              "Confirm",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: MyCostants.secondary,
                              ),
                            ),
                    ),
                    TextButton(
                      onPressed: _resendCode,
                      child: const Text(
                        "Resend Code",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: MyCostants.inEvidence,
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
                  title: const Text("Cancel Sign Up"),
                  content: const Text(
                    "Are you sure you want to cancel the sign up process? You will have only 1 day to confirm your account",
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
}
