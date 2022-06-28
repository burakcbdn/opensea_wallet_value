import 'package:firebase_analytics/firebase_analytics.dart';

class Analytics {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static Future logEvent({required String name, Map<String, dynamic>? paramaters}) async {
    await analytics.logEvent(
      name: name,
      parameters: paramaters,
    );
  }
}
