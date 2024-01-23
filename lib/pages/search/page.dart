import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/text_field.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 8.0,
            ),
            child: CustomTextField(
              prefixIcon: Icon(
                CupertinoIcons.search,
                color: Colors.grey.shade600,
              ),
              hintText: 'Courses',
              suffixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      'Search',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ],
              ),
              margin: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
