import 'package:credilio_news/CommonScreens/FancyLoader.dart';
import 'package:flutter/material.dart';

class RelatedNewsArticles extends StatefulWidget {
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
                    "Related Articles",
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
                    future: Future.delayed(Duration(seconds: 5), () {}),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
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
                        loaderType: "HorizontalCards",
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
