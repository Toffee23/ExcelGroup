import 'package:course_view/pages/home/page.dart';
import 'package:course_view/pages/notification/notification_service.dart';
import 'package:course_view/pages/notification/notification_ui.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/navigation/page.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseFCM().initNotifications();

  /// notification start
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  runApp(const ProviderScope(child: ExcelAcademy()));
}

class ExcelAcademy extends StatelessWidget {
  const ExcelAcademy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        primaryColor: const Color(0xFFFF822B),
        useMaterial3: true,
        textTheme: TextTheme(
          titleSmall: TextStyle(
            color: Colors.blueGrey.shade700,
            fontWeight: FontWeight.bold,
            letterSpacing: .8,
            fontSize: 16,
          ),
          titleMedium: TextStyle(
            fontSize: 19,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade800,
          ),
        ),
      ),
      home: const NavigationPage(),
      routes: {
        '/notification-screen': (context) => notificationUi(),
      },
    );
  }
}
