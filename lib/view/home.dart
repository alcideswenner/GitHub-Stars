import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarTextStyle: TextStyle(color: Colors.white),
        backgroundColor: Colors.black87,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text("GitHub Stars"),
      ),
      body: cardInfoUser(),
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
