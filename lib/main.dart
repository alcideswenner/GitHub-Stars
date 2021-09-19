import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_stars/view/home.dart';
import 'package:github_stars/view/splash_page_init.dart';

void main() async {
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black54,
    statusBarIconBrightness: Brightness.light
  ));
  runApp(MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false, // 1
          systemOverlayStyle: SystemUiOverlayStyle.light, // 2
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: "GitHub Stars",
      initialRoute: 'init',
      routes: {'/': (context) => Home(), 'init': (context) => PageInicial()}));
}

class Init extends StatelessWidget {
  const Init({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageInicial();
  }
}
