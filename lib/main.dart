import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(new MaterialApp(
    title: "Camera App",
    home: LoadingScreen()
  ));
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  PickedFile imageFile;
  final ImagePicker _picker = ImagePicker();

  _openGallery(BuildContext context) async{
     imageFile = await _picker.getImage(source: ImageSource.gallery, maxWidth: 400, maxHeight: 400);
//    this.setState(() {
//      imageFile = picture;
//    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async{
    imageFile = await _picker.getImage(source: ImageSource.camera, maxWidth: 400, maxHeight: 400);
//    this.setState(() {
//      imageFile = picture;
//    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Make a choice"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text('Gallery'),
                onTap: () {
                  _openGallery(context);
                }
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                  child: Text('Camera'),
                  onTap: () {
                    _openCamera(context);
                  }
              )
            ],
          )
        )
      );
    });
  }

  Widget _decideImageView(){
    if(imageFile == null){
      return Text('No Image Selected!');
    } else {
//    Image.file(imageFile, width: 400, height: 400);
      Image.file(File(imageFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
          body: Container(
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _decideImageView(),
              RaisedButton(onPressed: () {
                _showChoiceDialog(context);
              }, child: Text('Select Image!'),)
            ],
    ),
        )
    )
    );
  }
}


