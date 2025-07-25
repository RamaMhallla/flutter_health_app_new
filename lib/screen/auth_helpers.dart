import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

Future<String?> getIdToken() async {
  try {
    final session = await Amplify.Auth.fetchAuthSession() as CognitoAuthSession;

    if (session.isSignedIn) {
      final tokens = session.userPoolTokensResult.value;
      final idToken = tokens.idToken.raw; // ✅ استخدم raw بدل ما ترجع الكائن كله
      print("🔐 ID Token: $idToken");
      return idToken;
    } else {
      print("❌ Not signed in.");
      return null;
    }
  } catch (e) {
    print("❌ Failed to get ID token: $e");
    return null;
  }
}
