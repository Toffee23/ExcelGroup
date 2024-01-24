import 'dart:math';

import 'package:course_view/core/constants/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller.dart';
import 'dialogs.dart';
import 'providers.dart';

class MainExamPage extends ConsumerStatefulWidget with MockExamController {
  const MainExamPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MainExamPage> createState() => _MainExamPageState();
}

class _MainExamPageState extends ConsumerState<MainExamPage> {
  final PageController _pageController = PageController();
  List<ScrollController> _scrollControllers = [];
  late QuizTimer _quizTimer;
  final duration = const Duration(minutes: 60);

  @override
  void initState() {
    final len = ref.read(questionsProvider).length;
    _scrollControllers = List.generate(len, (index) => ScrollController());
    _quizTimer = QuizTimer(
      ref: ref,
      duration: duration,
      onTimeout: () => widget.onTimeout(context, ref),
    );
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _quizTimer.start();
    });
  }

  @override
  void dispose() {
    _quizTimer.dispose();
    _pageController.dispose();
    for (var c in _scrollControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _showFullQuestion(BuildContext context, String question) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return QuestionDialog(
          question: question,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(currentIndexProvider);
    final questions = ref.watch(questionsProvider);
    final quizTimer = ref.watch(quizTimerProvider);

    final elapsedTime = quizTimer.currentDuration.inSeconds;
    final totalTime = _quizTimer.duration.inSeconds;
    final minute = elapsedTime ~/ 60;
    final second = elapsedTime % 60;
    final progress = (elapsedTime / totalTime).clamp(0.0, 1.0);

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: PageView.builder(
                      itemCount: questions.length,
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) => ref
                          .read(currentIndexProvider.notifier)
                          .update((state) => index),
                      itemBuilder: (BuildContext context, int queIndex) {
                        final question = questions.elementAt(queIndex);
                        final controller =
                            _scrollControllers.elementAt(queIndex);
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: <Widget>[
                              RawScrollbar(
                                controller: controller,
                                thumbVisibility: true,
                                trackVisibility: true,
                                interactive: true,
                                thickness: 8.0,
                                trackBorderColor: Colors.transparent,
                                radius: const Radius.circular(12),
                                trackRadius: const Radius.circular(12),
                                thumbColor: Theme.of(context).primaryColor,
                                trackColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.12),
                                scrollbarOrientation: ScrollbarOrientation.left,
                                child: Container(
                                  height: 150,
                                  margin: const EdgeInsets.only(left: 15.0),
                                  child: MaterialButton(
                                    onPressed: () => _showFullQuestion(
                                        context, question.question),
                                    padding: EdgeInsets.zero,
                                    color: Theme.of(context).cardColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: SingleChildScrollView(
                                      controller: controller,
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        question.question,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: question.options.length,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  itemBuilder:
                                      (BuildContext context, int optIndex) {
                                    final option =
                                        question.options.elementAt(optIndex);
                                    return _OptionButton(
                                      question: question,
                                      option: option,
                                      selection: question.selection,
                                      onPressed: () => widget.onSelect(
                                        context,
                                        ref,
                                        queIndex,
                                        option,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: const Color(0xFFD6D6D6),
                            ),
                          ),
                          child: Text(
                            'Please tap on the question box to get a '
                            'grasp of the entire questions if you '
                            'are bit confused to get the questions.',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 12),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            _ControlButton(
                              image: Image(
                                  image: AssetImages.stop.image, width: 17),
                              text: 'Stop',
                              color: const Color(0xFFDA2949),
                              onPressed: () =>
                                  widget.onStop(context, _quizTimer, questions),
                            ),
                            const SizedBox(width: 5.0),
                            _ControlButton(
                              image: quizTimer.isRunning
                                  ? Image(
                                      image: AssetImages.pause.image, width: 17)
                                  : const Icon(CupertinoIcons.play, size: 17),
                              text: quizTimer.isRunning ? 'Pause' : 'Resume',
                              color: const Color(0xFF1FAF73),
                              onPressed: () => widget.onPauseResume(
                                  context, quizTimer, _quizTimer),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            (currentIndex + 1).toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(height: 1),
                                          ),
                                          Text(
                                            '/${questions.length}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2.0),
                                      Text(
                                        'Questions',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        'ATS 1',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(height: 1, fontSize: 16),
                                      ),
                                      const SizedBox(height: 2.0),
                                      Text(
                                        'Level',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  CustomCircularProgressBar(
                                    unit: 'S',
                                    progress: progress,
                                    progressColor:
                                        Theme.of(context).primaryColor,
                                    backgroundColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              (minute > 1 ? minute : second)
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(fontSize: 14),
                                            ),
                                            Text(
                                              minute > 1 ? 'm' : 's',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(fontSize: 10),
                                            ),
                                          ],
                                        ),
                                        if (minute > 1)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                second.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(
                                                        fontSize: 12,
                                                        height: 1),
                                              ),
                                              Text(
                                                's',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(
                                                        fontSize: 8, height: 1),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              color: Theme.of(context).cardColor,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Text('Keep going Buddy! ✌'),
                      const Spacer(),
                      Image(image: AssetImages.repeat.image, width: 18),
                      const SizedBox(width: 12.0),
                      Image(image: AssetImages.flag.image, width: 18),
                      const SizedBox(width: 12.0),
                      Image(image: AssetImages.infoCircle.image, width: 18),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      _PageNavigationButton(
                        onPressed: currentIndex < 1
                            ? null
                            : !quizTimer.isRunning && !quizTimer.isTimedOut
                                ? null
                                : () => widget.onNavigate(
                                    ref, _pageController, false),
                        iconData: CupertinoIcons.arrow_left,
                        text: 'Previous',
                      ),
                      _PageNavigationButton(
                        onPressed: currentIndex == questions.length - 1
                            ? null
                            : !quizTimer.isRunning && !quizTimer.isTimedOut
                                ? null
                                : () => widget.onNavigate(
                                    ref, _pageController, true),
                        iconData: CupertinoIcons.arrow_right,
                        text: 'Next',
                        arrowInFront: true,
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => widget.onSubmit(
                              context, quizTimer.isRunning, questions),
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).primaryColor,
                            ),
                            foregroundColor: const MaterialStatePropertyAll(
                              Colors.white,
                            ),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          child: const Text('Submit'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    Key? key,
    required this.image,
    required this.text,
    required this.color,
    required this.onPressed,
  }) : super(key: key);
  final Widget image;
  final String text;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0),
        foregroundColor: MaterialStatePropertyAll(Colors.grey.shade100),
        backgroundColor: MaterialStatePropertyAll(color),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(8.0),
          ),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 9.0, vertical: 7.0),
        ),
        textStyle: const MaterialStatePropertyAll(
          TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        minimumSize: const MaterialStatePropertyAll(Size.zero),
      ),
      child: Row(
        children: <Widget>[
          image,
          // Image(image: image.image, width: 17),
          const SizedBox(width: 4.0),
          Text(text),
        ],
      ),
    );
  }
}

