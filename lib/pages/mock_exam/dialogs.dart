import 'package:flutter/material.dart';

import '../../router/route.dart';

class QuestionDialog extends StatelessWidget {
  const QuestionDialog({
    Key? key,
    required this.question,
  }) : super(key: key);
  final String question;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(12.0),
      ),
      scrollable: true,
      content: Text(question),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () => pop(context),
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Theme.of(context).primaryColor,
            ),
            foregroundColor: const MaterialStatePropertyAll(Colors.white),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(8.0),
              ),
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: const MaterialStatePropertyAll(Size(0, 36)),
          ),
          child: const Text('Dismiss'),
        ),
      ],
      actionsPadding: const EdgeInsets.only(top: 10, bottom: 10, right: 24),
    );
  }
}

class StopPauseDialog extends StatelessWidget {
  const StopPauseDialog({
    Key? key,
    this.onNo,
    this.onYes,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final VoidCallback? onNo;
  final VoidCallback? onYes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(12.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 8.0),
          Text(title),
          const SizedBox(height: 20.0),
          Text(subtitle),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            pop(context);
            onNo?.call();
          },
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(
              Theme.of(context).primaryColor,
            ),
          ),
          child: const Text('No'),
        ),
        ElevatedButton(
          onPressed: onYes,
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Theme.of(context).primaryColor,
            ),
            foregroundColor: const MaterialStatePropertyAll(Colors.white),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(8.0),
              ),
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: const MaterialStatePropertyAll(Size(0, 36)),
          ),
          child: const Text('Yes'),
        ),
      ],
      actionsPadding: const EdgeInsets.only(bottom: 10, right: 24),
    );
  }
}

class TimeoutDialog extends StatelessWidget {
  const TimeoutDialog({
    Key? key,
    this.onSubmit,
  }) : super(key: key);
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Timeout'),
      content: const Text(
        'You ran out of time and couldn\'t complete the Exam. '
        'Click on submit to view your scores and statistics.',
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: onSubmit,
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Theme.of(context).primaryColor,
            ),
            foregroundColor: const MaterialStatePropertyAll(Colors.white),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(8.0),
              ),
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: const MaterialStatePropertyAll(Size(0, 36)),
          ),
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
