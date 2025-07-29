import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_health_app_new/screen/patientInput_screen.dart';
import 'package:flutter_health_app_new/screen/medicalHistory_screen.dart';
import 'package:flutter_health_app_new/screen/login_screen.dart';
import 'package:flutter_health_app_new/screen/xrayAnalysis_screen.dart';
import 'package:flutter_health_app_new/utility/MyCostants.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Drawer(
      backgroundColor: MyCostants.background2,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: MyCostants.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: MyCostants.primary,
                      child: Image.asset(
                        "assets/images/profile.png",
                        width: 64,
                        height: 64,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email: ",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: MyCostants.secondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 4),
                          Text(
                            userProvider.userEmail.isNotEmpty
                                ? userProvider.userEmail
                                : "patient@email.com",
                            style: const TextStyle(
                              fontSize: 14,
                              color: MyCostants.background2,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Menu Items
              Expanded(
                child: ListView(
                  children: [
                    _buildMenuItem(
                      icon: Icons.medical_information,
                      title: "X-Ray Analysis",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const XRayAnalysisScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.analytics,
                      title: "Heart Health Analysis",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PatientInputDashboard(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.history,
                      title: "Medical History",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const PatientMedicalHistoryScreen(),
                          ),
                        );
                      },
                    ),
                    /*_buildMenuItem(
                      icon: Icons.settings,
                      title: "Settings",
                      onTap: () => Navigator.pop(context),
                    ),*/
                  ],
                ),
              ),

              const Divider(height: 24),

              // Logout
              _buildMenuItem(
                icon: Icons.logout,
                title: "Logout",
                color: MyCostants.error,
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Confirm Logout"),
                      content: const Text("Are you sure you want to log out?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => {
                            Navigator.pop(context, true),
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            ),
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(color: MyCostants.error),
                          ),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    try {
                      await Amplify.Auth.signOut(
                        options: const SignOutOptions(globalSignOut: true),
                      );

                      userProvider.signOut(); // 🧹 Clear user info

                      if (context.mounted) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    } on AuthException catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Logout failed: ${e.message}"),
                            backgroundColor: MyCostants.error,
                          ),
                        );
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = MyCostants.inEvidence,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}
