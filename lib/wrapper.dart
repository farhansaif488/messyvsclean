import 'package:cleanmessy/objdetect/ui/home_view.dart';
import 'package:flutter/material.dart';
import 'cleanmess.dart';

class Wrapper extends StatelessWidget {
  //const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Menu"),
          centerTitle: true,
        ),
        body: ListView(children: <Widget>[
          Card(
            child: ListTile(
              title: Text("Clean or Messy Detection"),
              trailing: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()), //using xc
                  );
                }, //**this line is underlined in red. Error is here**
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Live Object detection"),
              trailing: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeView()),
                  );
                }, //**this line is underlined in red. Error is here**
              ),
            ),
          )
        ]));
  }
}
