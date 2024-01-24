import 'package:flutter/material.dart';

import '../../core/constants/images.dart';

class QuizView5 extends StatelessWidget {
  const QuizView5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image(
                      image: AssetImages.theme.image,
                      width: 32,
                    ),
                    const SizedBox(height: 4.0),
                    const Row(
                      children: <Widget>[
                        Icon(Icons.control_point, size: 18),
                        SizedBox(width: 4.0),
                        Text('0 Pts'),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Container(
                      width: 55,
                      height: 10,
                      color: Colors.purple,
                    ),
                  ],
                ),
                SizedBox.square(
                  dimension: 70,
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                      shape: CircleBorder(
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '00:25',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Image(
                      image: AssetImages.theme.image,
                      width: 32,
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: <Widget>[
                        AssetImages.coin,
                        const SizedBox(width: 4.0),
                        const Text('0 Pts'),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Container(
                      width: 55,
                      height: 10,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50.0),
            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'What are the different types of '
                'costs in management accounting?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 15.0,
                ),
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        'Indirect costs',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 15),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        'Variable costs',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 15),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        'Semi-variable costs',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 15),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        'Performance evaluation',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
