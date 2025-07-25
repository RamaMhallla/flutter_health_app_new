import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_health_app_new/models/PatientData.dart';
import 'package:flutter_health_app_new/providers/user_provider.dart';
import 'package:flutter_health_app_new/utility/MyCostants.dart';
import 'package:flutter_health_app_new/widgets/drawer_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PatientMedicalHistoryScreen extends StatefulWidget {
  const PatientMedicalHistoryScreen({super.key});

  @override
  State<PatientMedicalHistoryScreen> createState() => _PatientMedicalHistoryScreenState();
}

class _PatientMedicalHistoryScreenState extends State<PatientMedicalHistoryScreen> {
  List<PatientData> results = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPatientData();
  }

  Future<void> fetchPatientData() async {
    try {
      final email = Provider.of<UserProvider>(context, listen: false).userEmail;

      final ret = await Amplify.DataStore.query(
        PatientData.classType,
        where: PatientData.ID.eq(email),
      );

      setState(() {
        results = ret;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching patient data: $e');
      setState(() => isLoading = false);
    }
  }

  String formatEnum(dynamic value) {
    return value.toString().split('.').last.replaceAll('_', ' ').toUpperCase();
  }

  String formatDate(TemporalDateTime time) {
    return DateFormat.yMMMd().add_jm().format(time.getDateTimeInUtc());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(title: Text("Medical History Dashboard", style: TextStyle(  fontWeight: FontWeight.bold,
            letterSpacing: 1.1,color: MyCostants.secondary),),centerTitle: true,  elevation: 2, backgroundColor: MyCostants.primary,),
      backgroundColor: MyCostants.background,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : results.isEmpty
              ? Center(child: Text("No patient records found."))
              : ListView.builder(
                  itemCount: results.length,
                  padding: EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    final patient = results[index];
                    return Card(
                      color: MyCostants.secondary,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoRow("Timestamp", formatDate(patient.timestamp)),
                            _infoRow("Age", patient.age?.toString()),
                            _infoRow("Gender", formatEnum(patient.gender)),
                            _infoRow("Chest Pain", formatEnum(patient.chestPain)),
                            _infoRow("Exercise Angina", patient.exerciseAngina==null ? "no": patient.exerciseAngina! ? "Yes" : "No"),
                            _infoRow("Cholesterol", patient.cholesterol?.toStringAsFixed(1)),
                            _infoRow("Number of Vessels", patient.numberOfVessels?.toString()),
                            _infoRow("Thalassemia", formatEnum(patient.thalassemia)),
                            _infoRow("Fasting Blood Sugar", patient.fastingBloodSugar==null ? "No" : patient.fastingBloodSugar! ? "Yes" : "No"),
                            _infoRow("Blood Pressure", patient.bloodPressure?.toString()),
                            _infoRow("Resting ECG", patient.restingEcg?.toString()),
                            _infoRow("Max Heart Rate", patient.maxHeartRate?.toString()),
                            _infoRow("ST Depression", patient.stDepression?.toStringAsFixed(2)),
                            _infoRow("Slope", patient.slope?.toString()),
                            _infoRow("Output", patient.output?.toStringAsFixed(2)),
                            _infoRow("Model", patient.model?.toString()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget _infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold,color: MyCostants.textPrimary)),
          Text(value ?? "N/A", style: TextStyle(color:MyCostants.textSubtitle)),
        ],
      ),
    );
  }
}
