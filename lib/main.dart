import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_stars/view/home.dart';
import 'package:github_stars/view/splash_page_init.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  await initHiveForFlutter();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black54,
      statusBarIconBrightness: Brightness.light));
  runApp(MaterialApp(
      theme: ThemeData(
        accentColor: Colors.black,
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false, // 1
          systemOverlayStyle: SystemUiOverlayStyle.light, // 2
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: "GitHub Stars",
      initialRoute: 'init',
      routes: {
        '/': (context) => MyApp(),
        'init': (context) => PageInicial(),
      }));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      'https://api.github.com/graphql',
    );

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer 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',
    );

    final Link link = authLink.concat(httpLink);

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
    return GraphQLProvider(
      client: client,
      child: Home(title: "Git"),
    );
  }
}
