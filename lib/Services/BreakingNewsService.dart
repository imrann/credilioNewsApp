import 'dart:convert';
import 'dart:io';

import 'package:credilio_news/CommonScreens/CustomException.dart';
import 'package:credilio_news/Podo/BreakingNews.dart';
import 'package:http/http.dart' as http;

class BreakingNewsService {
  Future<dynamic> getBreakingNews() async {
    final String getBreakingNewsApi =
        "https://newsapi.org/v2/top-headlines?country=in&pageSize=15&page=1&apiKey=d4f5d54d11444b56b6999bc8e73de88c";

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
