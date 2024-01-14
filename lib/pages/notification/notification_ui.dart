import 'package:course_view/pages/notification/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

class notificationUi extends StatelessWidget {
  notificationUi({super.key});

  Future<dynamic> _getNotifications() async {
    var _totalNotifications = 1;

    return _totalNotifications;
  }

  bool checkCount(notification) {
    if (notification == 0) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 23),
            child: Icon(
              Icons.shopping_bag,
              shadows: [
                Shadow(
                  color: Colors.grey[400]!,
                  blurRadius: 3,
                  offset: const Offset(0, 2.5),
                ),
              ],
              size: 33,
            ),
          ),
        ],
      ),
      body: checkCount(_getNotifications())
          ? _yesNotification()
          : _noNotification(),
    );
  }
}

class _noNotification extends StatelessWidget {
  const _noNotification({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Onboarding-bro.png'),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Text(
                'You don’t have any Notifications at the moment',
                textAlign: TextAlign.center,
              ),
            )
          ]),
    );
  }
}

// class _yesNotification extends StatelessWidget {
//   const _yesNotification({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [Text('2')]);
//   }
// }

class _yesNotification extends StatefulWidget {
  const _yesNotification({super.key});

  @override
  State<_yesNotification> createState() => __yesNotificationState();
}

class __yesNotificationState extends State<_yesNotification>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
          controller: _tabController,
          unselectedLabelColor: Color(0xff999999),
          labelColor: Color(0xffFF822B),
          indicatorColor: Color(0xffFF822B),
          tabs: const <Widget>[
            Tab(
              text: "Activities",
            ),
            Tab(
              text: "My Account",
            ),
            Tab(
              text: "What's New",
            ),
          ],
        ),
        Flexible(
          child: TabBarView(controller: _tabController, children: [
            Container(
              child: Activities_Widget(),
            ),
            Center(
              child: Account_Widget(),
            ),
            Center(
              child: News_Widget(),
            )
          ]),
        )
      ],
    );
  }
}

class Activities_Widget extends ConsumerWidget {
  Activities_Widget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userid = ref.watch(UseridProvider);
    var notificationQuery = FirebaseFirestore.instance
        .collection('notification')
        .doc(userid)
        .collection('notif')
        .where('Type', isEqualTo: 'activities');

    return FirestoreListView(
        query: notificationQuery,
        itemBuilder: (context, snapshot) {
          var notification = snapshot.data();

          return Container(
            padding: EdgeInsets.only(left: 28, right: 28, top: 30, bottom: 30),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/excel-notification.png',
                  width: 48.0,
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${notification["Title"]}'),
                        const SizedBox(
                          width: 150,
                        ),
                        Text(countDays(notification['Date']))
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('${notification["Body"]}'),
                  ],
                )
              ],
            ),
          );
        });
  }
}

class Account_Widget extends ConsumerWidget {
  Account_Widget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userid = ref.watch(UseridProvider);
    var notificationQuery = FirebaseFirestore.instance
        .collection('notification')
        .doc(userid)
        .collection('notif')
        .where('Type', isEqualTo: 'account');

    return FirestoreListView(
        query: notificationQuery,
        itemBuilder: (context, snapshot) {
          var notification = snapshot.data();

          return Container(
            padding: EdgeInsets.only(left: 28, right: 28, top: 30, bottom: 30),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/excel-notification.png',
                  width: 48.0,
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${notification["Title"]}'),
                        const SizedBox(
                          width: 150,
                        ),
                        Text(countDays(notification['Date']))
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('${notification["Body"]}'),
                  ],
                )
              ],
            ),
          );
        });
  }
}

class News_Widget extends ConsumerWidget {
  News_Widget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userid = ref.watch(UseridProvider);
    var notificationQuery = FirebaseFirestore.instance
        .collection('notification')
        .doc(userid)
        .collection('notif')
        .where('Type', isEqualTo: 'news');

    return FirestoreListView(
        query: notificationQuery,
        itemBuilder: (context, snapshot) {
          var notification = snapshot.data();

          return Container(
            padding: EdgeInsets.only(left: 28, right: 28, top: 30, bottom: 30),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/excel-notification.png',
                  width: 48.0,
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${notification["Title"]}'),
                        const SizedBox(
                          width: 150,
                        ),
                        Text(countDays(notification['Date']))
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('${notification["Body"]}'),
                  ],
                )
              ],
            ),
          );
        });
  }
}
