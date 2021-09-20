import 'package:flutter/material.dart';
import 'package:github_stars/componentes/search_data.dart';
import 'package:github_stars/models/user.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
    String readRepositories = """
   query ReadRepositories(\$nlogin: String!) {
  user(login:\$nlogin){
    name
    avatarUrl
    bio
    location
    email
    url
    starredRepositories{
      totalCount
      nodes{
        name
        description
       stargazers{
        totalCount
      }
      }
    }
}
    
}

""";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(widget.title),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Query(
          options: QueryOptions(
            document: gql(readRepositories),
            variables: {
              'nlogin': loginBusca,
            },
            pollInterval: Duration(seconds: 10),
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return cardInfoUser(new User());
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

            //  print(result.data!["user"]["starredRepositories"]["nodes"]);
            return SingleChildScrollView(
              child: Column(
                children: [
                  cardInfoUser(users),
                  Container(
                    height: MediaQuery.of(context).size.height - 100,
                    child: ListView.builder(
                        itemCount: lista.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              lista[index].name.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              lista[index].description.toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                            trailing: Column(
                              children: [
                                Icon(Icons.stars),
                                Text(
                                  lista[index]
                                      .stargazers!
                                      .totalCount
                                      .toString(),
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget cardInfoUser(User user) {
    return Container(
      //  height: 250,
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      //    width: MediaQuery.of(context).size.width - 50,
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
                    hintText: 'Buscar', border: InputBorder.none),
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
                  leading: CircleAvatar(
                    maxRadius: 25,
                    backgroundColor: colorWhite,
                    backgroundImage: NetworkImage(user.avatarUrl.toString()),
                  ),
                  title: Text(user.name.toString(),
                      style: TextStyle(color: colorWhite)),
                  subtitle: Text(user.bio.toString(),
                      style: TextStyle(color: colorWhite)),
                ),
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
        ],
      )),
    );
  }
}
