import 'package:course_view/router/route.dart';
import 'package:course_view/widgets/button.dart';
import 'package:flutter/material.dart';

import 'main_page.dart';

class InstructionPage extends StatelessWidget {
  const InstructionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'CIPM Mock Examination',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6.0),
            Text(
              'An obligation on both parties to '
              'report any serious personal data '
              'breach to the supervisory authority.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _Tab(count: 45, title: 'Questions'),
                _Tab(count: 60, title: 'Minutes'),
                _Tab(count: 1, title: 'Level'),
              ],
            ),
            Text(
              'Further Instructions',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6.0),
            Expanded(
              child: ListView.builder(
                itemCount: instructions.length,
                itemBuilder: (BuildContext context, int index) {
                  return _Instructions(
                    sn: index + 1,
                    instruction: instructions.elementAt(index),
                  );
                },
              ),
            ),
            CustomElevatedButton(
              text: 'Start Test',
              onPressed: () => pushTo(context, const MainExamPage()),
            )
          ],
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    Key? key,
    required this.count,
    required this.title,
  }) : super(key: key);
  final int count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Column(
        children: <Widget>[
          Text(
            count.toString(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontWeight: FontWeight.w500, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _Instructions extends StatelessWidget {
  const _Instructions({
    Key? key,
    required this.sn,
    required this.instruction,
  }) : super(key: key);
  final int sn;
  final String instruction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox.square(
            dimension: 20,
            child: DecoratedBox(
              decoration: ShapeDecoration(
                color: Theme.of(context).cardColor,
                shape: const CircleBorder(),
              ),
              child: Center(
                child: Text(
                  sn.toString(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 14,
                      ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              instruction,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

final instructions = <String>[
  "You will be expected to answers all questions with allocated time provided.",
  "You can decide to pause the test questions and resume on your-own-time provided you do that before the end of the allocated time.",
  "Questions provided are highly professional and super-awesome to best fit your course level chose.",
  "There are questions you will be provided with that is longer in length and needs you to that on it to get full grasp",
  "There are questions you will be provided with that is longer in length and needs you to that on it to get full grasp",
];
