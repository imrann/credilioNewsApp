import 'package:credilio_news/StateManager/BreakingNewListState.dart';
import 'package:credilio_news/StateManager/CategoryNewsListState.dart';
import 'package:credilio_news/StateManager/WebViewDetailsState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'CommonScreens/RouterGenerator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(136, 14, 79, .1),
      100: Color.fromRGBO(136, 14, 79, .2),
      200: Color.fromRGBO(136, 14, 79, .3),
      300: Color.fromRGBO(136, 14, 79, .4),
      400: Color.fromRGBO(136, 14, 79, .5),
      500: Color.fromRGBO(136, 14, 79, .6),
      600: Color.fromRGBO(136, 14, 79, .7),
      700: Color.fromRGBO(136, 14, 79, .8),
      800: Color.fromRGBO(136, 14, 79, .9),
      900: Color.fromRGBO(136, 14, 79, 1),
    };
    MaterialColor colorCustom = MaterialColor(0xFFffffff, color);
    MaterialColor colorCustom1 = MaterialColor(0xFFf48fb1, color);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CategoryNewsListState()),
          ChangeNotifierProvider(create: (context) => BreakingNewListState()),
          ChangeNotifierProvider(create: (context) => WebViewDetailsState()),
        ],
        child: MaterialApp(
          onGenerateRoute: RouterGenerator.generateRoute,
          title: 'CREDILIO',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: colorCustom,
            accentColor: colorCustom1,
          ),
          initialRoute: "/",
        ));
  }
}
