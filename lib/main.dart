import 'package:flutter/material.dart';
import 'package:github_stars/view/home.dart';
import 'package:github_stars/view/splash_page_init.dart';

void main() {
  runApp(MaterialApp(
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
