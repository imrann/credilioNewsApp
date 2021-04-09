import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'Home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('/Home', arguments: Home());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Shimmer.fromColors(
                      baseColor: Colors.greenAccent,
                      period: Duration(milliseconds: 1000),
                      highlightColor: Colors.white,
                      child: Text(
                        'CREDILIO',
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            letterSpacing: -2,
                            fontSize: 60.0,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'NEWS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12.0,
                      wordSpacing: 1,
                      fontStyle: FontStyle.italic),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
