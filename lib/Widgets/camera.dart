import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:selfieapp/api/storage.dart';

class Camera extends StatefulWidget {
  final Function() captureCallback;

  const Camera({Key key, this.captureCallback}) : super(key: key);
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  List<CameraDescription> cameras;
  CameraController controller;
  bool isInitialized = false;
  void _initializeCamera() {
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {
        isInitialized = true;
      });
    });
  }

  _getCameras() async {
    cameras = await availableCameras();
    if (cameras.length > 0) _initializeCamera();
  }

  @override
  void initState() {
    super.initState();
    _getCameras();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
   Future<String> _captureImage() async{
     print('Capturing image');
     var path=await Storage.getFilePath();
     var completer=Completer<String>();
     if(!controller.value.isTakingPicture){
       try{
         await  controller.takePicture(path);
         print(path);
         widget.captureCallback();
           completer.complete(path);
       }on CameraException catch(e){
         print('Error is  ---------$e');
         throw Exception('$e');
       }
     }
     return completer.future;
   }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final deviceratio=size.width/size.height;
    if (!isInitialized)
      return Container();
    else
      return Stack(
        children: <Widget>[
          Transform.scale(
           scale: controller.value.aspectRatio/deviceratio,
           child: Center(
             child: AspectRatio(
               aspectRatio: controller.value.aspectRatio,
               child: CameraPreview(controller),
             ),
           ),
          ),
          Center(
            child: FloatingActionButton(
              child: Icon(
                Icons.camera_alt,
                size: 36.0,
              ),
              onPressed: () {_captureImage();},
            ),
          )
        ],
      );
  }
}
