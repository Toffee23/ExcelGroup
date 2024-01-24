import 'package:course_view/pages/payments/widgets.dart';
import 'package:flutter/material.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payments')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Payments',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Setup your payments for better experience. '
                  'You can only do this once in a month.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          if (false) ...[
            const Expanded(
              child: Center(
                child: Text('No available payments'),
              ),
            ),
            const SizedBox(height: 20.0),
          ] else
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                      4,
                      (index) => PaymentContainer(
                            category: 'ACCA',
                            description:
                                'ICAN Public Sector Accounting and Finance (Revision)',
                            duration: DateTime.now(),
                          )),
                ),
              ),
            )
        ],
      ),
    );
  }
}