class _PageNavigationButton extends StatelessWidget {
  const _PageNavigationButton({
    Key? key,
    this.onPressed,
    required this.iconData,
    required this.text,
    this.arrowInFront = false,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final IconData iconData;
  final String text;
  final bool arrowInFront;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(
          onPressed == null
              ? null
              : Theme.of(context).textTheme.titleMedium!.color,
        ),
        textStyle: const MaterialStatePropertyAll(
          TextStyle(fontSize: 13),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(8.0),
          ),
        ),
        padding: const MaterialStatePropertyAll(EdgeInsets.all(7.0)),
        minimumSize: const MaterialStatePropertyAll(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        children: <Widget>[
          if (!arrowInFront) ...[
            Icon(iconData, size: 20),
            const SizedBox(width: 6.0),
          ],
          Text(text),
          if (arrowInFront) ...[
            const SizedBox(width: 6.0),
            Icon(iconData, size: 20),
          ],
        ],
      ),
    );
  }
}

class _OptionButton extends StatelessWidget {
  const _OptionButton({
    Key? key,
    required this.option,
    required this.selection,
    required this.question,
    required this.onPressed,
  }) : super(key: key);
  final String option;
  final String? selection;
  final Questions question;
  final VoidCallback onPressed;

  Color _getColor(
    BuildContext context, [
    double opacity = 1,
    bool isText = false,
  ]) {
    if (selection == option && selection == question.answer) {
      return const Color(0xFF1FAF73).withOpacity(opacity);
    } else if (selection == option && selection != question.answer) {
      return const Color(0xFFDA2949).withOpacity(opacity);
    } else if (isText) {
      return Theme.of(context).hintColor;
    } else {
      return Theme.of(context).cardColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4.0),
      child: MaterialButton(
        onPressed: onPressed,
        elevation: 0,
        highlightElevation: 0,
        padding: const EdgeInsets.all(12.0),
        color: _getColor(context, .12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: _getColor(context)),
        ),
        child: Center(
          child: Text(
            option,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _getColor(context, 1, true),
                ),
            // style: TextStyle(
            //   fontSize: 12,
            //   fontWeight: FontWeight.w500,
            //   color: question.selection == null ? null : _getColor(context),
            // ),
          ),
        ),
      ),
    );
  }
}

class CustomCircularProgressBar extends StatelessWidget {
  const CustomCircularProgressBar({
    Key? key,
    required this.unit,
    required this.progress,
    this.progressColor,
    this.backgroundColor,
    this.dimension = 50,
    this.strokeWidth = 4,
    this.child,
  }) : super(key: key);
  final String unit;
  final double progress;
  final Color? backgroundColor;
  final Color? progressColor;
  final double? dimension;
  final double? strokeWidth;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: CustomPaint(
        painter: Painter(
          progress: progress,
          progressColor: progressColor,
          backgroundColor: backgroundColor,
          strokeWidth: strokeWidth,
        ),
        child: child,
      ),
    );
  }
}

class Painter extends CustomPainter {
  Painter({
    super.repaint,
    required this.progress,
    this.backgroundColor,
    this.progressColor,
    this.strokeWidth,
  });
  final double progress;
  final Color? backgroundColor;
  final Color? progressColor;
  final double? strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!
      ..color = backgroundColor ?? const Color(0xFFD6D6D6);

    final Paint progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth ?? 4.0
      ..color = progressColor ?? const Color(0xFF1FAF73);

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    canvas.drawCircle(center, radius, backgroundPaint);

    final Rect rect = Rect.fromCircle(center: center, radius: radius);
    final double sweepAngle = 360 * progress * (pi / 180);
    canvas.drawArc(rect, -90 * (pi / 180), sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
