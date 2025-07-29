// التعديلات الأساسية:
// - استبدال img.getRed() / getGreen / getBlue بعملية يدوية لاستخراج قيم R/G/B
// - لضمان التوافق مع مكتبة image الجديدة

// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_health_app_new/utility/MyCostants.dart';
import 'package:flutter_health_app_new/widgets/drawer_widget.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class XRayAnalysisScreen extends StatefulWidget {
  const XRayAnalysisScreen({super.key});

  @override
  State<XRayAnalysisScreen> createState() => _XRayAnalysisScreenState();
}

class _XRayAnalysisScreenState extends State<XRayAnalysisScreen> {
  File? _image;
  String _result = 'No analysis performed yet';
  String _confidence = '';
  late Interpreter _interpreter;
  final picker = ImagePicker();
  bool _isLoading = false;
  bool _modelLoaded = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    try {
      setState(() => _isLoading = true);
      _interpreter = await Interpreter.fromAsset(
        'assets/models/chest_xray_model.tflite',
      );
      setState(() {
        _modelLoaded = true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _result = 'Error loading analysis model';
        _isLoading = false;
      });
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    setState(() {
      _image = File(pickedFile.path);
      _result = 'Image loaded, ready for analysis';
      _confidence = '';
    });
  }

  Future<void> analyzeImage() async {
    if (_image == null || !_modelLoaded) return;

    setState(() {
      _isLoading = true;
      _result = 'Analyzing image...';
    });

    try {
      img.Image? imageInput = img.decodeImage(await _image!.readAsBytes());
      if (imageInput == null) {
        setState(() {
          _result = 'Error reading image';
          _isLoading = false;
        });
        return;
      }

      img.Image resizedImage = img.copyResize(
        imageInput,
        width: 150,
        height: 150,
      );

      var input = imageToByteListFloat32(resizedImage, 150);
      var output = List.filled(1 * 1, 0).reshape([1, 1]);

      _interpreter.run(input, output);

      double prediction = output[0][0];
      double confidence = prediction * 100;

      setState(() {
        if (prediction > 0.5) {
          _result = '⚠️ Pneumonia detected';
          _confidence = 'Confidence: ${confidence.toStringAsFixed(2)}%';
        } else {
          _result = '✅ Normal chest X-ray';
          _confidence = 'Confidence: ${(100 - confidence).toStringAsFixed(2)}%';
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _result = 'Error during analysis';
        _confidence = '';
        _isLoading = false;
      });
    }
  }

  List<List<List<List<double>>>> imageToByteListFloat32(
    img.Image image,
    int inputSize,
  ) {
    return [
      List.generate(inputSize, (y) {
        return List.generate(inputSize, (x) {
          final pixel = image.getPixel(x, y);
          final r = pixel.r / 255.0;
          final g = pixel.g / 255.0;
          final b = pixel.b / 255.0;

          return [r, g, b];
        });
      }),
    ];
  }

  //_buildImagePreview  Card to show the chosen image or No X-ray image selected
  Widget _buildImagePreview() {
    return Card(
      color: _image == null ? MyCostants.background2 : MyCostants.secondary,
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 4, // Card shadow depth
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Check if no image selected yet
            _image == null
                ? Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: MyCostants.background,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.image,
                            size: 40,
                            color: MyCostants.primary,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'No X-ray image selected',
                            style: TextStyle(color: MyCostants.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  )
                : ClipRRect(
                    // If image is selected, show it inside a clipped widget with rounded corners
                    borderRadius: BorderRadius.circular(10),
                    // _image! is the selected image file
                    child: Image.file(
                      _image!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
            if (_image != null) ...[
              // If image is selected, add description text
              const SizedBox(height: 12),
              Text(
                'Selected X-ray Image',
                style: TextStyle(color: MyCostants.textPrimary, fontSize: 14),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // _buildAnalysisCard - Card that displays the result of the AI analysiss
  Widget _buildAnalysisCard() {
    return Card(
      color: _confidence.isNotEmpty
          ? MyCostants.secondary
          : MyCostants.background2,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align content to the start (left)
          children: [
            Row(
              children: [
                Icon(
                  Icons.analytics,
                  size: 24,
                  color: _confidence.isNotEmpty
                      ? MyCostants.inEvidence
                      : MyCostants.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Analysis Results',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _confidence.isNotEmpty
                        ? MyCostants.inEvidence
                        : MyCostants.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _isLoading //Check if loading (analysis in progress)
                ? Center(
                    child: CircularProgressIndicator(color: MyCostants.primary),
                  )
                : Column(
                    // If not loading, show result text and confidence
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _result, // Display the result message (e.g., Pneumonia detected or Normal)
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: _result.startsWith('✅')
                              ? MyCostants.success
                              : _result.startsWith('⚠️')
                              ? MyCostants.error
                              : MyCostants.textPrimary,
                        ),
                      ),
                      if (_confidence.isNotEmpty) ...[
                        // If confidence score is available
                        const SizedBox(height: 8),
                        Text(
                          _confidence, // Show confidence score (e.g., 92.45%)
                          style: TextStyle(
                            fontSize: 14,
                            color: MyCostants.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyCostants.background,
      appBar: AppBar(
        title: const Text(
          'X-Ray Analysis',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
            color: MyCostants.secondary,
          ),
        ),
        backgroundColor: MyCostants.primary,
        centerTitle: true,
        elevation: 2, // Remove shadow under the AppBar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 80),
            _buildImagePreview(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed:
                        pickImage, // Function to open gallery and pick image
                    icon: const Icon(Icons.image, color: MyCostants.inEvidence),
                    label: const Text(
                      'Select Image',
                      style: TextStyle(color: MyCostants.inEvidence),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyCostants.secondary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: // Only enable button if model is loaded and image is selected
                    _modelLoaded && _image != null
                        ? analyzeImage
                        : null,
                    icon: const Icon(
                      Icons.analytics,
                      color: MyCostants.secondary,
                    ),
                    label: const Text(
                      'Analyze',
                      style: TextStyle(color: MyCostants.secondary),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyCostants.inEvidence,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildAnalysisCard(),
            if (!_modelLoaded && !_isLoading)
              // Show error if model failed to load
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Analysis model not ready. Please try again later.',
                  style: TextStyle(
                    color: MyCostants.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
