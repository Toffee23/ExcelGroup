import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_view/pages/community/ui/community_one.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommunityListUi extends StatelessWidget {
  const CommunityListUi({super.key});

  @override
  Widget build(BuildContext context) {
    var forumQuery = FirebaseFirestore.instance.collection('forum');

    TextEditingController _textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Community study groups'),
        backgroundColor: Color(0xffF3F3F1),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffD6D6D6), width: 1),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      labelText: 'Find Topics',
                      labelStyle: TextStyle(color: Color(0xff767676)),
                      prefixIcon: Icon(Icons.search,
                          color: Color(0xff767676)), // Icon to the left
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle the search button action
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    color: Colors.transparent, // Background color of the button
                    child: Text(
                      'Search',
                      style: TextStyle(
                        color: Color(0xffFF822B), // Text color of the button
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Icon to the left
          ),
          SizedBox(height: 40),
          Text(
            'Study community groups',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xff191919)),
            textAlign: TextAlign.left,
          ),
          Container(
            height: 600,
            child: FirestoreListView<Map<String, dynamic>>(
              query: forumQuery,
              itemBuilder: (context, snapshot) {
                Map<String, dynamic> forum = snapshot.data();
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CommunityOne(
                        forumId: snapshot.id,
                        forumName: forum['title'],
                      );
                    }));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Color(0xffD2EDEF)),
                        child: Text(
                          forum['category'],
                          style: TextStyle(
                            color: Color(0xff1FA6AF),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        forum['title'],
                        style: TextStyle(
                            color: Color(0xff2A2A2A),
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 8),
                      Text(
                          'Embrace the opportunity to serve, to learn, and to grow. Join the ${forum['title']} and be a catalyst for positive change.'),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month_rounded,
                            color: Color(0xff767676),
                          ),
                          SizedBox(width: 8),
                          Text(
                            DateFormat('d MMM, yyyy')
                                .format(forum['date'].toDate()),
                            style: TextStyle(
                                color: Color(0xff767676),
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      Container(
                        height: 16,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Color(0xffD6D6D6)))),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
