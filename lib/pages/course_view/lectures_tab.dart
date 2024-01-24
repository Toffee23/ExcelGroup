import 'package:flutter/material.dart';

import '../../widgets/list_tile.dart';
import 'model.dart';

class LecturesTab extends StatelessWidget {
  const LecturesTab({
    Key? key,
    required this.data,
    required this.onPressed,
  }) : super(key: key);
  final CourseModel data;
  final ValueChanged<Module> onPressed;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.lessons.length,
      itemBuilder: (BuildContext context, int index) {
        final lessons = data.lessons.elementAt(index);
        return CourseListTile(
          onPressed: onPressed,
          index: index,
          lessons: lessons,
        );
      },
    );
  }
}
