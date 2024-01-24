import 'package:course_view/pages/course_view/model.dart';
import 'package:flutter/material.dart';

import '../../core/api_handler/api_endpoints.dart';
import '../../core/api_handler/api_handler_models.dart';
import '../../core/api_handler/api_services.dart';
import '../../router/route.dart';
import '../../widgets/dialog.dart';
import '../../widgets/webview.dart';

mixin CourseViewPageController on Widget {
  Future<void> onEnrollNow(context, CourseModel course) async {
    final data = {
      'email': 'azag@gmail.com',
      'amount': course.price,
      'metadata': {
        'cart_id': course.id,
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
}
