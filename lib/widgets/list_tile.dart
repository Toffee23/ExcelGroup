import 'package:course_view/core/constants/images.dart';
import 'package:flutter/material.dart';

import '../pages/course_view/model.dart';

class CourseListTile extends StatefulWidget {
  const CourseListTile({
    Key? key,
    required this.lessons,
    required this.index,
    this.onPressed,
  }) : super(key: key);
  final Lessons lessons;
  final int index;
  final ValueChanged<Module>? onPressed;

  @override
  State<CourseListTile> createState() => _CourseListTileState();
}

class _CourseListTileState extends State<CourseListTile> {
  int selected = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 10.0),
        childrenPadding: const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 10.0),
        backgroundColor: const Color(0xFFF0F0F0),
        collapsedBackgroundColor: const Color(0xFFF0F0F0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        title: Row(
          children: <Widget>[
            if (!widget.lessons.subscriptionRequired)
              AssetImages.checkmark
            else
              AssetImages.padlock,
            const SizedBox(width: 6.0),
            Text(
              'C${widget.index + 1}:',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blueGrey.shade600,
              ),
            ),
            const SizedBox(width: 5.0),
            Expanded(
              child: Text(
                widget.lessons.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blueGrey.shade600,
                ),
              ),
            ),
          ],
        ),
        key: Key(widget.index.toString()),
        initiallyExpanded: widget.index == selected,
        onExpansionChanged: ((newState) {
          if (newState) {
            setState(() {
              const Duration(seconds: 20000);
              selected = widget.index;
            });
          } else {
            setState(() {
              selected = -1;
            });
          }
        }),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.lessons.modules.asMap().entries.map((e) {
              return MaterialButton(
                onPressed: () => widget.onPressed?.call(e.value),
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                textColor: Colors.blueGrey,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${e.key + 1}:',
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  e.value.name,
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  'Video - ${e.value.duration.toString()}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    const Icon(Icons.play_circle_fill_rounded)
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class QuestionListTile extends StatelessWidget {
  const QuestionListTile({
    Key? key,
    required this.question,
    this.onPressed,
  }) : super(key: key);
  final String question;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: MaterialButton(
        onPressed: onPressed,
        elevation: 0,
        color: const Color(0xFFF2F2F2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        textColor: Colors.blueGrey.shade400,
        child: Row(
          children: <Widget>[
            const Icon(Icons.chevron_right),
            const SizedBox(width: 4.0),
            Text(
              question,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    this.leading,
    this.trailing,
    this.textColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 15.0),
    this.onTap,
    this.isComingSoon = false,
    this.hideTrailing = false,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Color? textColor;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final bool isComingSoon;
  final bool hideTrailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 18.0,
      minVerticalPadding: 0.0,
      contentPadding: padding,
      visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
      leading: leading,
      title: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          if (isComingSoon) ...[
            const SizedBox(width: 8.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE6D5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'coming soon',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ],
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12.0,
          color: textColor ?? Colors.grey.shade600,
        ),
      ),
      trailing: hideTrailing ? null : trailing ?? AssetImages.arrowRight,
    );
  }
}
