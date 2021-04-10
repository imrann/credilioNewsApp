import 'package:credilio_news/CommonScreens/ErrorPage.dart';
import 'package:credilio_news/CommonScreens/FancyLoader.dart';
import 'package:credilio_news/Podo/BreakingNews.dart';
import 'package:credilio_news/StateManager/BreakingNewListState.dart';
import 'package:credilio_news/StateManager/WebViewDetailsState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RelatedNewsArticles extends StatefulWidget {
  final Function loadurl;
  RelatedNewsArticles({this.loadurl});
  @override
  _RelatedNewsArticlesState createState() => _RelatedNewsArticlesState();
}

class _RelatedNewsArticlesState extends State<RelatedNewsArticles> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Headlines",
                    style: TextStyle(
                        letterSpacing: -1,
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(
                    "CREDILIO",
                    style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.greenAccent,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: SizedBox(
                height: 120,
                child: FutureBuilder<dynamic>(
                    future: Future.delayed(Duration(seconds: 1), () {}),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      return Consumer<BreakingNewListState>(
                          builder: (context, randomNews, child) {
                        BreakingNews categoryNewsList =
                            randomNews.getBreakingNewListState();

                        if (categoryNewsList.articles.length != 0) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: categoryNewsList.articles.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: getListViewCategoryNews(
                                        categoryNewsList, index));
                              });
                        } else {
                          return Center(child: Text("0 Search Result!"));
                        }
                      });
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getListViewCategoryNews(BreakingNews categoryNewsList, int index) {
    return Material(
      child: InkWell(
        splashColor: Colors.greenAccent,
        onTap: () {
          var webViewurl =
              Provider.of<WebViewDetailsState>(context, listen: false);
          webViewurl.setUrl(categoryNewsList.articles[index].url);
          widget.loadurl(categoryNewsList.articles[index].url);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.transparent,
          child: Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10), top: Radius.circular(10)),
                  child: new FadeInImage.memoryNetwork(
                      fit: BoxFit.fill,
                      placeholder: kTransparentImage,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: double.infinity,
                      image: categoryNewsList.articles[index].urlToImage ??
                          "https://media.istockphoto.com/vectors/image-preview-icon-picture-placeholder-for-website-or-uiux-design-vector-id1222357475?k=6&m=1222357475&s=612x612&w=0&h=p8Qv0TLeMRxaES5FNfb09jK3QkJrttINH2ogIBXZg-c="),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 5),
                        child: Text(
                            categoryNewsList.articles[index].title ??
                                "".toString(),
                            overflow: TextOverflow.fade,
                            softWrap: true,
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 5, bottom: 5),
                          child: Text(
                            categoryNewsList.articles[index].source.name
                                    .toString() ??
                                "",
                            overflow: TextOverflow.fade,
                            softWrap: true,
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[350]),
                          )),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 5, bottom: 5),
                          child: Text(
                            categoryNewsList.articles[index].publishedAt
                                    .substring(0, 10) ??
                                "".toString(),
                            overflow: TextOverflow.fade,
                            softWrap: true,
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[300]),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
