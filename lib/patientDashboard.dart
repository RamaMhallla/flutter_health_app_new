import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_health_app_new/models/ChestPain.dart';
import 'package:flutter_health_app_new/models/Gender.dart';
import 'package:flutter_health_app_new/models/Thalassemia.dart';
import 'package:flutter_health_app_new/providers/user_provider.dart';
import 'package:flutter_health_app_new/widgets/drawer_widget.dart';
import 'prediction_page.dart';
import 'dart:convert';
import 'dart:async';
import 'services/mqtt_service.dart';

class AppColor {
  // Primary colors
  static const primaryBlue = Color(0xFF5B8FB9);
  static const lightBlue = Color(0xFFB6D0E2);
  static const darkBlue = Color.fromARGB(255, 7, 72, 137);

  // Status colors
  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFFA000);
  static const error = Color(0xFFE53935);

  // Text colors
  static const textPrimary = Color(0xFF2C3E50);
  static const textSecondary = Color(0xFF7F8C8D);
}

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({super.key});

  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}


class _PatientDashboardState extends State<PatientDashboard> {
  final mqttService = MQTTService();
  bool _isConnected = false;
  bool _isLoading = false;

  Timer? _mqttTimeoutTimer; // ✅ مؤقت مهلة MQTT

  // Form values
  int _age = 30;
  Gender _gender = Gender.MALE;
  ChestPain _chestPainType = ChestPain.TYPICAL;
  bool _exerciseAngina = false;

  final TextEditingController cholController = TextEditingController();
  final TextEditingController fbsController = TextEditingController();
  final TextEditingController vesselsController = TextEditingController();
  final TextEditingController thalController = TextEditingController();

  // MQTT sensor data
  int? bloodPressure;
  int? restingEcg;
  int? maxHeartRate;
  double? stDepression;
  int? slope;
  // Add these variables to support maually insert when no connect with MQTT
  int? manualBloodPressure;
  int? manualRestingEcg;
  int? manualMaxHeartRate;
  double? manualstDepression;
  int? manualSlope;
  //bool _showManualSensorInputs = false;

  // State variables to add at the top of your class
  bool _fbs = false; // Fasting Blood Sugar
  int _vessels = 0; // Number of Major Vessels
  Thalassemia _thalassemiaType = Thalassemia.NORMAL; // Thalassemia Type
  // Chest pain type options
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

  @override
  void initState() { 
    super.initState();
    mqttService.onMessageReceived = handleMQTTMessage;
    mqttService.onConnected = () => setState(() => _isConnected = false);
    mqttService.onDisconnected = () => setState(() => _isConnected = false);
    mqttService.connect();
  }

  @override
  void dispose() {
    mqttService.disconnect();
    _mqttTimeoutTimer?.cancel(); // ✅ أوقف التايمر

    cholController.dispose();
    fbsController.dispose();
    vesselsController.dispose();
    thalController.dispose();
    super.dispose();
  }

  void _resetMQTTTimeout() {
    _mqttTimeoutTimer?.cancel();
    _mqttTimeoutTimer = Timer(const Duration(seconds: 15), () {
      print("⛔ No MQTT message received in 15 seconds. Disconnecting...");
      mqttService.disconnect();
      setState(() {
        _isConnected = false;
      });
    });
  }

