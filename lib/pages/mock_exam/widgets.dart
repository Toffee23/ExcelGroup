import 'package:flutter/material.dart';

import '../../core/constants/images.dart';
import 'providers.dart';

class ResultTabView extends StatelessWidget {
  const ResultTabView({
    Key? key,
    required this.questions,
  }) : super(key: key);
  final List<Questions> questions;

  int get correct =>
      questions.where((element) => element.isCorrect == true).length;

  int get incorrect =>
      questions.where((element) => element.isCorrect == false).length;

  int get omitted =>
      questions.where((element) => element.isCorrect == null).length;

  Widget _tab(BuildContext context, String title, int value, Image image) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            image,
            const SizedBox(width: 8.0),
            Text(
              value.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _tab(context, 'Correct', correct, AssetImages.checkCircleOutline),
        _tab(context, 'Incorrect', incorrect, AssetImages.closeCircleOutline),
        _tab(context, 'Omitted', omitted, AssetImages.nextCircleOutline),
      ],
    );
  }
}

class ResultTabView2 extends StatelessWidget {
  const ResultTabView2({
    Key? key,
    required this.questions,
  }) : super(key: key);
  final List<Questions> questions;

  int get correct =>
      questions.where((element) => element.isCorrect == true).length;

  int get incorrect =>
      questions.where((element) => element.isCorrect == false).length;

  int get omitted =>
      questions.where((element) => element.isCorrect == null).length;

  Widget _tab(BuildContext context, String title, int value, Image image) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            image,
            const SizedBox(width: 8.0),
            Text(
              value.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _tab(context, 'Accuracy View', correct, AssetImages.checkCircleOutline),
        _tab(context, 'Avg. Question', incorrect,
            AssetImages.closeCircleOutline),
        _tab(context, 'Avg. Speed', omitted, AssetImages.nextCircleOutline),
      ],
    );
  }
}
