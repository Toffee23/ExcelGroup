import 'package:course_view/core/constants/images.dart';
import 'package:course_view/pages/quiz_view/quiz_view2.dart';
import 'package:course_view/router/route.dart';
import 'package:flutter/material.dart';

import '../../widgets/button.dart';

class QuizView extends StatelessWidget {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                children: <Widget>[
                  AssetImages.leaderBoard,
                  Text(
                    "LEADERBOARD",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),

            Center(child: AssetImages.gameLogo),
            const Spacer(),
            const SizedBox(height: 50.0),

            //payment button
            CustomElevatedButton(
              onPressed: () => pushTo(context, const QuizView2()),
              text: 'Continue',
            ),
          ],
        ),
      ),
    );
  }
}
