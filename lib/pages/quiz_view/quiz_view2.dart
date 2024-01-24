import 'package:course_view/core/constants/images.dart';
import 'package:course_view/pages/quiz_view/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../router/route/app_routes.dart';
import '../../widgets/button.dart';
import 'providers.dart';
import 'quiz_view3.dart';

class QuizView2 extends ConsumerWidget {
  const QuizView2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final opponentIsBot = ref.watch(opponentTypeProvider);

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
            const Spacer(),
            OpponentCard(
              title: 'Play with Zaraline (bot)',
              body: 'Quiz with a bot real-time and '
                  'get scored to beat the highest scores',
              hint: 'This is not available at the moment as we '
                  'are currently fixing it. We will be back shortly',
              isSelected: opponentIsBot == 'bot',
              onPressed: () => ref
                  .read(opponentTypeProvider.notifier)
                  .update((state) => 'bot'),
            ),
            OpponentCard(
              title: 'Play with someone on the app',
              body: 'Quiz with a someone real-time and '
                  'get scored to beat the highest scores',
              isSelected: opponentIsBot == 'real',
              onPressed: () => ref
                  .read(opponentTypeProvider.notifier)
                  .update((state) => 'real'),
            ),
            const SizedBox(height: 30.0),
            CustomElevatedButton(
              onPressed: opponentIsBot.isEmpty
                  ? null
                  : () => pushTo(context, const QuizView3()),
              text: 'Continue',
            ),
          ],
        ),
      ),
    );
  }
}