  void handleMQTTMessage(String payload) {
    try {
      final data = jsonDecode(payload);

      // 🔐 التحقق من وجود timestamp في الرسالة
      if (!data.containsKey('timestamp')) {
        print("⚠️ Ignored message: No timestamp.");
        return;
      }

      // تحويل timestamp إلى DateTime
      final messageTime = DateTime.tryParse(data['timestamp']);
      if (messageTime == null) {
        print("⚠️ Ignored message: Invalid timestamp format.");
        return;
      }

      final now = DateTime.now().toUtc();
      final difference = now.difference(messageTime).inSeconds;

      // // ⛔ تجاهل الرسائل القديمة (أقدم من 5 ثواني)
      // if (difference > 5) {
      //   print("⚠️ Ignored old message: $difference seconds old.");
      //   return;
      // }

      // ✅ إعادة ضبط مؤقت المهلة لأن الرسالة صالحة
      _resetMQTTTimeout();

      // ✅ تحديث القيم
      setState(() {
        bloodPressure = data["bloodPressure"];
        restingEcg = data["restingEcg"];
        maxHeartRate = data["maxHeartRate"];
        stDepression = (data["stDepression"] as num).toDouble();
        slope = data["slope"];
      });

      print("📥 Processed valid message at $now (age: $difference sec)");
    } catch (e) {
      print("❌ Error parsing MQTT message: $e");
    }
  }

