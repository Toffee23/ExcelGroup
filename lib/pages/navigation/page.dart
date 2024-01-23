import 'package:course_view/pages/my_learning/page.dart';
import 'package:course_view/pages/program/page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cart/page.dart';
import '../home/page.dart';
import '../profile/page.dart';
import 'controller.dart';

class NavigationPage extends StatefulWidget with NavigationController {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  late PageController _pageController;
  final tabIndexNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: tabIndexNotifier.value);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          widget.onWillPop(_pageController, tabIndexNotifier.value),
      child: ValueListenableBuilder(
          valueListenable: tabIndexNotifier,
          builder: (context, selectedIndex, child) {
            return Scaffold(
              appBar: selectedIndex == 0
                  ? AppBar(
                      toolbarHeight: 0,
                    )
                  : AppBar(
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => widget.switchTab(_pageController, 0),
                      ),
                      title: Text(
                        selectedIndex == 1
                            ? 'Programs'
                            : selectedIndex == 2
                                ? 'My Learning'
                                : selectedIndex == 3
                                    ? 'Course Cart'
                                    : 'Profile',
                      ),
                    ),
              body: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => tabIndexNotifier.value = index,
                children: <Widget>[
                  HomePage(
                    onCartIconPressed: () =>
                        widget.switchTab(_pageController, 3),
                  ),
                  const ProgramPage(),
                  const MyLearningPage(),
                  CartPage(
                    onArrowBackPressed: () =>
                        widget.switchTab(_pageController, 0),
                  ),
                  const ProfilePage(),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.explore_outlined),
                    label: 'Explore',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.category_rounded),
                    label: 'Programs',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.widgets_outlined),
                    label: 'My Learning',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.cart),
                    label: 'Cart',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.profile_circled),
                    label: 'Profile',
                  ),
                ],
                currentIndex: selectedIndex,
                selectedItemColor: Theme.of(context).primaryColor,
                onTap: (int index) => widget.switchTab(_pageController, index),
              ),
            );
          }),
    );
  }
}
