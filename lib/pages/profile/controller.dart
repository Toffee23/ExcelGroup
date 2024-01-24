import 'package:course_view/pages/referral/page.dart';
import 'package:course_view/pages/support/page.dart';
import 'package:course_view/providers.dart';
import 'package:course_view/router/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../achievements/page.dart';
import '../manage_profile/page.dart';
import '../notifications/page.dart';
import '../payments/page.dart';
import '../privacy_policy/page.dart';
import 'provider.dart';

mixin ProfileController on Widget {
  void onAchievement(BuildContext context) {
    pushTo(context, const AchievementsPage());
  }

  void onManageProfile(BuildContext context) {
    pushTo(context, const ManageProfilePage());
  }

  void onNotification(BuildContext context) {
    pushTo(context, const NotificationPage());
  }

  void onPayments(BuildContext context) {
    pushTo(context, const PaymentsPage());
  }

  void onRefer(BuildContext context) {
    pushTo(context, const ReferralPage());
  }

  void onPrivacyPolicy(BuildContext context) {
    pushTo(context, const PrivacyPolicyPage());
  }

  void onSupport(BuildContext context) {
    pushTo(context, const SupportPage());
  }

  void onToggleViewMode(BuildContext context, WidgetRef ref) {
    ref.read(themeModeProvider.notifier).update((state) {
      return state.name == 'dark' ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void onLogout(BuildContext context) {
    // pushTo(context, const Placeholder());
  }
}
