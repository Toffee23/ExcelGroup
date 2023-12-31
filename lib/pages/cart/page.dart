import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    Key? key,
    required this.onArrowBackPressed,
  }) : super(key: key);
  final VoidCallback onArrowBackPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppBar(
          leading: IconButton(
            onPressed: onArrowBackPressed,
            icon: const Icon(Icons.arrow_back),
          ),
          backgroundColor: const Color(0XFFF1F1EF),
          title: const Text('Course cart'),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Image.asset('assets/images/excel-icon.png'),
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
                          const Column(
                            children: <Widget>[
                              Text('Cart Items'),
                              Text('5'),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  // child: Center(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: <Widget>[
                  //       Image.asset('assets/images/emoji_shopping_trolley.png'),
                  //       Text(
                  //         'No courses Found',
                  //         style: Theme.of(context).textTheme.titleMedium,
                  //       ),
                  //       const SizedBox(height: 2.0),
                  //       Text(
                  //         'Your cart is empty',
                  //         style: Theme.of(context).textTheme.bodySmall,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ),
                ElevatedButton(
                  onPressed: () {},
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
                      Size(double.infinity, 40),
                    ),
                  ),
                  child: const Text('Explore course'),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
