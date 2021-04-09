import 'dart:io';

import 'package:credilio_news/CommonScreens/AppBarCommon.dart';
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
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 30,
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
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          height: 400,
                          width: 300,
                        ),
                      ),
                    );
                  }),
            ),
          ),
          StickyHeader(
            header: Container(
              color: Colors.white,
              height: 50,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 15, bottom: 10, top: 10),
                      child: Container(
                        child: Text(
                          "Category$index",
                          style: TextStyle(
                              letterSpacing: -1,
                              color: Colors.grey[300],
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                    );
                  }),
            ),
            content: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // elevation: 2,
                      // color: Colors.transparent,
                      child: Container(
                        decoration: new BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
