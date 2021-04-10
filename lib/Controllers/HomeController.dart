import 'package:credilio_news/Services/BreakingNewsService.dart';

class HomeController {
  Future<dynamic> getBreakingNews() async {
    var breakingNewsList = await BreakingNewsService().getBreakingNews();

    return breakingNewsList;
  }
}
