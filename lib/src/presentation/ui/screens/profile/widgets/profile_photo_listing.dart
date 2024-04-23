import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/templates/custom_image_widget.dart';

class ProfilePhotoListingWidget extends StatelessWidget {
  const ProfilePhotoListingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 1,crossAxisSpacing: 4, mainAxisSpacing: 4),
      itemCount: 40,
      itemBuilder: (context,index){
        return  Container(color: Colors.blue,child: 
        const CustomImageWidget(
          height: 100,width: 100,
          imageUrl: 'https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-600nw-1714666150.jpg',)
      );  },
    );
  }
}