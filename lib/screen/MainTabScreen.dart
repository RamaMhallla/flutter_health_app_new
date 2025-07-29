import 'package:flutter/material.dart';
import 'package:flutter_health_app_new/screen/medicalHistory_screen.dart';
import 'package:flutter_health_app_new/widgets/drawer_widget.dart';
import 'package:flutter_health_app_new/utility/MyCostants.dart';
import 'package:flutter_health_app_new/screen/patientInput_screen.dart';
import 'package:flutter_health_app_new/screen/xrayAnalysis_screen.dart';

class MainTabScreen extends StatefulWidget {
  final int initialIndex;

  const MainTabScreen({super.key, this.initialIndex = 0});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  late int _currentIndex;

  final List<Widget> _screens = const [
    PatientInputDashboard(),
    PatientMedicalHistoryScreen(),
    XRayAnalysisScreen(),
  ];

  final List<String> _titles = [
    'Heart Health Monitor',
    'Medical History',
    'X-Ray Analysis',
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: DrawerWidget(
      //   onTabSelected: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      // ),
      // appBar: AppBar(
      //   title: Text(
      //     _titles[_currentIndex],
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 20,
      //       color: MyCostants.secondary,
      //       letterSpacing: 1.0,
      //     ),
      //   ),
      //   backgroundColor: MyCostants.primary,
      //   centerTitle: true,
      //   iconTheme: IconThemeData(color: MyCostants.secondary),
      // ),
      body: Container(
        color: MyCostants.background,
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
          border: Border(
            top: BorderSide(color: MyCostants.primary.withOpacity(0.2)),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: MyCostants.inEvidence,
          unselectedItemColor: MyCostants.textSecondary,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          backgroundColor: MyCostants.secondary,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.assignment_ind,
                size: _currentIndex == 0 ? 28 : 24,
              ),
              label: 'Heart',
              tooltip: 'Patient Data Input',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history, size: _currentIndex == 1 ? 28 : 24),
              label: 'History',
              tooltip: 'Medical History',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.image_search,
                size: _currentIndex == 2 ? 28 : 24,
              ),
              label: 'X-Ray',
              tooltip: 'X-Ray Analysis',
            ),
          ],
        ),
      ),
    );
  }
}
