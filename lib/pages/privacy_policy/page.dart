import 'package:course_view/router/route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widgets/webview.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  Widget _headerText(BuildContext context, String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 25.0, bottom: 15.0),
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      color: Theme.of(context).primaryColor,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _bodyText(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(text, style: Theme.of(context).textTheme.bodySmall),
    );
  }

  Widget _listText(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'PRIVACY POLICY STATEMENT',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            _bodyText(
              context,
              'Welcome to the EXCEL ACADEMY app! We understand the '
              'importance of your privacy, and we are committed to '
              'safeguarding the personal information you entrust to us. '
              'This Privacy Policy outlines how we collect, use, and '
              'protect your information when you use our mobile application '
              '("Excel Academy"). By using the App, you consent to the '
              'practices described in this policy.',
            ),
            _headerText(context, 'Information we collect'),
            _bodyText(
              context,
              'We may collect personal information from '
              'you when you use our App, including:',
            ),
            _listText('1. Registration Information'),
            _bodyText(
              context,
              'When you create an account with the EXCEL ACADEMY App, '
              'we may ask for information such as your name, email address, '
              'and phone number.',
            ),
            _listText('2. App Usage Data'),
            _bodyText(
              context,
              'We collect data about your interactions with the App, '
              'such as the pages you visit, the features you use, '
              'and your device\'s unique identifier.',
            ),
            _headerText(context, 'How We Use Your Information'),
            _bodyText(
              context,
              'We use the personal information we collect '
              'through the App for the following purposes:',
            ),
            _listText('1. Providing Services'),
            _bodyText(
              context,
              'To offer and enhance our educational '
              'services within the App, personalize your '
              'experience, and respond to your inquiries and requests.',
            ),
            _listText('2. Communication'),
            _bodyText(
              context,
              'To keep you informed about our App updates, educational '
              'content, special offers, and important information.',
            ),
            _listText('3. Security'),
            _bodyText(
              context,
              'We implement robust security measures to protect '
              'your information from unauthorized access, disclosure, '
              'alteration, or destruction within the App.',
            ),
            _headerText(context, 'Your Choices'),
            _bodyText(
              context,
              'You have the following options regarding '
              'your personal information within the App:',
            ),
            _listText('1. Access and Update'),
            _bodyText(
              context,
              'You can review and update your personal '
              'information within the App settings.',
            ),
            _listText('2. Location Services'),
            _bodyText(
              context,
              'You can enable or disable location services '
              'for the App through your device\'s settings.',
            ),
            _listText('3. Push Notifications'),
            _bodyText(
              context,
              'You can manage your notification '
              'preferences within the App settings.',
            ),
            _headerText(context, 'CHILDREN’S PRIVACY STATEMENT'),
            _bodyText(
              context,
              'The EXCEL ACADEMY App is not intended for '
              'children under the age of 13. We do not knowingly '
              'collect personal information from individuals under '
              '13 years of age. If you believe that we have '
              'unintentionally collected such information, '
              'please contact us, and we will take '
              'appropriate steps to delete it.',
            ),
            _headerText(context, 'Enforcement'),
            _bodyText(
              context,
              'If you have any concerns or believe that '
              'EXCEL ACADEMY has not adhered to this Privacy Policy '
              'as it pertains to the App, please contact us at '
              'info@excelacademyonline.com, and we will make every '
              'effort to address and resolve the issue promptly.',
            ),
            _headerText(context, 'Changes to this Privacy Policy'),
            _bodyText(
              context,
              'We may update this Privacy Policy from time '
              'to time to reflect changes in our App\'s practices '
              'or for other operational, legal, or regulatory reasons. '
              'We will notify you of any material changes by sending '
              'you a direct notification within the App.',
            ),
            _headerText(context, 'CONTACT US'),
            _bodyText(
              context,
              'If you have any questions, comments, or concerns '
              'about our Privacy Policy as it relates to the App, '
              'please contact us at info@excelacademyonline.com.',
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  text: 'A PDF of this Privacy Policy '
                      'available for printing is available ',
                  style: TextStyle(
                    color: Colors.blueGrey.shade600,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'here',
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          pushTo(
                            context,
                            WebView(
                              url: 'https://excelacademyonline.com/',
                              showTitle: false,
                              // redirectUrl: ApiUrl.successful,
                              onClosed: () {},
                              onCompleted: () => {},
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void azag() {
    WebView(
      url: 'https://checkout.paystack.com/3k1y5dfve81d4f0',
      // redirectUrl: ApiUrl.successful,
      onClosed: () {},
      onCompleted: () => {},
    );
    print('object');
  }
}
