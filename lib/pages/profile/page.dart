import 'package:course_view/core/constants/images.dart';
import 'package:course_view/widgets/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller.dart';
import 'provider.dart';

class ProfilePage extends ConsumerWidget with ProfileController {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = ref.watch(darkProvider);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox.square(
                        dimension: 110.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Akinyemi'),
                          Text(
                            'Simisola',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '@simibullet',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      const Expanded(child: Divider()),
                      const SizedBox(width: 8.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          'Quick Review',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                AssetImages.book,
                                const SizedBox(width: 5.0),
                                const Text('0'),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              'Course Completed',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                AssetImages.cup,
                                const SizedBox(width: 5.0),
                                const Text('0'),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              'Achievements',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20.0),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
            SettingsListTile(
              onTap: () => onAchievement(context),
              leading: AssetImages.achievement,
              title: 'Achievements',
              subtitle: 'Tournaments wins, certificates etc',
            ),
            SettingsListTile(
              onTap: () => onManageProfile(context),
              leading: AssetImages.profile,
              title: 'Manage Profile',
              subtitle: 'Change your personal details',
            ),
            SettingsListTile(
              onTap: () => onNotification(context),
              leading: AssetImages.notification2,
              title: 'Notification',
              subtitle: 'See latest notifications',
            ),
            SettingsListTile(
              onTap: () => onPayments(context),
              leading: AssetImages.payment,
              title: 'Payments',
              subtitle: 'An highly secure with payments',
            ),
            SettingsListTile(
              onTap: () => onRefer(context),
              leading: AssetImages.language,
              title: 'Referral',
              subtitle: 'An highly secure with payments',
            ),
            SettingsListTile(
              onTap: () => onPrivacyPolicy(context),
              leading: AssetImages.policy,
              title: 'Privacy Policy',
              subtitle: 'Read our policy regarding the platform',
            ),
            SettingsListTile(
              onTap: () => onSupport(context),
              leading: AssetImages.support,
              title: 'Support',
              subtitle: 'Get all available help from us',
            ),
            SettingsListTile(
              onTap: () => onToggleViewMode(context, ref),
              leading: AssetImages.darkMode,
              title: 'Dark mode view',
              subtitle: 'Switch display view',
              padding: const EdgeInsets.only(left: 15),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(dark ? 'On' : 'Off'),
                  Transform.scale(
                    scale: .7,
                    child: IgnorePointer(
                      child: Switch(
                        value: dark,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (v) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SettingsListTile(
              onTap: () => onLogout(context),
              leading: AssetImages.logout,
              title: 'Logout',
              subtitle: 'Exits. We would want to see you again',
              textColor: const Color(0xFFDA2949),
              hideTrailing: true,
            ),
            const SizedBox(height: 30.0),
            const Text('Version'),
            Text(
              '1.0.0.102',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
