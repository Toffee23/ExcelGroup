import 'package:course_view/core/constants/colors.dart';
import 'package:course_view/core/constants/images.dart';
import 'package:course_view/pages/my_learning/widgets.dart';
import 'package:course_view/pages/quiz_view/quiz_view1.dart';
import 'package:course_view/router/route.dart';
import 'package:flutter/material.dart';

import '../mock_exam/page.dart';

class MyLearningPage extends StatelessWidget {
  const MyLearningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.blueGrey,
            unselectedLabelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            indicatorColor: Theme.of(context).primaryColor,
            tabs: const <Tab>[
              Tab(text: 'Ongoing', height: 40),
              Tab(text: 'Completed', height: 40),
              Tab(text: 'Bookmark', height: 40),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView.builder(
              itemCount: data.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (BuildContext context, int index) {
                final course = data.elementAt(index);
                return TweenAnimationBuilder(
                  duration: const Duration(seconds: 2),
                  tween: Tween<double>(begin: 0, end: course.progress),
                  builder: (BuildContext context, double progress, _) {
                    return OnGoingCard(
                      image: course.image,
                      title: course.title,
                      progress: progress,
                      progressColor: course.progressColor,
                      duration: course.duration,
                      onPressed: () => pushTo(context, const MockExamPage()),
                    );
                  },
                );
              },
            ),
            ListView.builder(
              itemCount: data.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (BuildContext context, int index) {
                final course = data.elementAt(index);
                return TweenAnimationBuilder(
                  duration: const Duration(seconds: 2),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (BuildContext context, double progress, _) {
                    return CompletedCard(
                      image: course.image,
                      title: course.title,
                      progress: progress,
                      progressColor: course.progressColor,
                      duration: course.duration,
                      onPressed: () => pushTo(context, const MockExamPage()),
                    );
                  },
                );
              },
            ),
            ListView.builder(
              itemCount: data.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (BuildContext context, int index) {
                final course = data.elementAt(index);
                return BookmarkCard(
                  image: course.image,
                  title: course.title,
                  progress: course.progress,
                  progressColor: course.progressColor,
                  duration: course.duration,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DummyData {
  final Image image;
  final String title;
  final double progress;
  final Color progressColor;
  final Duration duration;

  DummyData({
    required this.image,
    required this.title,
    required this.progress,
    required this.progressColor,
    required this.duration,
  });
}

final data = [
  DummyData(
    image: AssetImages.course1,
    title: 'Strategic Financial Management',
    progress: .68,
    progressColor: PlaneColors.green,
    duration: const Duration(hours: 2, minutes: 45),
  ),
  DummyData(
    image: AssetImages.course2,
    title: 'Corporate Reporting',
    progress: .52,
    progressColor: PlaneColors.teal,
    duration: const Duration(hours: 2, minutes: 45),
  ),
  DummyData(
    image: AssetImages.course3,
    title: 'ACCA Advanced Financial',
    progress: .36,
    progressColor: PlaneColors.blue,
    duration: const Duration(hours: 2, minutes: 45),
  ),
  DummyData(
    image: AssetImages.course4,
    title: 'ACCA - F4 Corporate and Business Law',
    progress: .81,
    progressColor: PlaneColors.purple,
    duration: const Duration(hours: 2, minutes: 45),
  ),
];
