import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_view/pages/community/logic/community_logic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommunityOne extends StatefulWidget {
  final String forumId;
  final String forumName;
  CommunityOne({super.key, required this.forumId, required this.forumName});

  @override
  State<CommunityOne> createState() => _CommunityOneState();
}

class _CommunityOneState extends State<CommunityOne> {
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: fetchForum(widget.forumId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Text('No data available');
                } else {
                  Timestamp time = snapshot.data?['date'];
                  String dateTime =
                      DateFormat('dd MM yyyy').format(time.toDate().toLocal());

                  return Column(
                    children: [
                      Stack(
                        children: [
                          Image.asset('assets/images/bg.jpg'),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 160),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Color(0xffFF822B)),
                                      child: Text(
                                        snapshot.data?['category'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      snapshot.data?['title'],
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    )
                                  ]),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data?['creator']),
                                    SizedBox(height: 4),
                                    Text(snapshot.data?['certification']),
                                    SizedBox(height: 4),
                                    Text('Created on $dateTime'),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 30),
                            ForumTab(
                              forumId: widget.forumId,
                              forumName: widget.forumName,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
              }),
        ));
  }
}

class ForumTab extends StatefulWidget {
  final String forumId;
  final String forumName;
  const ForumTab({super.key, required this.forumId, required this.forumName});

  @override
  State<ForumTab> createState() => _ForumTabState(forumId: forumId, forumName);
}

class _ForumTabState extends State<ForumTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  _ForumTabState(this.forumName, {required this.forumId});
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 0,
    );
  }

  final String forumId;
  final String forumName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      child: Column(
        children: [
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: TabBar(
                controller: _tabController,
                unselectedLabelColor: Color(0xff999999),
                labelColor: Color(0xffFF822B),
                indicatorColor: Color(0xffFF822B),
                isScrollable: true,
                tabs: <Widget>[
                  Text('Instructions'),
                  Text('Members'),
                  Text('About group'),
                  Text('Message Admin')
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                    child: InstructionTab(
                  forumId: forumId,
                  forumName: forumName,
                )),
                Container(child: Members()),
                Container(
                    child: AboutTab(
                  forumId: forumId,
                  forumName: forumName,
                )),
                Container(child: MessageAdmin()),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class InstructionTab extends StatelessWidget {
  final String forumId;
  final String forumName;
  const InstructionTab(
      {super.key, required this.forumId, required this.forumName});

  @override
  Widget build(BuildContext context) {
    var currentUser = '';
    return Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 30,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(color: Color(0xffF3F3F1)),
                child: Text(
                  'Confidentiality',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                ),
              ),
              SizedBox(height: 4),
              Text(
                  'Respect the confidentiality of all financial and accounting information shared within the management accounting group. Do not disclose or discuss sensitive data with unauthorized individuals.'),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 30,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(color: Color(0xffF3F3F1)),
                child: Text(
                  'Ethical Conduct',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                ),
              ),
              SizedBox(height: 4),
              Text(
                  'Adhere to high ethical standards in all financial activities and interactions. Avoid engaging in any fraudulent, deceptive, or unethical practices'),
              SizedBox(height: 24),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(8.0))),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => QuestionList(
              //                 forumId: forumId,
              //                 forumName: forumName,
              //               )),
              //     );
              //     addMembers(forumId, {'userid': currentUser.uid});
              //   },
              //   child: FutureBuilder(
              //     future: ifMember(forumId, currentUser!.uid),
              //     builder:
              //         (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              //       return Text(snapshot.data == true
              //           ? 'ENTER GROUP NOW'
              //           : 'JOIN GROUP NOW');
              //     },
              //   ),
              // )
            ],
          ),
        ));
  }
}

class Members extends StatelessWidget {
  const Members({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: const Text('NO MEMBERS'));
  }
}

class AboutTab extends StatelessWidget {
  final String forumId;
  final String forumName;
  const AboutTab({super.key, required this.forumId, required this.forumName});

  @override
  Widget build(BuildContext context) {
    var currentUser = '';

    return Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                  'Respect the confidentiality of all financial and accounting information shared within the management accounting group. Do not disclose or discuss sensitive data with unauthorized individuals. '),
              SizedBox(height: 20),
              Text(
                  'Management accounting is a branch of accounting that involves the process of collecting, analyzing, and interpreting financial and non-financial information to aid in managerial decision-making, planning, and control within an organization.'),
              SizedBox(height: 24),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(8.0))),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => QuestionList(
              //                 forumId: forumId,
              //                 forumName: forumName,
              //               )),
              //     );
              //     addMembers(forumId, {'userid': currentUser.uid});
              //   },
              //   child: FutureBuilder(
              //     future: ifMember(forumId, currentUser!.uid),
              //     builder:
              //         (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              //       return Text(snapshot.data == true
              //           ? 'ENTER GROUP NOW'
              //           : 'JOIN GROUP NOW');
              //     },
              //   ),
              // )
            ],
          ),
        ));
  }
}

class MessageAdmin extends StatelessWidget {
  const MessageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.maxFinite,
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Leave a message or question for the admin'),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xffF3F3F1),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Enter your message...',
                          hintStyle: TextStyle(fontSize: 15),
                          border: InputBorder.none),
                    )),
                    SizedBox(width: 10),
                    Container(
                      padding: EdgeInsets.only(left: 4),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffFFE6D5),
                      ),
                      child: Center(
                        child: Transform.rotate(
                          angle: 315 * (3.141592653589793 / 180),
                          child: GestureDetector(
                            onTap: (() {
                              // send message
                            }),
                            child: Icon(
                              Icons.send_rounded,
                              color: Color(0xffFF822B),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
