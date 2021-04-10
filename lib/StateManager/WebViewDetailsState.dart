import 'package:flutter/material.dart';

class WebViewDetailsState extends ChangeNotifier {
  String url = "";
  String getUrl() => url;

  setUrl(String url) {
    this.url = url;

    notifyListeners();
  }
}
