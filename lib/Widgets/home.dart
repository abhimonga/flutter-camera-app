import 'package:flutter/material.dart';
import 'package:selfieapp/Widgets/camera.dart';
import 'package:selfieapp/Widgets/gallery.dart';
import 'package:selfieapp/api/storage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   List<String> _paths = [];
  void _updateGallery(){
    Storage.getFilePaths.then((paths){
         setState(() {
           _paths=paths;
         });
    });
  }
  @override
  void initState() {
    super.initState();
    Storage.getFilePaths.then((paths){
      _paths=paths;
    } );
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Camera(
         captureCallback: _updateGallery,
        ),
        Align(
          alignment: Alignment(0, 0.95),
          child: Container(
              height: 100.0,
              child: Gallery(
                imagePaths: _paths,
              )),
        )
      ],
    );
  }
}
