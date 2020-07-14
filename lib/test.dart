import 'package:flutter/material.dart';
import 'package:selfieapp/api/storage.dart';
class Test extends StatelessWidget {
  const Test({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context)  {
    Future<String> tes=Storage.getFilePath();
    tes.then((value) => print(value));
    return Container();
  
  }
}