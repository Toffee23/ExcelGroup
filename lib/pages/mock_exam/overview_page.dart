import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/images.dart';
import 'providers.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({
    Key? key,
    required this.questions,
  }) : super(key: key);
  final List<Questions> questions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mock Questions Tab'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Questions and Answers',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
            const SizedBox(height: 6.0),
            Row(
              children: <Widget>[
                Text(
                  'CIPM Mock Examination',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                const Icon(CupertinoIcons.stopwatch, size: 18),
                Text('134', style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
            const SizedBox(height: 12.0),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (BuildContext context, int index) {
                  final question = questions.elementAt(index);
                  return Container(
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.only(bottom: 8.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadiusDirectional.circular(6.0),
                    ),
                    child: Row(
                      children: <Widget>[
                        if (question.isCorrect == null)
                          AssetImages.level
                        else if (question.isCorrect!)
                          AssetImages.tickCirle
                        else
                          AssetImages.closeCirle,
                        const SizedBox(width: 8.0),
                        Text('Question ${index + 1}'),
                        const Spacer(),
                        const Icon(CupertinoIcons.arrow_right, size: 18),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
