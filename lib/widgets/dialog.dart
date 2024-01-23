import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingSpinnerDialog extends StatelessWidget {
  const LoadingSpinnerDialog({
    Key? key,
    required this.message,
    this.shouldPop = true,
  }) : super(key: key);
  final String message;
  final bool shouldPop;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox.square(
              dimension: 32.0,
              child: CupertinoActivityIndicator(),
            ),
            const SizedBox(height: 8.0),
            Text(message)
          ],
        ),
      ),
    );
  }
}

class PaymentSuccessfulDialog extends StatelessWidget {
  const PaymentSuccessfulDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text('Successful'),
      content: Text('Payment successful. You can now proceed to course'),
    );
  }
}
