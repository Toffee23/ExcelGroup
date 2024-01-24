import 'package:course_view/core/constants/images.dart';
import 'package:flutter/material.dart';

import '../../router/route.dart';
import '../../widgets/button.dart';
import 'quiz_view5.dart';
import 'widgets.dart';

class QuizView4 extends StatelessWidget {
  const QuizView4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Adegoke",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        "Simisola",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.black,
                    height: MediaQuery.of(context).size.height / 20,
                    width: MediaQuery.of(context).size.width / 250,
                  ),
                  Column(
                    children: [
                      Text(
                        "Questions",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600),
                      ),
                      const Text("24",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    ],
                  ),
                  Container(
                    color: Colors.black,
                    height: MediaQuery.of(context).size.height / 20,
                    width: MediaQuery.of(context).size.width / 250,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ezekiel",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600)),
                      Text("Tomisayu",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50.0),
            Expanded(
              child: Center(
                child: Column(
                  children: <Widget>[
                    ScoreBoard(
                      player1Image: AssetImages.theme,
                      player2Image: AssetImages.theme,
                      player1Score: 0,
                      player2Score: 0,
                    ),
                    const SizedBox(height: 50.0),
                    const ScoreTable(
                      highestRank1: '#4',
                      highestRank2: '#19',
                      gameScore1: '24',
                      gameScore2: '17',
                      highestScore1: '9,982',
                      highestScore2: '3,391',
                    ),
                  ],
                ),
              ),
            ),
            CustomElevatedButton(
              onPressed: () => pushTo(context, const QuizView5()),
              text: 'STATE GAME',
            ),
          ],
        ),
      ),
    );
  }
}
