import 'package:flutter/material.dart';

class AchievementsExpansionTile extends StatelessWidget {
  const AchievementsExpansionTile({
    Key? key,
    required this.data,
  }) : super(key: key);
  final List<String> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        title: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: Color(0xFFF0F0F0),
              ),
              child: const Icon(
                Icons.health_and_safety_sharp,
                color: Colors.black87,
                size: 18,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Course completed',
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(),
                          color: Color(0xFFF0F0F0),
                        ),
                        child: Text(
                          data.length.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Keep real with the challenges won',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data
                  .map(
                    (e) => Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        children: <Widget>[
                          const SizedBox.square(
                            dimension: 6.0,
                            child: DecoratedBox(
                              decoration: ShapeDecoration(
                                shape: CircleBorder(),
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              e,
                              style: TextStyle(
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
