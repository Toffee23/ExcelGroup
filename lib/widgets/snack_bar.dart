import 'package:flutter/material.dart';

void showSuccessSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Row(
      children: <Widget>[
        const Icon(Icons.download_for_offline_rounded, color: Colors.green),
        const SizedBox(width: 8.0),
        Expanded(child: Text(message))
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);

  Future.delayed(const Duration(seconds: 3), () {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  });
}

void showErrorSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Row(
      children: <Widget>[
        const Icon(Icons.error, color: Colors.red),
        const SizedBox(width: 8.0),
        Expanded(child: Text(message))
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);

  Future.delayed(const Duration(seconds: 3), () {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  });
}
