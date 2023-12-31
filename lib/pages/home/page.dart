import 'package:course_view/pages/home/provider.dart';
import 'package:course_view/widgets/place_holders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: ref.watch(coursesProvider).when(
        data: (courses) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      color: Colors.black.withOpacity(.3),
                      child: Column(
                        children: <Widget>[
                          const Icon(
                            Icons.star_border_purple500,
                            color: Colors.white70,
                          ),
                          const Text(
                            'Join the leaderboard',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Participate on the ongoing easy and smooth game with others. Lead!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 12.0),
                          ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  )),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.black),
                                  foregroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.white)),
                              child: const Text('Participate now'))
                        ],
                      )),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Similar Courses',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                        child: const Text('See more'),
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: (courses ?? []).map((course) {
                      return HomeCard(
                        isFirst: courses!.first == course,
                        course: course,
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 40.0),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'You might like',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade700,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            foregroundColor: MaterialStatePropertyAll(
                              Theme.of(context).primaryColor,
                            ),
                          ),
                          child: const Text('See more'))
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: (courses ?? []).reversed.map((course) {
                      return HomeCard(
                        isFirst: courses!.first == course,
                        course: course,
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          );
        },
        error: (_, __) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('An error as occurred, please try again'),
                const SizedBox(height: 15.0),
                ElevatedButton(
                  onPressed: () => ref.refresh(coursesProvider),
                  child: const Text('Retry'),
                )
              ],
            ),
          );
        },
        loading: () {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                const DataLoader(height: 140),
                const SizedBox(height: 12.0),
                const Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          DataLoader(
                            height: 30,
                            width: double.infinity,
                            margin: EdgeInsets.only(
                              bottom: 12.0,
                              right: 10.0,
                            ),
                          ),
                          DataLoader(
                            height: 15,
                            width: double.infinity,
                            margin: EdgeInsets.only(
                              right: 60.0,
                              bottom: 5.0,
                            ),
                          ),
                          DataLoader(
                            height: 10,
                            width: double.infinity,
                            margin: EdgeInsets.only(
                              right: 90.0,
                              bottom: 10.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataLoader(
                      width: 70.0,
                      height: 70.0,
                      radius: 35.0,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, __) {
                      return ListTile(
                        textColor: Colors.grey.shade100,
                        contentPadding: EdgeInsets.zero,
                        leading: const DataLoader(
                          width: 40.0,
                          height: 40.0,
                          radius: 20.0,
                        ),
                        title: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            DataLoader(
                              height: 20.0,
                              radius: 3.0,
                              margin: EdgeInsets.only(bottom: 10.0),
                            ),
                            DataLoader(
                              height: 10.0,
                              width: 150,
                              radius: 20.0,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                const DataLoader(
                  width: double.infinity,
                  height: 48.0,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
