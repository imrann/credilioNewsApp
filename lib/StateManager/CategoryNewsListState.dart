import 'package:credilio_news/Podo/BreakingNews.dart';
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

  /////////////////////////////////////////////////////////

  BreakingNews categoryNewsListState;

  BreakingNews getCategoryNewListState() => categoryNewsListState;

  setCategoryNewListState(BreakingNews categoryNewsListState) {
    this.categoryNewsListState = categoryNewsListState;

    notifyListeners();
  }

  addCategoryNewListState(BreakingNews categoryNewsListState) {
    this.categoryNewsListState.articles.addAll(categoryNewsListState.articles);

    notifyListeners();
  }
}
