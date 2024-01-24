import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/card.dart';
import '../../widgets/place_holders.dart';
import '../../widgets/snack_bar.dart';
import '../../widgets/text_field.dart';
import '../home/provider.dart';

final data = <String, List<String>>{
  'ICAN': [
    'ATS LEVEL 1',
    'ATS LEVEL 2',
    'ATS LEVEL 3',
    'FOUNDATION',
    'SKILL',
    'PROFESSIONAL',
  ],
  'ACCA': ['Trending Courses', 'You might also like'],
  'CITN': [
    'FOUNDATION',
    'professional TAXATION I',
    'professional TAXATION II',
  ],
  'CIMA': ['Trending Courses', 'You might also like'],
  'CIS': ['Trending Courses', 'You might also like'],
  'AMAN': ['Trending Courses', 'You might also like'],
  'CIBN': [
    'DIPLOMA LEVEL',
    'Intermediate Professional Level',
    'Chartered Banker Level',
  ],
  'CFA': ['Trending Courses', 'You might also like'],
  'CPA': ['Trending Courses', 'You might also like'],
  'CIPM': [
    'FOUNDATION I',
    'FOUNDATION II',
    'INTERMEDIATE I',
    'INTERMEDIATE II',
    'professional I',
    'professional II',
  ],
};

class ProgramCourses extends ConsumerWidget {
  const ProgramCourses({
    Key? key,
    required this.program,
  }) : super(key: key);
  final String program;

  Widget _title(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(
                Theme.of(context).hintColor,
              ),
            ),
            child: const Text('See more'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$program Courses'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
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
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ref.watch(coursesProvider).when(
                    data: (courses) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ...data[program]!.map((e) {
                              return Column(
                                children: <Widget>[
                                  _title(context, e),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Row(
                                      children: (courses ?? []).map((course) {
                                        return HomeCard(
                                          isFirst: courses!.first == course,
                                          course: course,
                                          buttonText: ref
                                                  .watch(cartsProvider)
                                                  .contains(course)
                                              ? 'Remove from cart'
                                              : 'Add to cart',
                                          toggleCartButton: () {
                                            final carts =
                                                ref.watch(cartsProvider);
                                            if (carts.contains(course)) {
                                              ref
                                                  .read(cartsProvider.notifier)
                                                  .update((state) => state
                                                      .where((item) =>
                                                          item != course)
                                                      .toList());
                                              showSuccessSnackbar(context,
                                                  'Course removed from cart!');
                                            } else {
                                              ref
                                                  .read(cartsProvider.notifier)
                                                  .update((state) =>
                                                      [...state, course]);
                                              showSuccessSnackbar(context,
                                                  'Course added to cart!');
                                            }
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                ],
                              );
                            }).toList(),
                            // SingleChildScrollView(
                            //   scrollDirection: Axis.horizontal,
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 15.0),
                            //   child: Row(
                            //     children:
                            //         (courses ?? []).reversed.map((course) {
                            //       return HomeCard(
                            //         isFirst: courses!.first == course,
                            //         course: course,
                            //         buttonText: ref
                            //                 .watch(cartsProvider)
                            //                 .contains(course)
                            //             ? 'Remove from cart'
                            //             : 'Add to cart',
                            //         toggleCartButton: () {
                            //           final carts = ref.watch(cartsProvider);
                            //           if (carts.contains(course)) {
                            //             ref.read(cartsProvider.notifier).update(
                            //                 (state) => state
                            //                     .where((item) => item != course)
                            //                     .toList());
                            //             showSuccessSnackbar(context,
                            //                 'Course removed from cart!');
                            //           } else {
                            //             ref.read(cartsProvider.notifier).update(
                            //                 (state) => [...state, course]);
                            //             showSuccessSnackbar(
                            //                 context, 'Course added to cart!');
                            //           }
                            //         },
                            //       );
                            //     }).toList(),
                            //   ),
                            // ),
                            // const SizedBox(height: 40.0),
                          ],
                        ),
                      );
                    },
                    error: (_, __) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                                'An error as occurred, please try again'),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
