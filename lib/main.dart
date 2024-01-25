import 'package:course_view/pages/notification/notification_service.dart';
import 'package:course_view/pages/notification/notification_ui.dart';
import 'package:course_view/providers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/constants/themes.dart';
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

class ExcelAcademy extends ConsumerWidget {
  const ExcelAcademy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Excel Academy',
      theme: AppThemeData.light(context),
      darkTheme: AppThemeData.dark(context),
      themeMode: ref.watch(themeModeProvider),
      home: const NavigationPage(),
      routes: {
        '/notification-screen': (context) => notificationUi(),
      },
    );
  }
}
