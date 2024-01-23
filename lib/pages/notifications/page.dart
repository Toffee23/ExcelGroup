import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';
import 'widgets.dart';
import 'controller.dart';

class NotificationPage extends ConsumerWidget with NotificationController {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
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
                  'Notifications',
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
              child: Column(
                children: <Widget>[
                  NotificationListTile(
                    onChanged: (value) => onToggle(ref, value, 'vibrate'),
                    value: notifications?.vibrate,
                    title: 'vibrate',
                    subtitle: 'Allow vibration with no sounds on notifying you',
                  ),
                  NotificationListTile(
                    onChanged: (value) => onToggle(ref, value, 'sound'),
                    value: notifications?.sound,
                    title: 'Sound',
                    subtitle: 'Allow vibration with no sounds on notifying you',
                  ),
                  NotificationListTile(
                    onChanged: (value) => onToggle(ref, value, 'payments'),
                    value: notifications?.payments,
                    title: 'Payments',
                    subtitle: 'Allow vibration with no sounds on notifying you',
                  ),
                  NotificationListTile(
                    onChanged: (value) =>
                        onToggle(ref, value, 'generalNotifications'),
                    value: notifications?.generalNotifications,
                    title: 'General Notifications',
                    subtitle: 'Allow vibration with no sounds on notifying you',
                  ),
                  NotificationListTile(
                    onChanged: (value) => onToggle(ref, value, 'appUpdates'),
                    value: notifications?.appUpdates,
                    title: 'App Updates',
                    subtitle: 'Allow vibration with no sounds on notifying you',
                  ),
                  NotificationListTile(
                    onChanged: (value) => onToggle(ref, value, 'challenges'),
                    value: notifications?.challenges,
                    title: 'Challenges',
                    subtitle: 'Allow vibration with no sounds on notifying you',
                  ),
                  NotificationListTile(
                    onChanged: (value) =>
                        onToggle(ref, value, 'learningReminder'),
                    value: notifications?.learningReminder,
                    title: 'Learning Reminder',
                    subtitle: 'Allow vibration with no sounds on notifying you',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
