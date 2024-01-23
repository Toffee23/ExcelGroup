import 'package:course_view/core/constants/images.dart';
import 'package:course_view/pages/chat_screen/page.dart';
import 'package:course_view/router/route.dart';
import 'package:course_view/widgets/button.dart';
import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        centerTitle: true,
        title: Text(
          'LIVE CHAT WITH ADMIN',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              const Spacer(),
              AssetImages.pic,
              const SizedBox(height: 20.0),
              Text(
                'LIVE CHAT WITH ADMIN',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 10.0),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'This concept was introduced as a result '
                        'of helping students get a first-hand real '
                        'time chat with the admin for questions & answers '
                        'purposes and general finding about ',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      height: 1.4,
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'Excel Academy',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ]),
              ),
              const SizedBox(height: 20.0),
              AssetImages.people,
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '48 Members',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    '+953 replies from admin',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              const Spacer(),
              CustomElevatedButton(
                onPressed: () => pushTo(context, const ChatScreen()),
                text: 'START CHAT WITH ADMIN',
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AssetImages.lockCheck,
                  const SizedBox(width: 5.0),
                  const Expanded(
                    child: Text(
                      'Chat with admin is strictly for registered users only',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
