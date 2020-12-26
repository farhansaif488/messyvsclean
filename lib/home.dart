import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import 'dart:io';

class Home extends StatefulWidget {
  //Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final picker = ImagePicker();
  File _image;

  bool _loading = false;

  List _output;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      print("XXXXX");
    });
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  Future pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  Future pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  classifyImage(File image) async {
    print("gg");
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _loading = false;
      _output = output;
    });
    print("loading ");
    print(_loading);
  }

  Future loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  Widget build(BuildContext context) {
    //initState();
    return Scaffold(
        appBar: AppBar(
          title: Text("Clean Or Messy"),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _GroupText('Choose Source:'),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    buttonMinWidth: 150,
                    layoutBehavior: ButtonBarLayoutBehavior.padded,
                    buttonPadding: EdgeInsets.symmetric(vertical: 10),
                    children: <Widget>[
                      RaisedButton(
                        onPressed: pickImage,
                        child: Text('Cam'),
                      ),
                      SizedBox(width: 20),
                      RaisedButton(
                        onPressed: pickGalleryImage,
                        child: Text("Gallery"),
                      )
                    ],
                  ),
                ],
              ),
              _SpaceLine(),
              Center(
                  child: _loading
                      ? Container(
                          width: 300,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 50),
                              Image.asset('assets/room.png'),
                            ],
                          ),
                        )
                      : Container(
                          child: Column(
                            children: <Widget>[
                              _output != null
                                  ? Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        '${_output[0]['label']}',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 20.0),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(height: 20),
                              Container(
                                height: 250,
                                child: Image.file(_image),
                              ),
                            ],
                          ),
                        ))
            ],
          )),
        ));
  }
}

class _GroupText extends StatelessWidget {
  //const _GroupText({Key key}) : super(key: key);
  final String text;
  const _GroupText(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Text(
        text,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _SpaceLine extends StatelessWidget {
  //const _SpaceLine({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 5,
        child: Container(
          color: Colors.grey,
        ));
  }
}
