import 'package:flutter/material.dart';

import 'widgets.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Achievements',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Setup your profile for better experience. '
                  'You can only do this once in a month.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: <Widget>[
                  ...dummyList
                      .map((data) => AchievementsExpansionTile(data: data)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final dummyList = [
  [
    "Completed the ICAN course for beginners and wish to congratulate you on this achievements",
    "Completed the ICAN course for beginners and wish to congratulate you on this achievements",
    "Completed the ICAN course for beginners and wish tot congratulate you on this achievements",
    "Completed the ICAN course for beginners and wish tot congratulate you on this achievements",
  ],
  [
    "Completed the ICAN course for beginners and wish to congratulate you on this achievements",
    "Completed the ICAN course for beginners and wish tot congratulate you on this achievements",
  ]
];
