import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageData extends StatelessWidget {
  String iconn;
  final double? width;
  ImageData({Key? key, required this.iconn, this.width = 55}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(iconn,
      width: width! / Get.mediaQuery.devicePixelRatio,);
  }
}
