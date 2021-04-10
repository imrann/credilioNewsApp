import 'package:credilio_news/Services/BreakingNewsService.dart';
import 'package:credilio_news/Services/CategoryNewsService.dart';

class HomeController {
  Future<dynamic> getBreakingNews() async {
    var breakingNewsList = await BreakingNewsService().getBreakingNews();

    return breakingNewsList;
  }

  Future<dynamic> getCategoryNews() async {
    var categoryNewsList = await CategoryNewsService().getCategoryNews();

    return categoryNewsList;
  }
}
