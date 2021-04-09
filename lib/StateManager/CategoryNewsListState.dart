import 'package:flutter/material.dart';

class CategoryNewsListState extends ChangeNotifier {
  bool toggleCategoryNewsView = true;
  bool getToggleCategoryNewsView() => toggleCategoryNewsView;

  setToggleCategoryNewsView() {
    if (this.toggleCategoryNewsView == true) {
      this.toggleCategoryNewsView = false;
    } else {
      this.toggleCategoryNewsView = true;
    }

    notifyListeners();
  }
}
