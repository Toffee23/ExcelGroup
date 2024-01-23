import 'package:course_view/pages/home/provider.dart';
import 'package:course_view/pages/my_learning/page.dart';
import 'package:course_view/pages/program/page.dart';
import 'package:course_view/pages/program_courses/page.dart';
import 'package:course_view/router/route.dart';
import 'package:course_view/widgets/place_holders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/images.dart';
import '../../widgets/card.dart';
import '../../widgets/snack_bar.dart';
import '../../widgets/text_field.dart';
import '../notification/page.dart';
import '../search/page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({
    Key? key,
    required this.onCartIconPressed,
  }) : super(key: key);
  final VoidCallback onCartIconPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(coursesProvider).when(
      data: (courses) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                            'Welcome back, Simisola',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          )),
                          const SizedBox(width: 8.0),
                          SizedBox.square(
                            dimension: 60,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: const Color(0xFFF1F1EF),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'You have 12 Notifications and 4 carts items',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: AssetImages.notification,
                            onPressed: () =>
                                pushTo(context, const NotificationPage()),
                            style: const ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          IconButton(
                            icon: AssetImages.bag,
                            onPressed: () => onCartIconPressed(),
                            style: const ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        'What would you want to learn today?',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    CustomTextField(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SearchPage()))
                            .whenComplete(() {
                          FocusManager.instance.primaryFocus?.unfocus();
                        });
                      },
                      prefixIcon: Icon(
                        CupertinoIcons.search,
                        color: Colors.grey.shade600,
                      ),
                      hintText: 'Courses',
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
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    //   child: Container(
                    //       padding: const EdgeInsets.all(10.0),
                    //       color: Colors.black.withOpacity(.3),
                    //       child: Column(
                    //         children: <Widget>[
                    //           const Icon(
                    //             Icons.star_border_purple500,
                    //             color: Colors.white70,
                    //           ),
                    //           const Text(
                    //             'Join the leaderboard',
                    //             style: TextStyle(
                    //               fontSize: 16,
                    //               color: Colors.white70,
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //           const Text(
                    //             'Participate on the ongoing easy and smooth game with others. Lead!',
                    //             textAlign: TextAlign.center,
                    //             style: TextStyle(color: Colors.white70),
                    //           ),
                    //           const SizedBox(height: 12.0),
                    //           ElevatedButton(
                    //               onPressed: () {},
                    //               style: ButtonStyle(
                    //                   shape: MaterialStatePropertyAll(
                    //                       RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.circular(8.0),
                    //                   )),
                    //                   backgroundColor: const MaterialStatePropertyAll(
                    //                       Colors.black),
                    //                   foregroundColor: const MaterialStatePropertyAll(
                    //                       Colors.white)),
                    //               child: const Text('Participate now'))
                    //         ],
                    //       )),
                    // ),
                    const SizedBox(height: 15.0),
                    AssetImages.keepLearning,
                    const SizedBox(height: 15.0),
                    Text(
                      'Available Programs',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      'Browse by categories that suits you',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 15.0),

                    RowListCard(
                      children: <ProgramButton>[
                        ProgramButton(
                          program: 'ICAN',
                          image: AssetImages.exp1,
                          onPressed: () => pushTo(
                              context, const ProgramCourses(program: 'ICAN')),
                        ),
                        ProgramButton(
                          program: 'ACCA',
                          image: AssetImages.exp2,
                          onPressed: () => pushTo(
                              context, const ProgramCourses(program: 'ACCA')),
                        ),
                        ProgramButton(
                          program: 'CITN',
                          image: AssetImages.exp3,
                          onPressed: () => pushTo(
                              context, const ProgramCourses(program: 'CITN')),
                        ),
                        ProgramButton(
                          program: 'CIMA',
                          image: AssetImages.exp4,
                          onPressed: () => pushTo(
                              context, const ProgramCourses(program: 'CIMA')),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    MaterialButton(
                      onPressed: () => pushTo(context, const ProgramPage()),
                      color: const Color(0xFFF1F1EF),
                      padding: const EdgeInsets.all(10.0),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'See more programs',
                            style: TextStyle(fontSize: 13),
                          ),
                          Icon(CupertinoIcons.arrow_right, size: 18),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    MaterialButton(
                      onPressed: () => pushTo(context, const MyLearningPage()),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.all(4.0),
                      child: AssetImages.keepLearning2,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Popular Courses',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        foregroundColor: MaterialStatePropertyAll(
                          Colors.grey.shade600,
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
                      buttonText: ref.watch(cartsProvider).contains(course)
                          ? 'Remove from cart'
                          : 'Add to cart',
                      toggleCartButton: () {
                        final carts = ref.watch(cartsProvider);
                        if (carts.contains(course)) {
                          ref.read(cartsProvider.notifier).update((state) =>
                              state.where((item) => item != course).toList());
                          showSuccessSnackbar(
                              context, 'Course removed from cart!');
                        } else {
                          ref
                              .read(cartsProvider.notifier)
                              .update((state) => [...state, course]);
                          showSuccessSnackbar(context, 'Course added to cart!');
                        }
                      },
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
                      buttonText: ref.watch(cartsProvider).contains(course)
                          ? 'Remove from cart'
                          : 'Add to cart',
                      toggleCartButton: () {
                        final carts = ref.watch(cartsProvider);
                        if (carts.contains(course)) {
                          ref.read(cartsProvider.notifier).update((state) =>
                              state.where((item) => item != course).toList());
                          showSuccessSnackbar(
                              context, 'Course removed from cart!');
                        } else {
                          ref
                              .read(cartsProvider.notifier)
                              .update((state) => [...state, course]);
                          showSuccessSnackbar(context, 'Course added to cart!');
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Spend the time',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      'Students are writing these exams',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 15.0),
                    AssetImages.hero,
                    const SizedBox(height: 20.0),
                    AssetImages.course,
                  ],
                ),
              ),
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
    );
  }
}
