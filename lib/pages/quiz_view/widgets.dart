import 'package:flutter/material.dart';

import '../../core/constants/images.dart';

class OpponentCard extends StatelessWidget {
  const OpponentCard({
    Key? key,
    required this.title,
    required this.body,
    this.hint,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final String body;
  final String? hint;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      child: MaterialButton(
        onPressed: onPressed,
        color: isSelected
            ? Theme.of(context).primaryColor.withOpacity(.2)
            : Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 15.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: BorderSide(
            width: 3,
            color: isSelected
                ? Theme.of(context).primaryColor
                : const Color(0xFFF3F3F1),
          ),
        ),
        child: Row(
          children: <Widget>[
            AssetImages.femaleDP,
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color:
                            isSelected ? Theme.of(context).primaryColor : null),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    body,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: isSelected ? const Color(0xFFD46C24) : null),
                  ),
                  const SizedBox(height: 8.0),
                  if (hint != null)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Image(
                            image: AssetImages.information.image,
                            width: 16,
                            color: isSelected ? const Color(0xFFD46C24) : null,
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        Expanded(
                          child: Text(
                            hint!,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 12,
                                    color: isSelected
                                        ? const Color(0xFFD46C24)
                                        : null),
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
    );
  }
}

class RowData extends StatelessWidget {
  const RowData({
    Key? key,
    required this.name,
    required this.value,
    this.isFirst = false,
  }) : super(key: key);
  final String name;
  final String value;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(name, style: Theme.of(context).textTheme.bodySmall),
            Text(
              value,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: isFirst ? null : FontWeight.w500,
                    color: isFirst
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).textTheme.labelSmall!.color,
                  ),
            ),
          ],
        ),
        const Divider(height: 4.0),
      ],
    );
  }
}

class _CircleScore extends StatelessWidget {
  const _CircleScore({
    Key? key,
    required this.image,
    required this.score,
  }) : super(key: key);
  final Image image;
  final String score;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 150,
      child: DecoratedBox(
        decoration: const ShapeDecoration(
          shape: CircleBorder(
            side: BorderSide(color: Color(0xFFD6D6D6)),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: DecoratedBox(
            decoration: const ShapeDecoration(
              shape: CircleBorder(
                side: BorderSide(
                  width: 2,
                  color: Color(0xFFBBBBBB),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const SizedBox(height: 8.0),
                Image(
                  image: AssetImages.theme.image,
                  width: 32,
                ),
                Text(
                  'Game Score',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  '0',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({
    Key? key,
    required this.player1Image,
    required this.player2Image,
    required this.player1Score,
    required this.player2Score,
  }) : super(key: key);
  final Image player1Image;
  final Image player2Image;
  final int player1Score;
  final int player2Score;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _CircleScore(
                image: player1Image,
                score: player1Score.toString(),
              ),
              const SizedBox(width: 8.0),
              _CircleScore(
                image: player2Image,
                score: player2Score.toString(),
              ),
            ],
          ),
        ),
        Container(
          width: 140,
          height: 32,
          decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.amber,
                blurRadius: 4,
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Versus',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontWeight: FontWeight.w900),
            ),
          ),
        )
      ],
    );
  }
}

class ScoreTable extends StatelessWidget {
  const ScoreTable({
    Key? key,
    required this.highestRank1,
    required this.highestRank2,
    required this.gameScore1,
    required this.gameScore2,
    required this.highestScore1,
    required this.highestScore2,
  }) : super(key: key);
  final String highestRank1;
  final String highestRank2;
  final String gameScore1;
  final String gameScore2;
  final String highestScore1;
  final String highestScore2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              RowData(name: 'Highest Rank', value: highestRank1, isFirst: true),
              RowData(name: 'Game score', value: gameScore1),
              RowData(name: 'Highest Rank', value: highestScore1),
            ],
          ),
        ),
        const SizedBox(width: 18.0),
        Expanded(
          child: Column(
            children: <Widget>[
              RowData(name: 'Highest Rank', value: highestRank2, isFirst: true),
              RowData(name: 'Game score', value: gameScore2),
              RowData(name: 'Highest Rank', value: highestScore2),
            ],
          ),
        ),
      ],
    );
  }
}

class SidebarPaint extends CustomPainter {
  SidebarPaint({required this.color});
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    const double top = 60.0;
    const double width = 5.0;

    final Rect rect = Rect.fromLTWH(
      size.width - width,
      top,
      width,
      size.height - top,
    );
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
