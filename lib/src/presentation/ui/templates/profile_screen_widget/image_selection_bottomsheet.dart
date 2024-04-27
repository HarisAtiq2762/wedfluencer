import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../config/helper.dart';

class ImageSourceSelectionBottomSheet extends StatelessWidget {
  const ImageSourceSelectionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 4),
          BottomSheetTile(
            title: 'Camera',
            iconData: Icons.camera,
            onTap: () {
              _pickImage(context: context, source: ImageSource.camera);
            },
          ),
          BottomSheetTile(
            title: 'Gallery',
            iconData: Icons.photo,
            onTap: () {
              _pickImage(context: context, source: ImageSource.gallery);
            },
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  

  _pickImage({required BuildContext context, required ImageSource source}) {
    WedfluencerHelper.pickProfileImage(source: source, title: 'Edit profile image')
        .then((image) {
      Navigator.pop(context, image);
    });
  }
}



class BottomSheetTile extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function() onTap;
  const BottomSheetTile({
    super.key,
    required this.title,
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        leading: Icon(iconData),
        title: Text(title,  style: ScreenConfig.theme.textTheme.bodySmall?.copyWith(
            color: const Color(0xFF121212),
          ),),
        onTap: onTap);
  }
}
