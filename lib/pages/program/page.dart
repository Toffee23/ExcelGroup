import 'package:course_view/core/constants/images.dart';
import 'package:course_view/widgets/card.dart';
import 'package:course_view/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../router/route.dart';
import '../program_courses/page.dart';

class ProgramPage extends StatelessWidget {
  const ProgramPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: CustomTextField(
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: Colors.grey.shade600,
                    ),
                    hintText: 'Find in categories',
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Text(
                            'Search',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.zero,
                  ),
                ),
                const SizedBox(width: 10.0),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                  padding: const EdgeInsets.all(12.0),
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    side: const MaterialStatePropertyAll(
                      BorderSide(
                        color: Color(0xFFD6D6D6),
                        width: 1.2,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                AssetImages.information,
                const SizedBox(width: 8.0),
                Text(
                  'Simply tap on the category you need',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            RowListCard(
              children: <ProgramButton>[
                ProgramButton(
                  program: 'ICAN',
                  image: AssetImages.exp1,
                  onPressed: () =>
                      pushTo(context, const ProgramCourses(program: 'ICAN')),
                ),
                ProgramButton(
                  program: 'ACCA',
                  image: AssetImages.exp2,
                  onPressed: () =>
                      pushTo(context, const ProgramCourses(program: 'ACCA')),
                ),
                ProgramButton(
                  program: 'CITN',
                  image: AssetImages.exp3,
                  onPressed: () =>
                      pushTo(context, const ProgramCourses(program: 'CITN')),
                ),
                ProgramButton(
                  program: 'CIMA',
                  image: AssetImages.exp4,
                  onPressed: () =>
                      pushTo(context, const ProgramCourses(program: 'CIMA')),
                ),
                ProgramButton(
                  program: 'CIS',
                  image: AssetImages.exp5,
                  onPressed: () =>
                      pushTo(context, const ProgramCourses(program: 'CIS')),
                ),
                ProgramButton(
                  program: 'AMAN',
                  image: AssetImages.exp6,
                  onPressed: () =>
                      pushTo(context, const ProgramCourses(program: 'AMAN')),
                ),
                ProgramButton(
                  program: 'CIBN',
                  image: AssetImages.exp7,
                  onPressed: () =>
                      pushTo(context, const ProgramCourses(program: 'CIBN')),
                ),
                ProgramButton(
                  program: 'CFA',
                  image: AssetImages.exp8,
                  onPressed: () =>
                      pushTo(context, const ProgramCourses(program: 'CFA')),
                ),
                ProgramButton(
                  program: 'CPA',
                  image: AssetImages.exp9,
                  onPressed: () =>
                      pushTo(context, const ProgramCourses(program: 'CPA')),
                ),
                ProgramButton(
                  program: 'CIPM',
                  image: AssetImages.exp10,
                  onPressed: () =>
                      pushTo(context, const ProgramCourses(program: 'CIPM')),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
