import 'package:flutter/material.dart';

import '../../router/route.dart';
import '../../widgets/button.dart';
import 'overview_page.dart';
import 'providers.dart';
import 'widgets.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({
    Key? key,
    required this.questions,
  }) : super(key: key);
  final List<Questions> questions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Statistics'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'CIPM Mock Examination',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              'An obligation on both parties to report any serious '
              'personal data breach to the supervisory authority.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 150.0),
            Text(
              'Metrics',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 6.0),
            ResultTabView(questions: questions),
            const SizedBox(height: 30.0),
            CustomElevatedButton(
              text: 'View Mock Solution',
              onPressed: () =>
                  pushTo(context, OverviewPage(questions: questions)),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Statistics',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 6.0),
            ResultTabView2(questions: questions),
            const SizedBox(height: 50.0),
            CustomElevatedButton(
              text: 'View Mock Statistics',
              onPressed: () =>
                  pushTo(context, OverviewPage(questions: questions)),
            ),
          ],
        ),
      ),
    );
  }
}
