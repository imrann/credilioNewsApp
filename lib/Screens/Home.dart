import 'dart:io';

import 'package:credilio_news/CommonScreens/AppBarCommon.dart';
import 'package:credilio_news/CommonScreens/ErrorPage.dart';
import 'package:credilio_news/CommonScreens/FancyLoader.dart';
import 'package:credilio_news/CommonScreens/NewsCategories.dart';
import 'package:credilio_news/Controllers/HomeController.dart';
import 'package:credilio_news/Podo/BreakingNews.dart';
import 'package:credilio_news/Screens/NewsArticle.dart';
import 'package:credilio_news/StateManager/BreakingNewListState.dart';
import 'package:credilio_news/StateManager/CategoryNewsListState.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  ScrollController _controller = ScrollController();
  ScrollController _breakingNewscontroller = ScrollController();
  String selectedCategoryButton;
  bool isPaginationActive;
  bool isBreakingNewsPaginationActive;
  int nextPageCount;
  int breakingNewsNextPageCount;

  @override
  void initState() {
    nextPageCount = 1;
    breakingNewsNextPageCount = 1;
    isPaginationActive = false;
    isBreakingNewsPaginationActive = false;
    selectedCategoryButton = NewsCategories.values[0].toString().substring(15);
    breakingNews = HomeController().getBreakingNews("1", "");
    categoryNews = HomeController().getCategoryNews(
        NewsCategories.values[0].toString().substring(15).toUpperCase(), "1");
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
    _controller.addListener(_scrollListener);
    _breakingNewscontroller.addListener(_breakingNewsScrollListener);
  }

  _scrollListener() async {
    if (!isPaginationActive) {
      double maxScroll = _controller.position.maxScrollExtent;
      double currentScroll = _controller.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.01;
      if (maxScroll - currentScroll <= delta) {
        //getPaginatedOrdersOnlyByType();
        setState(() {
          isPaginationActive = true;
        });

        getPaginatedData();
        Future.delayed(Duration(seconds: 2), () {});
      }
    }
  }

  _breakingNewsScrollListener() async {
    if (!isBreakingNewsPaginationActive) {
      double maxScroll = _breakingNewscontroller.position.maxScrollExtent;
      double currentScroll = _breakingNewscontroller.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.01;
      if (maxScroll - currentScroll <= delta) {
        setState(() {
          isBreakingNewsPaginationActive = true;
        });

        getBreakingNewsPaginatedData();
        Future.delayed(Duration(seconds: 2), () {});
      }
    }
  }

  getBreakingNewsPaginatedData() {
    var searchDetails =
        Provider.of<BreakingNewListState>(context, listen: false);
    if (searchDetails.getIsSearchActive() &&
        (searchDetails.getSearchParam() == "")) {
      breakingNewsNextPageCount = 1;
    }
    int nextPage = ++breakingNewsNextPageCount;
    Future<dynamic> breakingpaginatedNews = HomeController().getBreakingNews(
        nextPage.toString(),
        searchDetails.getIsSearchActive()
            ? searchDetails.getSearchParam()
            : "");

    breakingpaginatedNews.then((value) {
      BreakingNews nextPageNews = value;
      if (nextPageNews.articles.length > 0) {
        var categoryNewsListState =
            Provider.of<BreakingNewListState>(context, listen: false);
        categoryNewsListState.addBreakingNewListState(value);
      } else {
        Fluttertoast.showToast(
            msg: "That's all folks!!",
            fontSize: 10,
            backgroundColor: Colors.black);
      }
      setState(() {
        isBreakingNewsPaginationActive = false;
      });
    }).catchError((err) {
      setState(() {
        isBreakingNewsPaginationActive = false;
      });
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "$err",
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 3),
      ));
    });
  }

  getPaginatedData() {
    int nextPage = ++nextPageCount;
    print(nextPageCount.toString());
    Future<dynamic> categorypaginatedNews = HomeController().getCategoryNews(
        selectedCategoryButton.toUpperCase(), nextPage.toString());

    categorypaginatedNews.then((value) {
      BreakingNews nextPageNews = value;
      if (nextPageNews.articles.length > 0) {
        var categoryNewsListState =
            Provider.of<CategoryNewsListState>(context, listen: false);
        categoryNewsListState.addCategoryNewListState(value);
      } else {
        Fluttertoast.showToast(
            msg: "That's all folks!!",
            fontSize: 10,
            backgroundColor: Colors.black);
      }
      setState(() {
        isPaginationActive = false;
      });
    }).catchError((err) {
      setState(() {
        isPaginationActive = false;
      });
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "$err",
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 3),
      ));
    });
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
      padding: const EdgeInsets.only(
        bottom: kMiniButtonOffsetAdjustment + 100,
      ),
      controller: _controller,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 0, right: 15),
            child:
                Consumer<BreakingNewListState>(builder: (context, data, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.getIsSearchActive()
                        ? "Searched Results"
                        : "Breaking News",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        letterSpacing: -1,
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal),
                  ),
                  InkWell(
                    onTap: () {
                      breakingNews = HomeController().getBreakingNews("1", "");
                      breakingNews.then((value) {
                        var breakingNewsListState =
                            Provider.of<BreakingNewListState>(context,
                                listen: false);
                        breakingNewsListState.setBreakingNewListState(value);
                        breakingNewsListState.setIsSearchActive(false);
                        breakingNewsNextPageCount = 1;
                      }).catchError((err) {
                        print("$err");
                      });
                    },
                    child: Container(
                      color: Colors.greenAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          data.getIsSearchActive() ? "Breaking News" : "",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              letterSpacing: -1,
                              color: Colors.black,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
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
                            return Row(
                              //  mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      controller: _breakingNewscontroller,
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          breakingNewsList.articles.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Material(
                                            child: InkWell(
                                              splashColor: Colors.greenAccent,
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    '/NewsArticle',
                                                    arguments: NewsArticle(
                                                      newsUrl: breakingNewsList
                                                          .articles[index].url
                                                          .toString(),
                                                    ));
                                              },
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                // elevation: 2,
                                                // color: Colors.transparent,
                                                child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  height: 400,
                                                  width: 300,
                                                  child: Stack(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                bottom: Radius
                                                                    .circular(
                                                                        30),
                                                                top: Radius
                                                                    .circular(
                                                                        30)),
                                                        child: new FadeInImage
                                                                .memoryNetwork(
                                                            fit: BoxFit.fill,
                                                            placeholder:
                                                                kTransparentImage,
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                            image: breakingNewsList
                                                                    .articles[
                                                                        index]
                                                                    .urlToImage ??
                                                                "https://media.istockphoto.com/vectors/image-preview-icon-picture-placeholder-for-website-or-uiux-design-vector-id1222357475?k=6&m=1222357475&s=612x612&w=0&h=p8Qv0TLeMRxaES5FNfb09jK3QkJrttINH2ogIBXZg-c="),
                                                      ),
                                                      Positioned(
                                                        bottom: 0,
                                                        right: 0,
                                                        left: 0,
                                                        child: Container(
                                                          decoration:
                                                              new BoxDecoration(
                                                            color:
                                                                Colors.black38,
                                                            borderRadius: BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        30)),
                                                          ),
                                                          width:
                                                              double.infinity,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.25,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Flexible(
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                            breakingNewsList.articles[index].title
                                                                                .toString(),
                                                                            overflow: TextOverflow
                                                                                .fade,
                                                                            softWrap:
                                                                                true,
                                                                            maxLines:
                                                                                4,
                                                                            style: TextStyle(
                                                                                fontSize: 17,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Flexible(
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                            breakingNewsList.articles[index].description ??
                                                                                "No Description",
                                                                            overflow: TextOverflow
                                                                                .fade,
                                                                            softWrap:
                                                                                true,
                                                                            maxLines:
                                                                                4,
                                                                            style:
                                                                                TextStyle(fontSize: 10, color: Colors.grey[300])),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Flexible(
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                8,
                                                                            bottom:
                                                                                10,
                                                                            right:
                                                                                8,
                                                                            top:
                                                                                10),
                                                                        child: Text(
                                                                            breakingNewsList.articles[index].source.name ??
                                                                                "".toString(),
                                                                            overflow: TextOverflow.fade,
                                                                            softWrap: true,
                                                                            maxLines: 4,
                                                                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 10,
                                                        right: 10,
                                                        child: Container(
                                                          color: Colors.black38,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            child: Text(
                                                                breakingNewsList
                                                                        .articles[
                                                                            index]
                                                                        .publishedAt
                                                                        .substring(
                                                                            0,
                                                                            10) ??
                                                                    ""
                                                                        .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade,
                                                                softWrap: true,
                                                                maxLines: 4,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                isBreakingNewsPaginationActive
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: CircularProgressIndicator(),
                                      )
                                    : SizedBox()
                              ],
                            );
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
                          style: TextButton.styleFrom(),
                          onPressed: () {
                            setState(() {
                              nextPageCount = 1;
                              selectedCategoryButton = NewsCategories
                                  .values[index]
                                  .toString()
                                  .substring(15);
                            });
                            categoryNews = HomeController().getCategoryNews(
                                NewsCategories.values[index]
                                    .toString()
                                    .substring(15)
                                    .toUpperCase(),
                                "1");

                            categoryNews.then((value) {
                              var categoryNewsListState =
                                  Provider.of<CategoryNewsListState>(context,
                                      listen: false);
                              categoryNewsListState
                                  .setCategoryNewListState(value);
                            }).catchError((err) {
                              scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text(
                                  "$err",
                                  textAlign: TextAlign.center,
                                ),
                                duration: Duration(seconds: 3),
                              ));
                            });
                          },
                          child: Text(
                            NewsCategories.values[index]
                                .toString()
                                .substring(15)
                                .toUpperCase(),
                            style: TextStyle(
                                letterSpacing: -1,
                                color: selectedCategoryButton ==
                                        (NewsCategories.values[index]
                                            .toString()
                                            .substring(15))
                                    ? Colors.redAccent
                                    : Colors.grey[300],
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            content: Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
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
                                // controller: _controller,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.7),
                                itemCount: categoryNewsList.articles.length,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isPaginationActive
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 50),
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox()
            ],
          )
        ],
      ),
    );
  }

  getListViewCategoryNews(BreakingNews categoryNewsList, int index) {
    return Material(
      child: InkWell(
        splashColor: Colors.greenAccent,
        onTap: () {
          Navigator.of(context).pushNamed('/NewsArticle',
              arguments: NewsArticle(
                newsUrl: categoryNewsList.articles[index].url.toString(),
              ));
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

  getGridViewCategoryNews(BreakingNews categoryNewsList, int index) {
    return Material(
      child: InkWell(
        splashColor: Colors.greenAccent,
        onTap: () {
          Navigator.of(context).pushNamed('/NewsArticle',
              arguments: NewsArticle(
                newsUrl: categoryNewsList.articles[index].url.toString(),
              ));
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
            child: Stack(
              children: [
                ClipRRect(
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
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    decoration: new BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      categoryNewsList.articles[index].title
                                          .toString(),
                                      overflow: TextOverflow.fade,
                                      softWrap: true,
                                      maxLines: 4,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      categoryNewsList
                                              .articles[index].source.name ??
                                          "".toString(),
                                      overflow: TextOverflow.fade,
                                      softWrap: true,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    color: Colors.black38,
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Text(
                          categoryNewsList.articles[index].publishedAt
                                  .substring(0, 10) ??
                              "".toString(),
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
