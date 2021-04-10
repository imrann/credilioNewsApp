import 'package:credilio_news/Services/BreakingNewsService.dart';
import 'package:credilio_news/Services/CategoryNewsService.dart';

class HomeController {
  Future<dynamic> getBreakingNews(String nextPage) async {
    var breakingNewsList =
        await BreakingNewsService().getBreakingNews(nextPage);

    return breakingNewsList;
  }

  Future<dynamic> getCategoryNews(String category, String nextPage) async {
    var categoryNewsList =
        await CategoryNewsService().getCategoryNews(category, nextPage);

    return categoryNewsList;
  }
}
