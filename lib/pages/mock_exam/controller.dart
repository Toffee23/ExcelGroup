import 'package:course_view/pages/mock_exam/providers.dart';
import 'package:course_view/pages/mock_exam/submit_page.dart';
import 'package:course_view/router/route.dart';
import 'package:course_view/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dialogs.dart';

mixin MockExamController on Widget {
  void onNavigate(
    WidgetRef ref,
    PageController controller,
    bool forward,
  ) {
    final currentIndex = ref.watch(currentIndexProvider);
    final newIndex = currentIndex + (forward ? 1 : -1);
    controller.animateToPage(
      newIndex,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  void onSelect(
    BuildContext context,
    WidgetRef ref,
    int index,
    String option,
  ) {
    if (!ref.read(quizTimerProvider).isRunning &&
        !ref.read(quizTimerProvider).isTimedOut) {
      showSnackbar(
        context: context,
        title: 'Please resume the to continue attempt',
        type: SnackbarType.warning,
      );
      return;
    }

    if (!ref.read(quizTimerProvider).isRunning) {
      showSnackbar(
        context: context,
        title: 'Attempt completed',
        type: SnackbarType.warning,
      );
      return;
    }

    if (ref.read(questionsProvider)[index].selection == null) {
      ref.read(questionsProvider.notifier).select(index, option);
      return;
    }
    showSnackbar(
      context: context,
      title: 'Question already attempted',
      subtitle: 'Press Next to move to the next question',
      type: SnackbarType.warning,
    );
  }

  void onStop(
    BuildContext context,
    QuizTimer quizTimer,
    List<Questions> questions,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StopPauseDialog(
          onYes: () {
            quizTimer.stop();
            pop(context);
            pushTo(context, SubmitPage(questions: questions));
          },
          title: 'Do you want to end this?',
          subtitle: 'This means you have ended the completion of the test.',
        );
      },
    );
  }

  void onPauseResume(
    BuildContext context,
    TimerModel quizTimer,
    QuizTimer quizTimer1,
  ) {
    if (!quizTimer.isRunning) {
      quizTimer1.resume();
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StopPauseDialog(
          onYes: () {
            quizTimer1.pause();
            pop(context);
          },
          title: 'Do you want to pause this?',
          subtitle: 'You can always resume the exam from previous test.',
        );
      },
    );
  }

  void onTimeout(BuildContext context, WidgetRef ref) {
    final questions = ref.read(questionsProvider);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TimeoutDialog(onSubmit: () {
          pop(context);
          _onSubmit(context, questions);
        });
      },
    );
  }

  void onSubmit(
    BuildContext context,
    bool isRunning,
    List<Questions> questions,
  ) {
    if (isRunning) {
      showSnackbar(
        context: context,
        title: 'Exam is ongoing',
        subtitle: 'Please stop the ongoing exam before attempting to submit.',
        type: SnackbarType.warning,
      );
      return;
    }
    _onSubmit(context, questions);
  }

  void _onSubmit(BuildContext context, List<Questions> questions) =>
      pushTo(context, SubmitPage(questions: questions));
}
