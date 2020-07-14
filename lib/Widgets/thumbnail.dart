import 'package:flutter/material.dart';
import 'package:selfieapp/Widgets/share_image.dart';
class Thumbnail extends StatelessWidget {
  final String imagePath;

  const Thumbnail({Key key, this.imagePath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
          child: InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext buildContext){
               return ShareImage(imagePath: imagePath,);
          }));
        },
            child: Hero(
              tag: '$imagePath',
                          child: Image.asset(imagePath,
              width: 100,
              height: 75,
              fit: BoxFit.cover,),
            )
      ),
    );
  }
}