import 'package:flutter/material.dart';
import 'package:selfieapp/Widgets/thumbnail.dart';
class Gallery extends StatelessWidget {
  final List<String> imagePaths;

  const Gallery({Key key, this.imagePaths}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: imagePaths.length,
      itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Thumbnail(imagePath: imagePaths[index],),
        );
      },

    );
  }
}