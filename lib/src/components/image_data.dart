import 'package:flutter/material.dart';

class ImageData extends StatelessWidget {
  String icon;
  final double? width;
  ImageData(
    this.icon, {
      Key? key,this.width=55,
    }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      icon,
      width: width!/MediaQuery.of(context).devicePixelRatio
    );
  }
}


class IconsPath{
  static String get cse => 'assets/images/cse_img.png';

}
