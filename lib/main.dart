import 'package:course_view/pages/home/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pages/navigation/page.dart';

void main() => runApp(const ProviderScope(child: ExcelAcademy()));

class ExcelAcademy extends StatelessWidget {
  const ExcelAcademy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
