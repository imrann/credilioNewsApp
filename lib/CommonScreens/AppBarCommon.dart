import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

bool l_isSearch;
String selectedDateTime;

class AppBarCommon extends StatefulWidget implements PreferredSizeWidget {
  AppBarCommon(
      {this.title,
      this.subTitle,
      this.trailingIcon,
      this.profileIcon,
      this.centerTile,
      this.context,
      this.route,
      this.notificationCount,
      this.isTabBar,
      this.isSearch,
      this.searchOwner,
      this.tabController});

  final Widget title;
  final Widget subTitle;
  final IconData trailingIcon;
  final IconData profileIcon;
  final bool centerTile;
  final BuildContext context;
  final Widget route;
  final Widget notificationCount;
  final bool isTabBar;
  final bool isSearch;
  final String searchOwner;
  final TabController tabController;

  @override
  _AppBarCommonState createState() => _AppBarCommonState();
  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _AppBarCommonState extends State<AppBarCommon> {
  @override
  void initState() {
    super.initState();
    l_isSearch = widget.isSearch;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: getTabBar(isTabBar: widget.isTabBar),
      centerTitle: widget.centerTile,
      elevation: 0.0,
      // backgroundColor:Theme.of(context).primaryColor,
      title: l_isSearch != null
          ? getSearchBox()
          : getTitle(title: widget.title, subTitle: widget.subTitle),
      actions: <Widget>[
        SizedBox(width: 5),
        getIcon(widget.profileIcon, context, widget.route,
            widget.notificationCount),
        l_isSearch != null
            ? getIcon(Icons.close, context, null, null)
            : getIcon(widget.trailingIcon, context, widget.route,
                widget.notificationCount),
      ],
      bottomOpacity: 1,
      backgroundColor:
          widget.searchOwner == "pDetails" ? Colors.transparent : Colors.white,
      brightness: Brightness.light,
    );
  }

  Widget getSearchBox() {
    return TextFormField(
      cursorColor: Colors.black,
      autofocus: true,
      readOnly: false,
      validator: null,
      enabled: true,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        hintText: "Search...",
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
      ),
      keyboardType: TextInputType.text,
      onChanged: (text) {
        // searchStart(dynamicSearchText: text, listAllData: false);
      },
    );
  }

  PreferredSizeWidget getTabBar({bool isTabBar}) {
    if (isTabBar) {
      return null;
    } else {
      return null;
    }
  }

  Widget getIcon(IconData icon, BuildContext context, Widget route,
      Widget notificationCount) {
    if (null != icon) {
      return new Container(
        child: Row(
          children: <Widget>[
            InkWell(
              borderRadius: BorderRadius.circular(100),
              child: Icon(icon),
              onTap: () async {
                if (icon == Icons.search) {
                  print("search");
                  setState(() {
                    l_isSearch = true;
                  });
                } else if (icon == Icons.close) {
                  print("close search");

                  setState(() {
                    l_isSearch = null;
                  });
                }

                //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Maintainance()),);
              },
            ),
            SizedBox(width: 15),
          ],
        ),
      );
    } else {
      return SizedBox(width: 0);
    }
  }

  Widget getTitle({Widget title, Widget subTitle}) {
    if (title != null && subTitle != null) {
      return new Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[title],
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[subTitle],
            )
          ],
        ),
      );
    } else if (title != null && subTitle == null) {
      return Container(
        child: title,
      );
    } else {
      return new Text("");
    }
  }
}
