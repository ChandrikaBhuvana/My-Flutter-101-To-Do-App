import 'package:firebase_core/firebase_core.dart';             // Firebase core package for initialization

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => android;       // Always use Android config (we target Android)

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR_API_KEY',                                    // 🔁 Replace with your apiKey
    appId: 'YOUR_APP_ID',                                      // 🔁 Replace with your appId
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',             // 🔁 Replace with your sender ID
    projectId: 'YOUR_PROJECT_ID',                              // 🔁 Replace with your project ID
    storageBucket: 'YOUR_BUCKET.appspot.com',                  // 🔁 Replace with your storage bucket
  );
}
