import 'package:course_view/core/constants/images.dart';
import 'package:flutter/material.dart';

enum SnackbarType { success, error, warning }

Color _getColor(SnackbarType state) {
  switch (state) {
    case SnackbarType.success:
      return const Color(0xFF1FAF73);
    case SnackbarType.error:
      return const Color(0xFFAF1FA9);
    case SnackbarType.warning:
      return Colors.amber;
  }
}

Widget _getIcon(SnackbarType state) {
  switch (state) {
    case SnackbarType.success:
      return AssetImages.tickCirle;
    case SnackbarType.error:
      return AssetImages.closeCirle;
    case SnackbarType.warning:
      return AssetImages.infoCircle;
  }
}

void showSnackbar({
  required BuildContext context,
  required String title,
  String? subtitle,
  SnackbarType type = SnackbarType.success,
}) {
  final snackBar = SnackBar(
    content: Container(
      color: _getColor(type).withOpacity(.12),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                // Icon(
                //   Icons.check_circle,
                //   color: _getColor(type),
                // ),
                _getIcon(type),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          color: _getColor(type),
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
          Divider(
            height: 0.0,
            thickness: 4.0,
            color: _getColor(type),
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
