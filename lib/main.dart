import 'package:flutter/material.dart';
import 'package:flutter_health_app_new/providers/user_provider.dart';
import 'package:flutter_health_app_new/root/root.dart';
import 'package:provider/provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart'; 
import 'package:amplify_datastore/amplify_datastore.dart'; 
import 'models/ModelProvider.dart';
import 'amplifyconfiguration.dart';
 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();
  runApp(const MyApp());
}

Future<void> _configureAmplify() async {
  try {
    final authPlugin = AmplifyAuthCognito();
    final apiPlugin = AmplifyAPI(options: APIPluginOptions(modelProvider: ModelProvider.instance),);
    final dataStorePlugin = AmplifyDataStore(modelProvider: ModelProvider.instance);

    await Amplify.addPlugins([
      authPlugin,
      apiPlugin,
      dataStorePlugin, // Add this only if you installed amplify_datastore in pubspec.yaml
      // If you are also using analytics, add it here:
      // AmplifyAnalyticsPinpoint(),
    ]);
    await Amplify.configure(amplifyconfig);
Future<void> clearDataStore() async {
  try {
    await Amplify.DataStore.clear();
    safePrint('DataStore cleared successfully');
  } catch (e) {
    safePrint('Error clearing DataStore: $e');
  }
}

// Call this before your memorize() method or in your app initialization
await clearDataStore();

    safePrint("Amplify configured successfully.");
  } on AmplifyAlreadyConfiguredException {
    safePrint("Amplify already configured. This can happen when you hot reload during development.");
  } on AmplifyException catch (e) {
    safePrint("Error configuring Amplify: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Heart Health Monitor',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        debugShowCheckedModeBanner: false,
        home: const Root(), // أو LoginScreen / Dashboard ...
      ),
    );
  }
}
