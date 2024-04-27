import 'package:flutter/material.dart';

import '../custom_image_widget.dart';

class ProfileImageWidget extends StatelessWidget {
  final String imageUrl;
  final double radius;
  const ProfileImageWidget({super.key,required this.imageUrl,this.radius = 60});

  @override
  Widget build(BuildContext context) {
    return  CustomImageWidget(imageUrl: imageUrl,height: radius,width: radius,radius: 1000,);
  }
}