import 'package:course_view/pages/community/ui/community_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommunityHomeUi extends StatelessWidget {
  const CommunityHomeUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community study'),
        backgroundColor: Color(0xffF3F3F1),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(children: [
          SizedBox(height: 100),
          Center(
              child: Image.asset(
            'assets/images/pic.png',
            width: 150,
          )),
          SizedBox(
            height: 20,
          ),
          Text('STUDY Community THERAPY'),
          SizedBox(height: 12),
          Text(
            'This community fosters aa positive learning environment where members can share knowledge, exchange ideas, engage discussions, ask questions, and seek guidance',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 28),
          Image.asset(
            'assets/images/people.png',
            width: 140,
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('812 Members'),
              SizedBox(width: 12),
              Text('+4,053 Conversations')
            ],
          ),
          SizedBox(height: 80),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                backgroundColor: Color(0xffFF822B),
                foregroundColor: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommunityListUi()),
              );
            },
            child: Text('EXPLORE NOW'),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock,
                color: Color(0xff767676),
              ),
              Text('This community is for registered users only')
            ],
          ),
          SizedBox(height: 9),
          Text(
            'Community Terms of Use',
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                color: Color(0xffFF822B)),
          )
        ]),
      ),
    );
  }
}
