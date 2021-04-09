import 'package:credilio_news/Screens/Home.dart';
import 'package:credilio_news/Screens/NewsArticle.dart';
import 'package:credilio_news/Screens/Splash.dart';
import 'package:flutter/material.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => Splash());

      case '/Home':
        return MaterialPageRoute(
          builder: (_) => Home(),
        );

      case '/NewsArticle':
        return MaterialPageRoute(
          builder: (_) => NewsArticle(),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
