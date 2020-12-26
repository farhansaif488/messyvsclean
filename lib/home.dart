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

    loadModel().then((value) {});
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickGalleryImage() async{
    var image = await picker.getImage(source: ImageSource.gallery)
    if(image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  classifyImage(File image)async{
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5
      );
      setState(() {
        _loading = false;
        _output = output;
      });
  }

  loadMode() async{
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}

class _GroupText extends StatelessWidget {
  const _GroupText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}

class _SpaceLine extends StatelessWidget {
  const _SpaceLine({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}
