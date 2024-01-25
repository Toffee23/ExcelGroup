import 'package:course_view/pages/chat_screen/providers.dart';
import 'package:flutter/material.dart';

import '../../core/constants/images.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    required this.message,
  });
  final Message message;

  String get _time {
    final hour = message.sentTime.hour.toString().padLeft(2, '0');
    final minutes = message.sentTime.minute.toString().padLeft(2, '0');
    return '${message.isSender ? 'Sent' : 'Delivered'} $hour:$minutes';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (!message.isSender) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: SizedBox.square(
              dimension: 32,
              child: DecoratedBox(
                decoration: ShapeDecoration(
                  shape: const CircleBorder(),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
        ],
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(8.0),
                child: Text(message.message),
              ),
              const SizedBox(height: 4.0),
              Text(
                _time,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 12),
              ),
            ],
          ),
        ),
        if (message.isSender) ...[
          const SizedBox(width: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Image(image: AssetImages.theme.image, width: 32),
          ),
        ],
      ],
    );
  }
}
