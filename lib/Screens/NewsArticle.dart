import 'package:credilio_news/Screens/RelatedNewsArticles.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

typedef loadURL = String Function(String);

class NewsArticle extends StatefulWidget {
  NewsArticle({this.newsUrl});

  final String newsUrl;

  @override
  _NewsArticleState createState() => _NewsArticleState();
}

class _NewsArticleState extends State<NewsArticle> {
  bool isLoading;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  WebViewController controller;

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
      bottomNavigationBar: RelatedNewsArticles(
        loadurl: loadURL,
      ),
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
                  initialMediaPlaybackPolicy:
                      AutoMediaPlaybackPolicy.always_allow,
                  onPageFinished: (_) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                  onWebViewCreated: (WebViewController webViewController) {
                    controller = webViewController;
                  },
                  initialUrl: widget.newsUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                ),
              ),
            )),
        isLoading ? Center(child: CircularProgressIndicator()) : Container(),
      ],
    );
  }

  loadURL(s) {
    controller.loadUrl(s);
    setState(() {
      isLoading = true;
    });
  }
}
