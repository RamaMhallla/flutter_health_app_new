import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppColor {
  static const primaryBlue = Color(0xFF5B8FB9);
  static const lightBlue = Color(0xFFB6D0E2);
  static const darkBlue = Color.fromARGB(255, 7, 72, 137);
  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFFA000);
  static const error = Color(0xFFE53935);
  static const textPrimary = Color(0xFF2C3E50);
  static const textSecondary = Color(0xFF7F8C8D);
}

class PredictionPage extends StatefulWidget {
  final List<double> inputFeatures;
  final String name;
  final int age;
  final String gender;

  const PredictionPage({
    super.key,
    required this.inputFeatures,
    required this.name,
    required this.age,
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

  List<double> mean = [
    54.4628099,
    0.65702479,
    0.991735537,
    130.359504,
    246.842975,
    0.128099174,
    0.553719008,
    150.115702,
    0.314049587,
    1.01322314,
    1.4214876,
    0.681818182,
    2.30165289,
  ];

  List<double> scale = [
    9.18545502,
    0.47470329,
    1.02041855,
    16.79405187,
    52.68627062,
    0.3342002,
    0.52931287,
    22.30616788,
    0.46413623,
    1.10029614,
    0.60646743,
    0.98857105,
    0.59258273,
  ];

  List<double> normalize(List<double> input) {
    return List.generate(input.length, (i) => (input[i] - mean[i]) / scale[i]);
  }

  @override
  void initState() {
    super.initState();
    runModel();
  }

  Future<void> runModel() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      final isOnline = connectivityResult != ConnectivityResult.none;

      double prediction;
      List<double> normalizedInput = normalize(widget.inputFeatures);

      if (isOnline) {
        try {
          final url = Uri.parse(
            'https://pj1e33elr0.execute-api.eu-central-1.amazonaws.com/prod/predict',
          );

          final response = await http.post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'features': normalizedInput}),
          );

          if (response.statusCode == 200) {
            prediction = jsonDecode(
              jsonDecode(response.body)['body'],
            )['prediction'];
            source = "(AWS)";
          } else {
            throw Exception("AWS Error: ${response.statusCode}");
          }
        } catch (e) {
          print("⚠️ AWS call failed, switching to local model: $e");
          print("⚠️ AWS call failed, switching to local model: $e");
          prediction = await runLocalModel(normalizedInput);
          source = "(Local)";
        }
      } else {
        prediction = await runLocalModel(normalizedInput);
        source = "(Local)";
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
          Icon(icon, size: 22, color: AppColor.primaryBlue),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColor.textPrimary,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: AppColor.darkBlue,
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
        valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryBlue),
      );
    }
    final isHighRisk = result.contains('High');
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isHighRisk
            ? AppColor.error.withValues(alpha: 0.1)
            : AppColor.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighRisk ? AppColor.error : AppColor.success,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(
            isHighRisk ? Icons.warning : Icons.check_circle,
            size: 48,
            color: isHighRisk ? AppColor.error : AppColor.success,
          ),
          const SizedBox(height: 12),
          Text(
            "$result\n(${(predictionValue * 100).toStringAsFixed(2)}%) $source",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isHighRisk ? AppColor.error : AppColor.success,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            isHighRisk
                ? 'Please consult a doctor immediately'
                : 'Your heart health appears normal',
            style: TextStyle(fontSize: 16, color: AppColor.lightBlue),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightBlue,
      appBar: AppBar(
        title: const Text('Heart Risk Prediction'),
        backgroundColor: AppColor.lightBlue,
        centerTitle: true,
        elevation: 0,
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
                    color: AppColor.darkBlue,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInfoRow(Icons.person, 'Name:', widget.name),
                _buildInfoRow(Icons.cake, 'Age:', widget.age.toString()),
                _buildInfoRow(
                  Icons.wc,
                  'Gender:',
                  widget.gender[0].toUpperCase() + widget.gender.substring(1),
                ),
                const Divider(height: 32, thickness: 1),
                Text(
                  'Risk Assessment',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.darkBlue,
                  ),
                ),
                const SizedBox(height: 16),
                Center(child: _buildResultIndicator()),
                const SizedBox(height: 24),
                if (!_isLoading)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryBlue,
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
