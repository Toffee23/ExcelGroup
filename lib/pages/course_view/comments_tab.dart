import 'package:flutter/material.dart';

class CommentsTab extends StatelessWidget {
  const CommentsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text('Reviews', style: Theme.of(context).textTheme.titleMedium),
          // Text(
          //   'Students feedback are very important',
          //   style: Theme.of(context).textTheme.bodySmall,
          // ),
          // const SizedBox(height: 15.0),
          ...List.generate(
            5,
            (index) => Column(
              children: <Widget>[
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox.square(
                      dimension: 35,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Rebacca Folake',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    letterSpacing: null,
                                    fontSize: 14,
                                  ),
                        ),
                        Text(
                          'Lagos, Nigeria',
                          style: TextStyle(
                            color: Colors.blueGrey.shade700,
                            fontSize: 12.0,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 14.0,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          '4.3',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.blueGrey.shade700,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          '3 Days ago',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.blueGrey.shade700,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 5.0),
                Text(
                  'Bootcamp was an absolute blast. '
                  'The classes were so interactive '
                  'and engaging which I loved so much',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    wordSpacing: 1,
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Center(
              child: Text(
                'See more reviews',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
