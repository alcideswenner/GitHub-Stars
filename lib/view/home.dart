import 'package:flutter/material.dart';
import 'package:github_stars/models/user.dart';
import 'package:github_stars/requests/acess_token_github.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  TextEditingController textSearch = TextEditingController();
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
            document: gql(body),
            variables: {
              'nlogin': "alcideswenner",
            },
            pollInterval: Duration(seconds: 10),
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              return Text('Loading');
            }
            // it can be either Map or List
            Map<String, dynamic> d = result.data!["user"];
            User users = User.fromJson(d);

            List<User> lista = [];
            lista.add(users);
            //  print(result.data!["user"]["starredRepositories"]["nodes"]);
            return ListView.builder(
                itemCount: lista.length,
                itemBuilder: (context, index) {
                  //final repository = repositories[index];
                  lista[index].starredRepositories!.nodes!.forEach((element) {
                    print(element.name);
                  });
                  if (index == 0) {
                    return cardInfoUser();
                  } else if (index >= 1) {
                    return Text("oi");
                  } else {
                    return SizedBox();
                  }
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget cardInfoUser() {
    return Container(
      height: 250,
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
                //onChanged: onSearchTextChanged,
              ),
              trailing: new IconButton(
                icon: new Icon(Icons.cancel),
                onPressed: () {
                  // controller.clear();
                  // onSearchTextChanged('');
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}
