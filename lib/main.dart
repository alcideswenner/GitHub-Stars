import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_stars/requests/acess_token_github.dart';
import 'package:github_stars/view/home.dart';
import 'package:github_stars/view/splash_page_init.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  RemoteConfig.instance.fetchAndActivate();
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
    String token = RemoteConfig.instance.getString("token_git_hub");
    final HttpLink httpLink = HttpLink(
      URL_BASE,
    );

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer $token',
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
      child: Home(title: "GitHub Stars"),
    );
  }
}
