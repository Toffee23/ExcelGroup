import 'package:flutter/material.dart';

class CourseListTile extends StatelessWidget {
  const CourseListTile({
    Key? key,
    required this.code,
    required this.title,
    this.subtitle,
    required this.isUnlocked,
    this.onPressed,
  }) : super(key: key);
  final String code;
  final String title;
  final String? subtitle;
  final bool isUnlocked;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: MaterialButton(
        onPressed: onPressed,
        elevation: 0,
        color: Colors.grey.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: const EdgeInsets.all(8.0),
        textColor: Colors.blueGrey.shade400,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (isUnlocked)
                    const Icon(Icons.check_circle, color: Colors.green)
                  else
                    Icon(Icons.lock, color: Colors.grey.shade500),
                  const SizedBox(width: 5.0),
                  Text('$code :'),
                  const SizedBox(width: 5.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (!isUnlocked) ...[
                          const SizedBox(height: 2.0),
                          Text(
                            subtitle ?? 'Video - 23:01 min',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4.0),
            const Icon(Icons.chevron_right)
          ],
        ),
      ),
    );
  }
}

class QuestionListTile extends StatelessWidget {
  const QuestionListTile({
    Key? key,
    required this.question,
    this.onPressed,
  }) : super(key: key);
  final String question;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: MaterialButton(
        onPressed: onPressed,
        elevation: 0,
        color: Colors.grey.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        textColor: Colors.blueGrey.shade400,
        child: Row(
          children: <Widget>[
            const Icon(Icons.chevron_right),
            const SizedBox(width: 4.0),
            Text(
              question,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
