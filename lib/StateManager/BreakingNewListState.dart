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

///////////////////////////////////////////////////////////

  bool isSearchActive = false;
  bool getIsSearchActive() => isSearchActive;

  setIsSearchActive(bool isSearchActive) {
    this.isSearchActive = isSearchActive;

    notifyListeners();
  }
  ////////////////////////////////////////////////////////////

  String searchParam = "";
  String getSearchParam() => searchParam;

  setSearchParam(String searchParam) {
    this.searchParam = searchParam;

    notifyListeners();
  }
}
