import 'package:course_view/router/route.dart';
import 'package:course_view/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class ManageProfilePage extends StatelessWidget {
  const ManageProfilePage({Key? key}) : super(key: key);

  void _onSave(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProfileSaveDialog(
          onDiscard: () => pop(context),
          onSave: () => {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: <Widget>[
          MaterialButton(
            onPressed: () => _onSave(context),
            color: Colors.black87,
            visualDensity: const VisualDensity(vertical: -2, horizontal: -2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            minWidth: 0,
            elevation: 0,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.flash_on_rounded,
                  color: Colors.grey.shade100,
                  size: 16,
                ),
                const SizedBox(width: 2.0),
                Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.grey.shade100,
                    fontSize: 13.0,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20.0),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Manage Profile',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Setup your profile for better experience. '
                  'You can only do this once in a month.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: <Widget>[
                  const CustomTextField(
                    hintText: 'Firstname',
                  ),
                  const CustomTextField(
                    hintText: 'Lastname',
                  ),
                  const CustomTextField(
                    hintText: 'Email',
                  ),
                  const CustomTextField(
                    hintText: 'Username',
                  ),
                  const CustomTextField(
                    hintText: 'Phone number',
                  ),
                  CustomTextField(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.eye,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  CustomTextField(
                    hintText: 'Confirm Password',
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.eye,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.only(bottom: 15.0),
                  //   child: MaterialButton(
                  //     onPressed: () {},
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 10.0,
                  //       vertical: 12.0,
                  //     ),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(12.0),
                  //       side: BorderSide(
                  //         color: Colors.grey.shade400,
                  //         width: 1.2,
                  //       ),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: <Widget>[
                  //         Text(
                  //           'Select Gender',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.normal,
                  //             color: Colors.grey.shade600,
                  //           ),
                  //         ),
                  //         Icon(
                  //           Icons.expand_more,
                  //           color: Colors.grey.shade600,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 40.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
