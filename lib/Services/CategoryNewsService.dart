import 'dart:convert';
import 'dart:io';

import 'package:credilio_news/CommonScreens/CustomException.dart';
import 'package:credilio_news/Podo/BreakingNews.dart';
import 'package:http/http.dart' as http;

class CategoryNewsService {
  Future<dynamic> getCategoryNews() async {
    final String getCategoryNewsApi =
        "https://newsapi.org/v2/top-headlines?country=in&pageSize=10&page=1&category=business&apiKey=d4f5d54d11444b56b6999bc8e73de88c";

    Map<String, String> headers = {
      'Content-type': 'application/json',
    };
    BreakingNews posts = new BreakingNews();
    try {
      http.Response res = await http.get(getCategoryNewsApi, headers: headers);

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
