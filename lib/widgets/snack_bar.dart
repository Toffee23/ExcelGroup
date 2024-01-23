import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String title, [String? subtitle]) {
  final snackBar = SnackBar(
    content: Container(
      color: const Color(0xFF1FAF73).withOpacity(.12),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF1FAF73),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF1FAF73),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF999999),
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          const Divider(
            height: 0.0,
            thickness: 4.0,
            color: Color(0xFF1FAF73),
          ),
        ],
      ),
    ),
    // backgroundColor: Colors.white,
    padding: EdgeInsets.zero,
    duration: const Duration(seconds: 5),
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

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
