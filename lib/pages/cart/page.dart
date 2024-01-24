import 'dart:developer';

import 'package:course_view/core/api_handler/api_endpoints.dart';
import 'package:course_view/core/api_handler/api_handler_models.dart';
import 'package:course_view/core/api_handler/api_services.dart';
import 'package:course_view/core/constants/images.dart';
import 'package:course_view/core/extensions/string.dart';
import 'package:course_view/pages/home/model.dart';
import 'package:course_view/pages/home/provider.dart';
import 'package:course_view/router/route.dart';
import 'package:course_view/widgets/button.dart';
import 'package:course_view/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/webview.dart';

class CartPage extends ConsumerWidget {
  const CartPage({
    Key? key,
    required this.onArrowBackPressed,
  }) : super(key: key);
  final VoidCallback onArrowBackPressed;

  void _onPressed(BuildContext context, List<CoursesModel> courses) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      builder: (BuildContext context) {
        return CartBottomSheet(courses: courses);
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carts = ref.watch(cartsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (carts.isEmpty) ...[
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AssetImages.cartTrolley,
                  Text(
                    'No courses Found',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    'Your cart is empty',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: onArrowBackPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Theme.of(context).primaryColor,
                ),
                foregroundColor: const MaterialStatePropertyAll(
                  Colors.white,
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                minimumSize: const MaterialStatePropertyAll(
                  Size(double.infinity, 48.0),
                ),
              ),
              child: const Text('Explore courses'),
            ),
          ),
        ] else ...<Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    AssetImages.excelIcon,
                    Row(
                      children: <Widget>[
                        Text(
                          'Excel',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 3.0),
                        const Text(
                          'Academy',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: <Widget>[
                    const Text('Cart Items'),
                    Text(carts.length.toString()),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: carts.length,
              padding: const EdgeInsets.all(12.0),
              itemBuilder: (BuildContext context, int index) {
                final course = carts.elementAt(index);
                return MaterialButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(
                                top: 5.0,
                                left: 12.0,
                              ),
                              color: const Color(0xFFF0984A),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      course.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.calculate_outlined,
                                    color: Colors.white,
                                    size: 64,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: <Widget>[
                                const SizedBox(width: 12.0),
                                SizedBox(
                                  width: 32,
                                  child: AssetImages.excelIcon,
                                ),
                                const SizedBox(width: 8.0),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Excel Academy',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            height: 1,
                                            fontWeight: FontWeight.w900,
                                          ),
                                    ),
                                    Text(
                                      'Your pathway to success',
                                      style: TextStyle(
                                        height: 1,
                                        fontSize: 10,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              course.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Category: ICAN ATS 1 Level',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                    Text(
                                      'Packages: Revision Packages',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'NGN ${course.price.toString().formatToPrice}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              foregroundColor: MaterialStatePropertyAll(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                            child: const Text('Bookmark'),
                          ),
                          TextButton(
                            onPressed: () => ref
                                .read(cartsProvider.notifier)
                                .update((state) => state
                                    .where((item) => item != course)
                                    .toList()),
                            style: ButtonStyle(
                              foregroundColor: MaterialStatePropertyAll(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                            child: const Text('Remove'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: PaymentButton(
              total: carts
                  .map((c) => c.price)
                  .reduce((a, b) => a + b)
                  .toString()
                  .formatToPrice,
              onPressed: () => _onPressed(context, carts),
            ),
          ),
        ]
      ],
    );
  }
}

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({
    Key? key,
    required this.courses,
  }) : super(key: key);
  final List<CoursesModel> courses;

  Future<void> _onPressed(context) async {
    final data = {
      'email': 'azag@gmail.com',
      'amount': courses.map((c) => c.price).reduce((a, b) => a + b),
      'metadata': {
        'cart_id': courses.map((e) => e.id).toList(),
        'user_id': '6599b3ffcb35baa479a98db8',
      },
    };

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingSpinnerDialog(
          message: 'Redirecting to transaction page...',
          shouldPop: false,
        );
      },
    );

    final response = await ClientApi().pay(data);

    log(response.data.toString());

    if (response.status == ResponseStatus.successful) {
      final url = response.data['authorization_url'];
      final accessCode = response.data['access_code'];
      final reference = response.data['reference'];

      Navigator.of(context).pop();
      pushTo(
        context,
        WebView(
          url: url,
          redirectUrl: ApiUrl.successful,
          onClosed: () {},
          onCompleted: () => _onCompleted(context, accessCode, reference),
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<void> _onCompleted(context, String accessCode, String ref) async {
    Future.delayed(const Duration(seconds: 1)).then(
      (value) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return const LoadingSpinnerDialog(
            message: 'We are verifying your payment, please wait...',
            shouldPop: false,
          );
        },
      ),
    );

    final response = await ClientApi().verifyPayment(ref);

    if (response.status == ResponseStatus.successful) {
      _onSuccessful(context);
    } else {
      Navigator.of(context).pop();
    }
  }

  void _onSuccessful(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * .7,
      padding: const EdgeInsets.all(10.0),
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Color(0xFFFAFAFA),
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10.0),
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          const SizedBox(height: 30.0),
          CircleAvatar(
            radius: 72,
            backgroundColor: const Color(0xFFD2EDEF),
            child: AssetImages.wrappedPresent,
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'You have earned a N3,500 off the course package',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'A total of N3,500 had been saved to add up on '
                    'your next purchase of any course because you have '
                    'bought a course above a certain amount from our system.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          PaymentButton(
            total: courses
                .map((c) => c.price)
                .reduce((a, b) => a + b)
                .toString()
                .formatToPrice,
            onPressed: () => _onPressed(context),
          ),
        ],
      ),
    );
  }
}
