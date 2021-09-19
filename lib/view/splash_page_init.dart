import 'package:flutter/material.dart';

class PageInicial extends StatefulWidget {
  PageInicial({Key? key}) : super(key: key);

  @override
  _PageInicialState createState() => _PageInicialState();
}

class _PageInicialState extends State<PageInicial> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 3), () => Navigator.pushNamed(context, "/"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.jpg',
              width: MediaQuery.of(context).size.width - 200,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Carregando..."),
            )
          ],
        )));
  }
}
