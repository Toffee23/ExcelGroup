import 'package:course_view/core/constants/images.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: <Widget>[AssetImages.bag2],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AssetImages.notifications,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 60.0,
                vertical: 30.0,
              ),
              child: Text(
                'You don’t have any Notifications at the moment',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
