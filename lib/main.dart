import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pages/navigation/page.dart';

void main() => runApp(const ProviderScope(child: ExcelAcademy()));

class ExcelAcademy extends StatelessWidget {
  const ExcelAcademy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excel Academy',
      theme: ThemeData(
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
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFFF0F0F0),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).scaffoldBackgroundColor,
            statusBarIconBrightness: Brightness.dark,
          ),
          titleTextStyle:
              Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
        ),
      ),
      home: const NavigationPage(),
    );
  }
}
