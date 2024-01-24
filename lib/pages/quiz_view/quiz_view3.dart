import 'package:course_view/core/constants/images.dart';
import 'package:course_view/pages/quiz_view/models.dart';
import 'package:course_view/pages/quiz_view/quiz_view4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../router/route.dart';
import '../../widgets/button.dart';
import 'providers.dart';
import 'widgets.dart';

class QuizView3 extends ConsumerWidget {
  const QuizView3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCourse = ref.watch(selectedCourseProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 72.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AssetImages.gameLogo,
                Column(
                  children: <Widget>[
                    AssetImages.leaderBoard,
                    Text(
                      "LEADERBOARD",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                )
              ],
            ),
            Expanded(
                child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                mainAxisExtent: 210,
              ),
              itemCount: programs.length,
              itemBuilder: (context, index) {
                final program = programs.elementAt(index);
                return MaterialButton(
                  onPressed: () => ref
                      .read(selectedCourseProvider.notifier)
                      .update((state) => program.name),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    color: const Color(0xFFF3F3F1),
                    height: 230,
                    child: CustomPaint(
                      painter: SidebarPaint(color: program.color),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  program.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                Checkbox(
                                  value: selectedCourse == program.name,
                                  activeColor: Theme.of(context).primaryColor,
                                  side: BorderSide(
                                    color: Theme.of(context).hintColor,
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  onChanged: (_) {},
                                ),
                              ],
                            ),
                            const SizedBox(height: 25.0),
                            program.image,
                            const SizedBox(height: 8.0),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  program.title,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '${program.courseLength} courses',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  '${program.levelLength} Levels',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )),
            CustomElevatedButton(
              onPressed: selectedCourse.isEmpty
                  ? null
                  : () => pushTo(context, const QuizView4()),
              text: 'CONTINUE',
            ),
          ],
        ),
      ),
    );
  }
}
