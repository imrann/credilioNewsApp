import 'dart:convert';
import 'dart:io';

import 'package:credilio_news/CommonScreens/CustomException.dart';
import 'package:credilio_news/Podo/BreakingNews.dart';
import 'package:http/http.dart' as http;

class BreakingNewsService {
  Future<dynamic> getBreakingNews(String nextPage, String searchText) async {
    String getBreakingNewsApi;
    if (searchText.trim().isEmpty) {
      getBreakingNewsApi =
          "https://newsapi.org/v2/top-headlines?country=in&pageSize=10&page=$nextPage&apiKey=82eee72d769f44d89d4fb26881840e87";
    } else {
      getBreakingNewsApi =
          "https://newsapi.org/v2/top-headlines?q=$searchText&country=in&pageSize=10&page=$nextPage&apiKey=82eee72d769f44d89d4fb26881840e87";
    }

    Map<String, String> headers = {
      'Content-type': 'application/json',
    };
    BreakingNews posts = new BreakingNews();
    try {
      http.Response res = await http.get(getBreakingNewsApi, headers: headers);

      if (res.statusCode == 200 &&
          jsonDecode(res.body)['status'].toString().contains("ok")) {
        var data = jsonDecode(res.body);
        print(data);
        posts = BreakingNews.fromJson(data);

        return posts;
      } else {
        CustomException().returnResponse(response: res, connection: true);
      }
    } on SocketException {
      CustomException().returnResponse(connection: false);
    } finally {}
  }
}
