import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationsProvider =
    StateNotifierProvider<UserNotifier, NotificationModel?>((ref) {
  return UserNotifier(ref);
});

class UserNotifier extends StateNotifier<NotificationModel?> {
  UserNotifier(
    this.ref, {
    this.user,
  }) : super(user) {
    initialize();
  }
  final Ref ref;
  final NotificationModel? user;

  void initialize() {
    state = NotificationModel(
      vibrate: false,
      sound: false,
      payments: false,
      generalNotifications: false,
      appUpdates: false,
      challenges: false,
      learningReminder: false,
    );
  }

  void update({
    bool? vibrate,
    bool? sound,
    bool? payments,
    bool? generalNotifications,
    bool? appUpdates,
    bool? challenges,
    bool? learningReminder,
  }) {
    state = state?.copyWith(
      vibrate: vibrate,
      sound: sound,
      payments: payments,
      generalNotifications: generalNotifications,
      appUpdates: appUpdates,
      challenges: challenges,
      learningReminder: learningReminder,
    );
  }
}

class NotificationModel {
  NotificationModel({
    required this.vibrate,
    required this.sound,
    required this.payments,
    required this.generalNotifications,
    required this.appUpdates,
    required this.challenges,
    required this.learningReminder,
  });
  final bool vibrate;
  final bool sound;
  final bool payments;
  final bool generalNotifications;
  final bool appUpdates;
  final bool challenges;
  final bool learningReminder;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      vibrate: json['vibrate'],
      sound: json['sound'],
      payments: json['payments'],
      generalNotifications: json['generalNotifications'],
      appUpdates: json['appUpdates'],
      challenges: json['challenges'],
      learningReminder: json['learningReminder'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vibrate': vibrate,
      'sound': sound,
      'payments': payments,
      'generalNotifications': generalNotifications,
      'appUpdates': appUpdates,
      'challenges': challenges,
      'learningReminder': learningReminder,
    };
  }

  NotificationModel copyWith({
    bool? vibrate,
    bool? sound,
    bool? payments,
    bool? generalNotifications,
    bool? appUpdates,
    bool? challenges,
    bool? learningReminder,
    bool? balanceVisibility,
  }) {
    return NotificationModel(
      vibrate: vibrate ?? this.vibrate,
      sound: sound ?? this.sound,
      payments: payments ?? this.payments,
      generalNotifications: generalNotifications ?? this.generalNotifications,
      appUpdates: appUpdates ?? this.appUpdates,
      challenges: challenges ?? this.challenges,
      learningReminder: learningReminder ?? this.learningReminder,
    );
  }
}
