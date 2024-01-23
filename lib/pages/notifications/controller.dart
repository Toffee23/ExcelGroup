import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';

mixin NotificationController on Widget {
  void onToggle(WidgetRef ref, bool value, String option) {
    ref.read(notificationsProvider.notifier).update(
          vibrate: option == 'vibrate' ? value : null,
          sound: option == 'sound' ? value : null,
          payments: option == 'payments' ? value : null,
          generalNotifications: option == 'generalNotifications' ? value : null,
          appUpdates: option == 'appUpdates' ? value : null,
          challenges: option == 'challenges' ? value : null,
          learningReminder: option == 'learningReminder' ? value : null,
        );
  }
}
