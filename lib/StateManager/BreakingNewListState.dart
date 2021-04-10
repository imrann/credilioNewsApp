import 'package:credilio_news/Podo/BreakingNews.dart';
import 'package:flutter/material.dart';

class BreakingNewListState extends ChangeNotifier {
  BreakingNews breakingNewsListState;

  BreakingNews getBreakingNewListState() => breakingNewsListState;

  setBreakingNewListState(BreakingNews breakingNewsListState) {
    this.breakingNewsListState = breakingNewsListState;
    print("sssss :" + this.breakingNewsListState.toString());
    notifyListeners();
  }
}
