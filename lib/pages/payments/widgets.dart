import 'package:flutter/material.dart';

class PaymentContainer extends StatelessWidget {
  const PaymentContainer({
    Key? key,
    required this.category,
    required this.description,
    required this.duration,
  }) : super(key: key);
  final String category;
  final String description;
  final DateTime duration;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox.square(
            dimension: 40.0,
            child: DecoratedBox(
              decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color: Theme.of(context).primaryColor,
              ),
              child: const Center(
                child: Text(
                  'AC',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Category: $category',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  'Purchased on Apr 23, 2023',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
