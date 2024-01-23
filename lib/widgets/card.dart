import 'package:course_view/widgets/place_holders.dart';
import 'package:flutter/material.dart';

import '../pages/course_view/page.dart';
import '../pages/home/model.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key,
    this.isFirst = false,
    required this.course,
    required this.buttonText,
    this.toggleCartButton,
  }) : super(key: key);
  final bool isFirst;
  final CoursesModel course;
  final String buttonText;
  final VoidCallback? toggleCartButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      width: MediaQuery.sizeOf(context).width * .63,
      height: 260,
      margin: EdgeInsets.only(left: isFirst ? 0 : 10),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CourseViewPage(course: course)));
        },
        padding: EdgeInsets.zero,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ImageLoader(
                imageUrl: course.thumbnail,
                fit: BoxFit.cover,
                decoration:
                    const BoxDecoration(borderRadius: BorderRadius.zero),
              ),
            ),
            const SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.language_rounded,
                    color: Colors.red.shade700,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'English subtitle',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                course.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(height: 1.2),
              ),
            ),
            const Spacer(),
            Row(
              children: <Widget>[
                TextButton(
                  onPressed: toggleCartButton,
                  style: ButtonStyle(
                    minimumSize: const MaterialStatePropertyAll(Size.zero),
                    foregroundColor: MaterialStatePropertyAll(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                  child: Text(buttonText),
                ),
                const Spacer(),
                Icon(
                  Icons.star,
                  color: Theme.of(context).primaryColor,
                ),
                const Text('4.1'),
                const SizedBox(width: 5.0)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RowListCard extends StatelessWidget {
  const RowListCard({
    Key? key,
    required this.children,
  }) : super(key: key);
  final List<ProgramButton> children;

  List<List<ProgramButton>> get pairedChildren {
    List<List<ProgramButton>> result = [];

    for (int i = 0; i < (children.length / 2).ceil(); i++) {
      int start = i * 2;
      int end = (i + 1) * 2;
      end = end > children.length ? children.length : end;
      result.add(children.sublist(start, end));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: pairedChildren.map(
        (buttons) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: buttons.first,
                ),
                const SizedBox(width: 8.0),
                if (buttons.length > 1)
                  Expanded(
                    child: buttons.last,
                  )
                else
                  const Expanded(
                    child: SizedBox(),
                  ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}

class ProgramButton extends StatelessWidget {
  const ProgramButton({
    Key? key,
    required this.program,
    required this.image,
    this.onPressed,
  }) : super(key: key);
  final String program;
  final Image image;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(4.0),
      child: Image(
        image: image.image,
        fit: BoxFit.fill,
      ),
    );
  }
}
