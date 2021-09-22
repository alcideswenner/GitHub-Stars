import 'package:flutter/material.dart';
import 'package:github_stars/models/user.dart';
import 'package:github_stars/requests/acess_token_github.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  Color colorWhite = Colors.white;
  TextEditingController textSearch = TextEditingController();
  String loginBusca = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(widget.title),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Query(
          options: QueryOptions(
            document: gql(body),
            variables: {
              'nlogin': loginBusca,
            },
            pollInterval: Duration(seconds: 2),
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return SingleChildScrollView(
                child: cardInfoUser(new User()),
              );
            }
            if (result.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            // it can be either Map or List
            Map<String, dynamic> d = result.data!["user"];
            User users = User.fromJson(d);

            List<Nodes> lista = users.starredRepositories!.nodes!.toList();

            return SingleChildScrollView(
              child: Column(
                children: [
                  cardInfoUser(users),
                  SizedBox(
                    height: 20,
                  ),
                  listRespositories(lista),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await canLaunch("https://github.com/Xerpa")
            ? await launch("https://github.com/Xerpa")
            : throw 'Could not launch ',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget cardInfoUser(User user) {
    return Container(
      height: user.name == null ? MediaQuery.of(context).size.height : null,
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
        color: Colors.black87,
      ),
      child: Container(
          child: Column(
        children: [
          new Card(
            child: new ListTile(
              leading: new Icon(Icons.search),
              title: new TextField(
                controller: textSearch,
                maxLines: 1,
                //controller: controller,
                decoration: new InputDecoration(
                    hintText: 'Digite o nome do usuário',
                    border: InputBorder.none),
              ),
              trailing: new IconButton(
                icon: new Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    loginBusca = textSearch.text;
                  });
                },
              ),
            ),
          ),
          user.name == null
              ? Text("")
              : ListTile(
                  contentPadding: EdgeInsets.only(top: 10),
                  leading: CircleAvatar(
                    maxRadius: 25,
                    backgroundColor: colorWhite,
                    backgroundImage: NetworkImage(user.avatarUrl.toString()),
                  ),
                  title: Text(user.name.toString(),
                      style: TextStyle(
                          color: colorWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.bio.toString(),
                          style: TextStyle(color: colorWhite)),
                      GestureDetector(
                        onTap: () async => await canLaunch(user.url.toString())
                            ? await launch(user.url.toString())
                            : throw 'Could not launch',
                        child: Text(user.url.toString(),
                            style: TextStyle(color: Colors.blue, fontSize: 14)),
                      )
                    ],
                  )),
          user.name == null
              ? Text("")
              : ListTile(
                  title: Text(user.location.toString(),
                      style: TextStyle(color: colorWhite)),
                  subtitle: Text(user.email.toString(),
                      style: TextStyle(color: colorWhite)),
                  trailing: Column(
                    children: [
                      Icon(
                        Icons.stars,
                        color: colorWhite,
                      ),
                      Text(user.starredRepositories!.totalCount.toString(),
                          style: TextStyle(color: colorWhite))
                    ],
                  ),
                ),
          user.name == null
              ? SizedBox(
                  height: 60,
                )
              : Text(""),
          user.name == null
              ? Column(
                  children: [
                    Image.asset(
                      'assets/logo_2.png',
                      width: MediaQuery.of(context).size.width - 200,
                    ),
                    Center(
                      child: Text("Pesquise um usuário",
                          style: TextStyle(color: colorWhite, fontSize: 20)),
                    )
                  ],
                )
              : Text("")
        ],
      )),
    );
  }

  Widget listRespositories(List<Nodes> lista) {
    return Container(
      // height: MediaQuery.of(context).size.height - 100,
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: lista.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                lista[index].name.toString(),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                lista[index].description.toString(),
                style: TextStyle(color: Colors.black),
              ),
              trailing: Column(
                children: [
                  Icon(
                    Icons.stars,
                    color: Colors.black,
                  ),
                  Text(
                    lista[index].stargazers!.totalCount.toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