  Future<void> navigateToPredictionPage() async {
    // تحقق من حقول الإدخال اليدوي
    final manualInputsValid =
        _age > 0 &&
        (_exerciseAngina == true || _exerciseAngina == false) &&
        cholController.text.isNotEmpty;

    if (!manualInputsValid) {
      showValidationError("Please fill all required fields correctly");
      return;
    }

    // تحقق من بيانات الحساسات (إما من MQTT أو يدوي)
    final sensorValuesValid = _isConnected
        ? [bloodPressure, restingEcg, maxHeartRate, stDepression, slope].contains(null) == false
        : [
                manualBloodPressure,
                manualRestingEcg,
                manualMaxHeartRate,
                manualstDepression,
                manualSlope,
              ].contains(null) ==
              false;

    if (!sensorValuesValid) {
      showValidationError("Please provide all sensor values");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final bloodPressureValue = _isConnected ? bloodPressure! : manualBloodPressure!;
      final restingEcgValue = _isConnected ? restingEcg! : manualRestingEcg!;
      final maxHeartRateValue = _isConnected ? maxHeartRate! : manualMaxHeartRate!;
      final stDepressionValue = _isConnected ? stDepression! : manualstDepression!;
      final slopeValue = _isConnected ? slope! : manualSlope!;

      final Map<String, double> inputFeatures = {
        'age': _age.toDouble(), 
        'gender': _gender == Gender.MALE ? 1.0 : 0.0,
        'chestPain': chestPainLabels.keys.toList().indexOf(_chestPainType).toDouble(),
        'blood Pressure':bloodPressureValue.toDouble(),
        'cholesterol': double.parse(cholController.text),
        'fastingBloodSugar':_fbs ? 1.0 : 0.0,
        'restingEcg': restingEcgValue.toDouble(),
        'maxHeartRate': maxHeartRateValue.toDouble(),
        'exerciseAngina':_exerciseAngina ? 1.0 : 0.0,
        'stDepression':stDepressionValue,
        'slope':slopeValue.toDouble(),
        'numberOfVessels':_vessels.toDouble(),
        'thalassemia': thalassemiaLabels.keys.toList().indexOf(_thalassemiaType).toDouble(),
      };

      if (!mounted) return;

      // // 🟡 تخزين بيانات المريض في DataStore
      // final patient = Patient(
      //   name: "Patient",
      //   age: _age,
      //   gender: _gender,
      //   createdAt: TemporalDateTime.now(),
      //   chestPainType: _chestPainType,
      //   exerciseAngina: _exerciseAngina,
      //   cholesterol: double.tryParse(cholController.text) ?? 0.0,
      //   fbs: _fbs,
      //   restecg: _isConnected ? restecg! : manualRestecg ?? 0,
      //   trestbps: _isConnected ? trestbps! : manualTrestbps ?? 0,
      //   thalach: _isConnected ? thalach! : manualThalach ?? 0,
      //   oldpeak: _isConnected ? oldpeak! : manualOldpeak ?? 0.0,
      //   slope: _isConnected ? slope! : manualSlope ?? 0,
      //   vessels: _vessels,
      //   thal: _thal,
      //   result: "", // we can edit it after analysis
      // );

      // try {
      // final request = ModelMutations.create(patient);
      // final response = await Amplify.API.mutate(request: request).response;

      //   if (response.errors.isEmpty) {
      //     print('✅ Patient added successfully via API');
      //   } else {
      //     print('❌ API error: ${response.errors}');
      //   }
      // } catch (e) {
      //   print('❌ Exception while sending patient: $e');
      // }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PredictionPage(
            inputFeatures: inputFeatures,
            name: "Patient",
            gender: _gender,
          ),
        ),
      );
    } catch (e) {
      showValidationError("Error in input values: \${e.toString()}");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildManualSensorInputs() {
    final cards = [
      _buildSensorInputCard(
        icon: Icons.monitor_heart,
        title: 'Blood Pressure',
        unit: 'mmHg',
        value: manualBloodPressure?.toString() ?? '',
        hint: '120',
        onChanged: (value) => manualBloodPressure = int.tryParse(value),
      ),
      _buildSensorInputCard(
        icon: Icons.monitor_heart,
        title: 'Resting ECG',
        value: manualRestingEcg?.toString() ?? '',
        hint: '0-2',
        onChanged: (value) => manualRestingEcg = int.tryParse(value),
      ),
      _buildSensorInputCard(
        icon: Icons.favorite,
        title: 'Max Heart Rate',
        unit: 'BPM',
        value: manualMaxHeartRate?.toString() ?? '',
        hint: '150',
        onChanged: (value) => manualMaxHeartRate = int.tryParse(value),
      ),
      _buildSensorInputCard(
        icon: Icons.trending_down,
        title: 'ST Depression',
        value: manualstDepression?.toString() ?? '',
        hint: '1.5',
        onChanged: (value) => manualstDepression = double.tryParse(value),
      ),
      _buildSensorInputCard(
        icon: Icons.stacked_line_chart,
        title: 'Slope',
        value: manualSlope?.toString() ?? '',
        hint: '0-2',
        onChanged: (value) => manualSlope = int.tryParse(value),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColor.primaryBlue.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.edit_attributes,
                size: 20,
                color: AppColor.primaryBlue,
              ),
              SizedBox(width: 8),
              Text(
                'Enter Sensor Values Manually',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.darkBlue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: [
            // الصف الأول: بطاقتين
            Row(
              children: [
                Expanded(child: cards[0]),
                const SizedBox(width: 12),
                Expanded(child: cards[1]),
              ],
            ),
            const SizedBox(height: 12),
            // الصف الثاني: بطاقتين
            Row(
              children: [
                Expanded(child: cards[2]),
                const SizedBox(width: 12),
                Expanded(child: cards[3]),
              ],
            ),
            const SizedBox(height: 12),
            // الصف الثالث: بطاقة واحدة (الأخيرة)
            Row(
              children: [
                Expanded(child: cards[4]),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(),
                ), // مساحة فارغة للمحافظة على التنسيق
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSensorInputCard({
    required IconData icon,
    required String title,
    required String value,
    required String hint,
    required Function(String) onChanged,
    String? unit,
  }) {
    final controller = TextEditingController(text: value);
    controller.selection = TextSelection.collapsed(
      offset: controller.text.length,
    );

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: AppColor.primaryBlue.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: AppColor.primaryBlue),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColor.primaryBlue.withValues(alpha: 0.5),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
                suffix: unit != null
                    ? Text(
                        unit,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.textSecondary,
                        ),
                      )
                    : null,
              ),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Age',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColor.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (_age > 1) _age--;
                });
              },
            ),
            Container(
              width: 60,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.primaryBlue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$_age',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  if (_age < 120) _age++;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColor.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ChoiceChip(
                label: const Text('Male'),
                selected: _gender == Gender.MALE,
                onSelected: (selected) {
                  setState(() {
                    _gender =  Gender.MALE;
                  });
                },
                selectedColor: AppColor.primaryBlue,
                labelStyle: TextStyle(
                  color: _gender ==  Gender.MALE
                      ? Colors.white
                      : AppColor.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: 3),
            Expanded(
              child: ChoiceChip(
                label: const Text('Female'),
                selected: _gender ==  Gender.FEMALE,
                onSelected: (selected) {
                  setState(() {
                    _gender =Gender.FEMALE;
                  });
                },
                selectedColor: AppColor.primaryBlue,
                labelStyle: TextStyle(
                  color: _gender ==Gender.FEMALE
                      ? Colors.white
                      : AppColor.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: 3),
            Expanded(
              child: ChoiceChip(
                label: const Text('Other'),
                selected: _gender ==  Gender.OTHER,
                onSelected: (selected) {
                  setState(() {
                    _gender =Gender.OTHER;
                  });
                },
                selectedColor: AppColor.primaryBlue,
                labelStyle: TextStyle(
                  color: _gender ==Gender.OTHER
                      ? Colors.white
                      : AppColor.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChestPainDropdown() {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chest Pain Type',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColor.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<ChestPain>(
          value: _chestPainType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.primaryBlue),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
          ),
          items: ChestPain.values.map((ChestPain type) {
            return DropdownMenuItem<ChestPain>(
              value: type,
              child: Text(chestPainLabels[type]!),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _chestPainType = newValue!;
            });
          },
        ),
      ],
    );
  }


  Widget _buildExerciseAnginaToggle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Exercise Induced Angina',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColor.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ChoiceChip(
                label: const Text('Yes'),
                selected: _exerciseAngina,
                onSelected: (selected) {
                  setState(() {
                    _exerciseAngina = true;
                  });
                },
                selectedColor: AppColor.primaryBlue,
                labelStyle: TextStyle(
                  color: _exerciseAngina ? Colors.white : AppColor.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ChoiceChip(
                label: const Text('No'),
                selected: !_exerciseAngina,
                onSelected: (selected) {
                  setState(() {
                    _exerciseAngina = false;
                  });
                },
                selectedColor: AppColor.primaryBlue,
                labelStyle: TextStyle(
                  color: !_exerciseAngina ? Colors.white : AppColor.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColor.warning,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  /* Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    String? helperText,
    int? maxLength,
    ValueChanged<String>? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColor.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            maxLength: maxLength,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              helperText: helperText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColor.primaryBlue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColor.primaryBlue, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }*/

  Widget _buildMedicalDataSection() {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.medical_services,
                  size: 24,
                  color: AppColor.darkBlue,
                ),
                SizedBox(width: 8),
                Text(
                  'Medical Data',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.darkBlue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Cholesterol Input
            _buildLabValueInput(
              label: 'Cholesterol (mg/dL)',
              controller: cholController,
              unit: 'mg/dL',
              hint: 'Enter value (e.g., 200)',
              maxLength: 4,
              icon: Icons.bloodtype,
            ),

            const SizedBox(height: 16),

            // Fasting Blood Sugar Toggle
            _buildToggleInput(
              label: 'Fasting Blood Sugar >120 mg/dL',
              value: _fbs,
              onChanged: (val) => setState(() => _fbs = val),
              icon: Icons.monitor_heart,
            ),

            const SizedBox(height: 16),

            // Number of Major Vessels Selector
            _buildVesselSelector(),

            const SizedBox(height: 16),

            // Thalassemia Type Selector
            _buildThalassemiaSelector(),
          ],
        ),
      ),
    );
  }

  Widget _buildLabValueInput({
    required String label,
    required TextEditingController controller,
    required String unit,
    required String hint,
    required int maxLength,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: AppColor.primaryBlue),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColor.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                maxLength: maxLength,
                decoration: InputDecoration(
                  hintText: hint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColor.primaryBlue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColor.primaryBlue,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  counterText: '',
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: AppColor.lightBlue,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.primaryBlue),
              ),
              child: Text(
                unit,
                style: const TextStyle(
                  color: AppColor.darkBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToggleInput({
    required String label,
    required bool value,
    required Function(bool) onChanged,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: AppColor.primaryBlue),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColor.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(value ? 'Yes' : 'No'),
          value: value,
          onChanged: onChanged,
          activeColor: AppColor.primaryBlue,
        ),
      ],
    );
  }

  Widget _buildVesselSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bloodtype, size: 20, color: AppColor.primaryBlue),
            const SizedBox(width: 8),
            Text(
              'Number of Major Vessels (0-4)',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColor.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: List.generate(5, (index) {
            return ChoiceChip(
              label: Text('$index'),
              selected: _vessels == index,
              onSelected: (selected) {
                setState(() {
                  _vessels = index;
                });
              },
              selectedColor: AppColor.primaryBlue,
              labelStyle: TextStyle(
                color: _vessels == index ? Colors.white : AppColor.textPrimary,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildThalassemiaSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.health_and_safety,
              size: 20,
              color: AppColor.primaryBlue,
            ),
            const SizedBox(width: 8),
            Text(
              'Thalassemia Type',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColor.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<Thalassemia>(
          value: _thalassemiaType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.primaryBlue),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
          ),
          items: Thalassemia.values.map((Thalassemia type) {
                  return DropdownMenuItem<Thalassemia>(
                    value: type,
                    child: Text(thalassemiaLabels[type]!),
                  );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _thalassemiaType = newValue!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSensorDataSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.sensors, size: 24, color: AppColor.primaryBlue),
                const SizedBox(width: 8),
                const Text(
                  'Sensor Data',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryBlue,
                  ),
                ),
                const Spacer(),
                _buildConnectionStatus(),
              ],
            ),
            const SizedBox(height: 16),

            if (_isConnected) ...[
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _buildDataTile(
                    icon: Icons.monitor_heart,
                    title: 'Blood Pressure',
                    value: '${bloodPressure ?? '--'} mmHg',
                  ),
                  _buildDataTile(
                    icon: Icons.monitor_heart,
                    title: 'Resting ECG',
                    value: '${restingEcg ?? '--'}',
                  ),
                  _buildDataTile(
                    icon: Icons.favorite,
                    title: 'Max Heart Rate',
                    value: '${maxHeartRate ?? '--'} BPM',
                  ),
                  _buildDataTile(
                    icon: Icons.trending_down,
                    title: 'ST Depression',
                    value: stDepression?.toStringAsFixed(2) ?? '--',
                  ),
                  _buildDataTile(
                    icon: Icons.stacked_line_chart,
                    title: 'Slope',
                    value: '${slope ?? '--'}',
                  ),
                ],
              ),
            ] else ...[
              // Text(
              //   'No MQTT connection. Please enter sensor values manually:',
              //   style: TextStyle(color: AppColor.textSecondary),
              // ),
              _buildManualSensorInputs(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionStatus() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _isConnected ? AppColor.success : AppColor.error,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _isConnected ? Icons.wifi : Icons.wifi_off,
            size: 16,
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            _isConnected ? 'Connected' : 'Disconnected',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.lightBlue.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.primaryBlue.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: AppColor.primaryBlue),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.darkBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyzeButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : navigateToPredictionPage,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryBlue,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        child: _isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.analytics, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Analyze Heart Risk',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildManualInputSection() {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.person_outline, size: 24, color: AppColor.darkBlue),
                SizedBox(width: 8),
                Text(
                  'Patient Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.darkBlue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildAgeSelector(),
            const SizedBox(height: 16),
            _buildGenderSelector(),
            const SizedBox(height: 16),
            _buildChestPainDropdown(),
            const SizedBox(height: 16),
            _buildExerciseAnginaToggle(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightBlue,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text('Heart Health Monitor'),
        backgroundColor: AppColor.lightBlue,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {}),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildManualInputSection(),
            _buildMedicalDataSection(),
            _buildSensorDataSection(),
            const SizedBox(height: 24),
            _buildAnalyzeButton(),
          ],
        ),
      ),
    );
  }
}
