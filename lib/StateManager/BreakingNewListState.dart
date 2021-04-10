import 'package:credilio_news/Podo/BreakingNews.dart';
import 'package:flutter/material.dart';

class BreakingNewListState extends ChangeNotifier {
  BreakingNews breakingNewsListState;

  BreakingNews getBreakingNewListState() => breakingNewsListState;

  setBreakingNewListState(BreakingNews breakingNewsListState) {
    this.breakingNewsListState = breakingNewsListState;

    notifyListeners();
  }

  addBreakingNewListState(BreakingNews breakingNewsListState) {
    this.breakingNewsListState.articles.addAll(breakingNewsListState.articles);

    notifyListeners();
  }
}
