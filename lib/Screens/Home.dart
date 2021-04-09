import 'dart:io';

import 'package:credilio_news/CommonScreens/AppBarCommon.dart';
import 'package:credilio_news/CommonScreens/ErrorPage.dart';
import 'package:credilio_news/CommonScreens/FancyLoader.dart';
import 'package:credilio_news/CommonScreens/NewsCategories.dart';
import 'package:credilio_news/StateManager/CategoryNewsListState.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
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
                  future: Future.delayed(Duration(seconds: 5), () {}),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    // if (snapshot.hasError) {
                    //   final error = snapshot.error;

                    //   return ErrorPage(error: error.toString());
                    // } else if (snapshot.hasData) {
                    //   return ListView.builder(
                    //       shrinkWrap: true,
                    //       physics: ClampingScrollPhysics(),
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount: 30,
                    //       itemBuilder: (BuildContext context, int index) {
                    //         return Padding(
                    //           padding: const EdgeInsets.only(right: 10),
                    //           child: Card(
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(30),
                    //             ),
                    //             // elevation: 2,
                    //             // color: Colors.transparent,
                    //             child: Container(
                    //               decoration: new BoxDecoration(
                    //                 color: Colors.blueGrey,
                    //                 borderRadius: BorderRadius.circular(30),
                    //               ),
                    //               height: 400,
                    //               width: 300,
                    //             ),
                    //           ),
                    //         );
                    //       });
                    // } else {
                    //   return FancyLoader(
                    //     loaderType: "MainGrid",
                    //   );
                    // }
                    return FancyLoader(
                      loaderType: "MainGrid",
                    );
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
                  future: Future.delayed(Duration(seconds: 5), () {}),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    // if (snapshot.hasError) {
                    //   final error = snapshot.error;

                    //   return ErrorPage(error: error.toString());
                    // } else if (snapshot.hasData) {
                    //   return ListView.builder(
                    //       shrinkWrap: true,
                    //       physics: NeverScrollableScrollPhysics(),
                    //       itemCount: 30,
                    //       itemBuilder: (BuildContext context, int index) {
                    //         return Card(
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(10),
                    //           ),
                    //           // elevation: 2,
                    //           // color: Colors.transparent,
                    //           child: Container(
                    //             decoration: new BoxDecoration(
                    //               color: Colors.blueGrey,
                    //               borderRadius: BorderRadius.circular(10),
                    //             ),
                    //             height: 100,
                    //             width: MediaQuery.of(context).size.width,
                    //           ),
                    //         );
                    //       });
                    // } else {
                    //   return FancyLoader(
                    //     loaderType: "MainGrid",
                    //   );
                    // }
                    return Consumer<CategoryNewsListState>(
                        builder: (context, data, child) {
                      return FancyLoader(
                        loaderType:
                            data.getToggleCategoryNewsView() ? "list" : "Grid",
                      );
                    });
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
