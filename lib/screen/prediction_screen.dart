import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_app_new/models/ChestPain.dart';
import 'package:flutter_health_app_new/models/Gender.dart';
import 'package:flutter_health_app_new/models/ModelProvider.dart';
import 'package:flutter_health_app_new/models/PatientData.dart';
import 'package:flutter_health_app_new/models/Thalassemia.dart';
import 'package:flutter_health_app_new/providers/user_provider.dart';
import 'package:flutter_health_app_new/screen/auth_helpers.dart';
import 'package:flutter_health_app_new/utility/MyCostants.dart';
import 'package:provider/provider.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictionPage extends StatefulWidget {
  final Map<String, double> inputFeatures;
  final Gender gender;

  const PredictionPage({
    super.key,
    required this.inputFeatures,
    required this.gender,
  });

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  String result = 'Analyzing...';
  bool _isLoading = true;
  String source = '';
  double predictionValue = 0.0;

  final Map<ChestPain, String> chestPainLabels = {
    ChestPain.TYPICAL: 'Typical angina',
    ChestPain.ATYPICAL: 'Atypical angina',
    ChestPain.NON_ANGINAL: 'Non-anginal pain',
    ChestPain.ASYMPTOMATIC: 'Asymptomatic',
  };

  final Map<Thalassemia, String> thalassemiaLabels = {
    Thalassemia.NORMAL: 'Normal',
    Thalassemia.FIXED_DEFECT: 'Fixed Defect',
    Thalassemia.REVERSIBLE_DEFECT: 'Reversible Defect',
  };

  Map<String, double> mean = {
    'age': 54.4628099,
    'gender': 0.65702479,
    'chestPain': 0.991735537,
    'blood Pressure': 130.359504,
    'cholesterol': 246.842975,
    'fastingBloodSugar': 0.128099174,
    'restingEcg': 0.553719008,
    'maxHeartRate': 150.115702,
    'exerciseAngina': 0.314049587,
    'stDepression': 1.01322314,
    'slope': 1.4214876,
    'numberOfVessels': 0.681818182,
    'thalassemia': 2.30165289,
  };

  Map<String, double> scale = {
    'age': 9.18545502,
    'gender': 0.47470329,
    'chestPain': 1.02041855,
    'blood Pressure': 16.79405187,
    'cholesterol': 52.68627062,
    'fastingBloodSugar': 0.3342002,
    'restingEcg': 0.52931287,
    'maxHeartRate': 22.30616788,
    'exerciseAngina': 0.46413623,
    'stDepression': 1.10029614,
    'slope': 0.60646743,
    'numberOfVessels': 0.98857105,
    'thalassemia': 0.59258273,
  };

  List<double> normalize(Map<String, double> input) {
    List<double> ret = [];

    input.forEach((key, value) {
      ret.add((value - mean[key]!) / scale[key]!);
    });

    return ret;
  }

  @override
  void initState() {
    super.initState();
    runModel();
  }

  Future<void> runModel() async {
    try {
      print("🚀 STARTING runModel() function...");
      print("🔥 input features: ${widget.inputFeatures}");

      List<double> normalizedInput = normalize(widget.inputFeatures);
      print("📥 Normalized Input: $normalizedInput");

      double prediction;

      // Always try calling the API first
      try {
        final url = Uri.parse(
          'https://pj1e33elr0.execute-api.eu-central-1.amazonaws.com/prod/predict',
        );

        final idToken = await getIdToken();
        print("🪪 Token: $idToken");

        if (idToken != null) {
          final response = await http.post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $idToken',
            },
            body: jsonEncode({'features': normalizedInput}),
          );

          print("🔁 Response Body: ${response.body}");

          if (response.statusCode == 200) {
            final decoded = jsonDecode(response.body); // Map<String, dynamic>
            prediction = decoded['prediction']?.toDouble() ?? 0.0;

            print("✅ Prediction from AWS: $prediction");
            source = "AWS";
          } else {
            throw Exception(
              "AWS Error: ${response.statusCode} - ${response.body}",
            );
          }
        } else {
          throw Exception("🛑 Token is null");
        }
      } catch (e) {
        print("⚠️❌ API request failed, fallback to local model: $e");
        prediction = await runLocalModel(normalizedInput);
        source = "Local";
      }

      setState(() {
        predictionValue = prediction;
        result = prediction > 0.5 ? 'High Risk Detected' : 'Low Risk (Normal)';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        result = 'Error: ${e.toString()}';
        _isLoading = false;
        source = '';
      });
    }
  }

  Future<double> runLocalModel(List<double> normalizedInput) async {
    final interpreter = await Interpreter.fromAsset(
      'assets/models/heart_model.tflite',
    );
    var input = [normalizedInput];
    var output = List.filled(1 * 1, 0).reshape([1, 1]);
    interpreter.run(input, output);

    return output[0][0].toDouble();
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 22, color: MyCostants.primary),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: MyCostants.textPrimary,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: MyCostants.inEvidence,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultIndicator() {
    if (_isLoading) {
      return const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(MyCostants.primary),
      );
    }
    final isHighRisk = result.contains('High');
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isHighRisk
            ? MyCostants.error.withValues(alpha: 0.1)
            : MyCostants.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighRisk ? MyCostants.error : MyCostants.success,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(
            isHighRisk ? Icons.warning : Icons.check_circle,
            size: 48,
            color: isHighRisk ? MyCostants.error : MyCostants.success,
          ),
          const SizedBox(height: 12),
          Text(
            "$result\n(${(predictionValue * 100).toStringAsFixed(2)}%) ($source)",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isHighRisk ? MyCostants.error : MyCostants.success,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            isHighRisk
                ? 'Please consult a doctor immediately'
                : 'Your heart health appears normal',
            style: TextStyle(fontSize: 16, color: MyCostants.textPrimary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyCostants.background,
      appBar: AppBar(
        title: const Text(
          'Heart Risk Prediction',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Patient Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: MyCostants.inEvidence,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInfoRow(
                  Icons.person,
                  'Name:',
                  Provider.of<UserProvider>(context, listen: false).userEmail,
                ),
                _buildInfoRow(
                  Icons.cake,
                  'Age:',
                  widget.inputFeatures['age']!.toInt().toString(),
                ),
                _buildInfoRow(
                  Icons.wc,
                  'Gender:',
                  widget.gender.toString().split('.')[1].capitalized,
                ),
                const Divider(height: 32, thickness: 1),
                Text(
                  'Risk Assessment',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: MyCostants.inEvidence,
                  ),
                ),
                const SizedBox(height: 16),
                Center(child: _buildResultIndicator()),
                const SizedBox(height: 24),
                if (!_isLoading)
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => memorize(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyCostants.success,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Memorize',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MyCostants.secondary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyCostants.primary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Return to Dashboard',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MyCostants.secondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> memorize() async {
    try {
      final newPatientRecord = PatientData(
        id: Provider.of<UserProvider>(context, listen: false).userEmail,
        timestamp: TemporalDateTime.new(
          DateTime.now().toLocal(),
        ), //the problem is the emulator you need to change the timezone in setting of android
        age: widget.inputFeatures['age']!.toInt(),
        gender: widget.gender,
        chestPain: chestPainLabels.keys.elementAt(
          widget.inputFeatures['chestPain']!.toInt(),
        ),
        exerciseAngina: widget.inputFeatures['exerciseAngina'] == 1.0
            ? true
            : false,
        cholesterol: widget.inputFeatures['cholesterol'],
        numberOfVessels: widget.inputFeatures['numberOfVessels']!.toInt(),
        thalassemia: thalassemiaLabels.keys.elementAt(
          widget.inputFeatures['thalassemia']!.toInt(),
        ),
        fastingBloodSugar: widget.inputFeatures['fastingBloodSugar'] == 1.0
            ? true
            : false,
        bloodPressure: widget.inputFeatures['blood Pressure']!.toInt(),
        restingEcg: widget.inputFeatures['restingEcg']!.toInt(),
        maxHeartRate: widget.inputFeatures['maxHeartRate']!.toInt(),
        stDepression: widget.inputFeatures['stDepression'],
        slope: widget.inputFeatures['slope']!.toInt(),
        output: predictionValue,
        model: source,
      );
      await Amplify.DataStore.save(newPatientRecord);
      safePrint('Patient data saved successfully to DynamoDB via DataStore!');
    } on AuthException catch (e) {
      safePrint('Error getting user for saving data: ${e.message}');
      // Handle cases where the user is not authenticated.
    } on DataStoreException catch (e) {
      safePrint('Error saving patient data: ${e.message}');
    } catch (e) {
      safePrint('An unexpected error occurred during data saving: $e');
    }
  }
}
