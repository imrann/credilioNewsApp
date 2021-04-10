import 'dart:io';

import 'package:credilio_news/CommonScreens/AppBarCommon.dart';
import 'package:credilio_news/CommonScreens/ErrorPage.dart';
import 'package:credilio_news/CommonScreens/FancyLoader.dart';
import 'package:credilio_news/CommonScreens/NewsCategories.dart';
import 'package:credilio_news/Controllers/HomeController.dart';
import 'package:credilio_news/Podo/BreakingNews.dart';
import 'package:credilio_news/StateManager/BreakingNewListState.dart';
import 'package:credilio_news/StateManager/CategoryNewsListState.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

Future<dynamic> breakingNews;
Future<dynamic> categoryNews;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    breakingNews = HomeController().getBreakingNews();
    categoryNews = HomeController().getCategoryNews();
    breakingNews.then((value) {
      var breakingNewsListState =
          Provider.of<BreakingNewListState>(context, listen: false);
      breakingNewsListState.setBreakingNewListState(value);
    }).catchError((err) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "$err",
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 3),
      ));
    });

    categoryNews.then((value) {
      var categoryNewsListState =
          Provider.of<CategoryNewsListState>(context, listen: false);
      categoryNewsListState.setCategoryNewListState(value);
    }).catchError((err) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "$err",
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 3),
      ));
    });

    super.initState();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application!!'),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'NO',
                  style: TextStyle(color: Colors.pink[900]),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(
                  'YES',
                  style: TextStyle(color: Colors.pink[900]),
                ),
                onPressed: () {
                  exit(0);
                },
              ),
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: scaffoldKey,
      // extendBodyBehindAppBar: true,
      appBar: new AppBarCommon(
        title: Text(
          "CREDILIO",
          style: TextStyle(
              color: Colors.greenAccent,
              letterSpacing: -2,
              fontSize: 30.0,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic),
        ),
        profileIcon: Icons.search,
        trailingIcon: Icons.grid_view,
        centerTile: false,
        context: context,
        notificationCount: Text("i"),
        isTabBar: false,
        searchOwner: "topHeadLinesSearch",
      ),
      body: WillPopScope(
          onWillPop: _onBackPressed,
          child: Container(
            child: getNews(),
          )),
    );
  }

  getNews() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 0),
            child: Text(
              "Breaking News",
              textAlign: TextAlign.left,
              style: TextStyle(
                  letterSpacing: -1,
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: SizedBox(
              height: 450,
              child: FutureBuilder<dynamic>(
                  future: breakingNews,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      final error = snapshot.error;
                      print(error.toString());

                      return ErrorPage(error: "Something Went Wrong!");
                    } else if (snapshot.hasData) {
                      BreakingNews data = snapshot.data;

                      if (data.articles.isEmpty || data.articles.length == 0) {
                        return Center(
                          child: Text("No News Available!",
                              style: TextStyle(
                                  color: Colors.black,
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        );
                      } else {
                        return Consumer<BreakingNewListState>(
                            builder: (context, breaking, child) {
                          BreakingNews breakingNewsList =
                              breaking.getBreakingNewListState();

                          if (breakingNewsList.articles.length != 0) {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: breakingNewsList.articles.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      // elevation: 2,
                                      // color: Colors.transparent,
                                      child: Container(
                                        decoration: new BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        height: 400,
                                        width: 300,
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      bottom:
                                                          Radius.circular(30),
                                                      top: Radius.circular(30)),
                                              child: new FadeInImage
                                                      .memoryNetwork(
                                                  fit: BoxFit.fill,
                                                  placeholder:
                                                      kTransparentImage,
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  image: breakingNewsList
                                                          .articles[index]
                                                          .urlToImage ??
                                                      "https://media.istockphoto.com/vectors/image-preview-icon-picture-placeholder-for-website-or-uiux-design-vector-id1222357475?k=6&m=1222357475&s=612x612&w=0&h=p8Qv0TLeMRxaES5FNfb09jK3QkJrttINH2ogIBXZg-c="),
                                            ),
                                            // Positioned(
                                            //     top: 5,
                                            //     right: 5,
                                            //     child: Container(
                                            //       color: (productList[index]
                                            //                       .productData
                                            //                       .productNetWeight ==
                                            //                   "") &&
                                            //               (productList[index]
                                            //                       .productData
                                            //                       .productUnit ==
                                            //                   "")
                                            //           ? Colors.transparent
                                            //           : Colors.pink[900],
                                            //       child: Text(
                                            //         productList[index]
                                            //                 .productData
                                            //                 .productNetWeight +
                                            //             "  " +
                                            //             productList[index]
                                            //                 .productData
                                            //                 .productUnit,
                                            //         style: TextStyle(
                                            //             fontSize: 10,
                                            //             color: Colors.white),
                                            //       ),
                                            //     )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          } else {
                            return Center(child: Text("0 Search Result!"));
                          }
                        });
                      }
                    } else {
                      return FancyLoader(
                        loaderType: "MainGrid",
                      );
                    }
                  }),
            ),
          ),
          StickyHeader(
            header: Container(
              color: Colors.white,
              height: 60,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: NewsCategories.values.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 15, bottom: 10, top: 10),
                      child: Container(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/NewsArticle');
                          },
                          child: Text(
                            NewsCategories.values[index]
                                .toString()
                                .substring(15)
                                .toUpperCase(),
                            style: TextStyle(
                                letterSpacing: -1,
                                color: Colors.grey[300],
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            content: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: FutureBuilder<dynamic>(
                  future: categoryNews,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      final error = snapshot.error;
                      print(error.toString());

                      return ErrorPage(error: "Something Went Wrong!");
                    } else if (snapshot.hasData) {
                      BreakingNews data = snapshot.data;

                      if (data.articles.isEmpty || data.articles.length == 0) {
                        return Center(
                          child: Text("No News Available!",
                              style: TextStyle(
                                  color: Colors.black,
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        );
                      } else {
                        return Consumer<CategoryNewsListState>(
                            builder: (context, category, child) {
                          BreakingNews categoryNewsList =
                              category.getCategoryNewListState();

                          if (categoryNewsList.articles.length != 0) {
                            if (category.getToggleCategoryNewsView()) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: categoryNewsList.articles.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: getListViewCategoryNews(
                                            categoryNewsList, index));
                                  });
                            } else {
                              return GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.7),
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: getGridViewCategoryNews(
                                        categoryNewsList, index),
                                  );
                                },
                              );
                            }
                          } else {
                            return Center(child: Text("0 Search Result!"));
                          }
                        });
                      }
                    } else {
                      return Consumer<CategoryNewsListState>(
                          builder: (context, data, child) {
                        return FancyLoader(
                          loaderType: data.getToggleCategoryNewsView()
                              ? "list"
                              : "Grid",
                        );
                      });
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  getListViewCategoryNews(BreakingNews categoryNewsList, int index) {
    return Card(
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
          mainAxisAlignment: MainAxisAlignment.start,
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
          ],
        ),
      ),
    );
  }

  getGridViewCategoryNews(BreakingNews categoryNewsList, int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.transparent,
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10), top: Radius.circular(10)),
          child: new FadeInImage.memoryNetwork(
              fit: BoxFit.fill,
              placeholder: kTransparentImage,
              width: double.infinity,
              height: double.infinity,
              image: categoryNewsList.articles[index].urlToImage ??
                  "https://media.istockphoto.com/vectors/image-preview-icon-picture-placeholder-for-website-or-uiux-design-vector-id1222357475?k=6&m=1222357475&s=612x612&w=0&h=p8Qv0TLeMRxaES5FNfb09jK3QkJrttINH2ogIBXZg-c="),
        ),
      ),
    );
  }
}
