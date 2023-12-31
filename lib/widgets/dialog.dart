import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingSpinnerDialog extends StatelessWidget {
  const LoadingSpinnerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox.square(
            dimension: 32.0,
            child: CupertinoActivityIndicator(),
          ),
          SizedBox(height: 8.0),
          Text('Download in progress...')
        ],
      ),
    );
  }
}
