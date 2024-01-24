import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemeData {
  static light(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      primaryColor: const Color(0xFFFF822B),
      cardColor: const Color(0xFFF1F1EF),
      hintColor: const Color(0xFF767676),
      textTheme: TextTheme(
        titleSmall: TextStyle(
          color: Colors.blueGrey.shade700,
          fontWeight: FontWeight.bold,
          letterSpacing: .8,
          fontSize: 16,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey.shade800,
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade600,
          // color: Colors.red,
        ),
        headlineSmall: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: const Color(0xFFF0F0F0),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          statusBarIconBrightness: Brightness.dark,
        ),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: Color(0xFF191919),
        ),
      ),
    );
  }

  static dark(BuildContext context) =>
      ThemeData.dark(useMaterial3: true).copyWith(
        primaryColor: const Color(0xFFFF822B),
        canvasColor: const Color(0xFF191919),
        scaffoldBackgroundColor: const Color(0xff131313),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).scaffoldBackgroundColor,
            statusBarIconBrightness: Brightness.dark,
          ),
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Color(0xFFF3F3F1),
          ),
        ),
      );
}
