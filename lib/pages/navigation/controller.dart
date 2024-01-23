import 'package:flutter/material.dart';

mixin NavigationController on Widget {
  Future<bool> onWillPop(PageController pageController, int index) async {
    if (index != 0) {
      switchTab(pageController, 0);
      return false;
    }
    // TODO: Handle what to do when use tries to leave the app.
    return true;
  }

  void switchTab(PageController pageController, int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 80),
      curve: Curves.easeInOut,
    );
  }
}
