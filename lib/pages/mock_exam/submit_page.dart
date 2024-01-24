import 'package:course_view/pages/mock_exam/overview_page.dart';
import 'package:course_view/pages/mock_exam/statistics_page.dart';
import 'package:course_view/router/route.dart';
import 'package:course_view/widgets/button.dart';
import 'package:flutter/material.dart';

import '../../core/constants/images.dart';
import 'providers.dart';
import 'widgets.dart';

class SubmitPage extends StatelessWidget {
  const SubmitPage({
    Key? key,
    required this.questions,
  }) : super(key: key);
  final List<Questions> questions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 40.0),
            Center(child: AssetImages.confetti),
            const SizedBox(height: 15.0),
            Text(
              'Metrics',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 6.0),
            ResultTabView(
              questions: questions
            ),
            const SizedBox(height: 20.0),
            Text(
              'Evaluation',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadiusDirectional.circular(8.0),
              ),
              child: Text(
                'Your performance at the end of this mock exam  is okay. '
                'We recommend you to watch the course videos or rather '
                'have a personalized tutor to focus on key topics and '
                'attempt again. We know you can do a lot better. Oshee!',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: 30.0),
            CustomElevatedButton(
              text: 'Overview test',
              onPressed: () =>
                  pushTo(context, StatisticsPage(questions: questions)),
            ),
          ],
        ),
      ),
    );
  }
}