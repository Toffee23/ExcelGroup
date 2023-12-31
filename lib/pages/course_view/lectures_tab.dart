import 'package:flutter/material.dart';

import '../../widgets/list_tile.dart';
import 'model.dart';

class LecturesTab extends StatelessWidget {
  const LecturesTab({
    Key? key,
    required this.data,
  }) : super(key: key);
  final CourseModel data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.lessons.length,
      itemBuilder: (BuildContext context, int index) {
        final module = data.lessons.elementAt(index);
        return CourseListTile(
          onPressed: () {},
          code: 'C${index + 1}',
          title: module.name,
          isUnlocked: !module.subscriptionRequired,
        );
      },
    );
  }
}
