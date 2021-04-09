import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FancyLoader extends StatelessWidget {
  FancyLoader({this.loaderType, this.lines});

  final String loaderType;
  final int lines;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      period: Duration(milliseconds: 500),
      highlightColor: Colors.white,
      child: getLoaderType(loaderType: loaderType, lines: lines),
    );
  }

  Widget getLoaderType({String loaderType, int lines}) {
    switch (loaderType) {
      case "list":
        {
          return getListLoader();
        }
        break;

      case "MainGrid":
        {
          return getMainGridLoader();
        }
        break;

      case "HorizontalCards":
        {
          return getHorizontalCardLoader();
        }
        break;
      case "Grid":
        {
          return getGridLoader();
        }
        break;

      default:
        {
          return getLogoLoader();
        }
        break;
    }
  }

  Widget getLogoLoader() {
    return Center(
      child: Text(
        'CREDILIO',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.grey[300],
            fontSize: 50.0,
            fontWeight: FontWeight.bold,
            wordSpacing: 2,
            fontStyle: FontStyle.italic),
      ),
    );
  }

  Widget getMainGridLoader() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
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
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30),
                ),
                height: 400,
                width: 300,
              ),
            ),
          );
        });
  }

  Widget getHorizontalCardLoader() {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: ClampingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            // elevation: 2,
            // color: Colors.transparent,
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              height: 120,
              width: MediaQuery.of(context).size.width * 0.9,
            ),
          );
        });
  }

  Widget getListLoader() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            // elevation: 2,
            // color: Colors.transparent,
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              height: 100,
              width: MediaQuery.of(context).size.width,
            ),
          );
        });
  }

  Widget getGridLoader() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.7),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          child: Card(
            color: Colors.grey[300],
          ),
        );
      },
    );
  }
}
