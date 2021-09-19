import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_stars/requests/acess_token_github.dart';
import 'package:github_stars/view/home.dart';
import 'package:github_stars/view/splash_page_init.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
   await initHiveForFlutter();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black54,
      statusBarIconBrightness: Brightness.light));
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
      routes: {'/': (context) => Home(), 'init': (context) => Init()}));
}

class Init extends StatelessWidget {
  const Init({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      'https://api.github.com/graphql',
    );

    final AuthLink authLink = AuthLink(
        getToken: () async =>
            'Bearer $token');
    final Link link = authLink.concat(httpLink);
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
    return GraphQLProvider(
      client: client,
      child: PageInicial(),
    );
  }
}
