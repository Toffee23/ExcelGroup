import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_view/main.dart';
import 'package:course_view/pages/notification/notification_ui.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String countDays(Timestamp time) {
  Duration difference = DateTime.now().difference(time.toDate());

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} seconds ago';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else if (difference.inDays == 1) {
    return 'yesterday';
  } else {
    return '${difference.inDays} days ago';
  }
}

final UseridProvider = Provider<String>((ref) {
  return '659e445d3d4c93ea3319a12d';
});

// push notification to server
class PushNotification {
  // final String url;

  // PushNotification(this.url);

  Future<void> push(
      {required String title,
      required String body,
      required String notif_type,
      String? token,
      String? topic}) async {
    try {
      final data = {
        'title': title,
        'body': body,
        'notif_type': notif_type,
        'token': token,
        'topic': topic
      };
      final res = await http.post(
        Uri.parse(
            'https://notification-service-gdw5iipadq-uc.a.run.app/push-notification/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      print(res.body);
    } catch (e) {
      print('$e');
    }
  }
}

//push notification code

Future<void> handleBackgroundMessage(RemoteMessage message) async {}

class FirebaseFCM {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: 'This channel is used for very important notifications',
      importance: Importance.defaultImportance);

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    // if (message == null) return;

    navigatorKey.currentState?.pushNamed(notificationUi.route);
  }

  Future<void> initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _localNotifications.initialize(settings,
        onDidReceiveNotificationResponse: (payload) {
      const message = null;
      handleMessage(message);
    });

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(androidChannel);
  }

  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;

      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
                androidChannel.id, androidChannel.name,
                channelDescription: androidChannel.description,
                icon: '@drawable/ic_launcher')),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    initPushNotifications();
    initLocalNotifications();
  }
}
