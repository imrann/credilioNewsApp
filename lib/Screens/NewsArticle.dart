import 'dart:async';

import 'package:credilio_news/CommonScreens/AppBarCommon.dart';
import 'package:credilio_news/CommonScreens/FancyLoader.dart';
import 'package:credilio_news/Screens/RelatedNewsArticles.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsArticle extends StatefulWidget {
  @override
  _NewsArticleState createState() => _NewsArticleState();
}

class _NewsArticleState extends State<NewsArticle> {
  bool isLoading;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: null,
      body: getWebView(),
      bottomNavigationBar: RelatedNewsArticles(),
    );
  }

  getWebView() {
    return Stack(
      children: <Widget>[
        Positioned(
            top: 30,
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(
              child: Container(
                child: WebView(
                  onPageFinished: (_) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                  initialUrl:
                      "https://indianexpress.com/article/india/us-navy-freedom-of-navigation-operation-india-waters-without-consent-7265898/",
                  javascriptMode: JavascriptMode.unrestricted,
                  // onWebViewCreated: (WebViewController c) {
                  //   _controller = c;
                  // },
                ),
              ),
            )),
        isLoading ? Center(child: CircularProgressIndicator()) : Container(),
      ],
    );
  }
}
