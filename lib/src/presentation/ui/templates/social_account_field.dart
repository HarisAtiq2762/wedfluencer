import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

class SocialTextfieldWithIcon extends StatelessWidget {
  const SocialTextfieldWithIcon(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.iconPath,
      required this.iconBgColor});

  final TextEditingController controller;
  final String hintText;
  final String iconPath;
  final Color iconBgColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: iconBgColor,
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              height: 30,
              width: 30,
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Flexible(
          child: WedfluencerTextFields.iconTextField(
              hint: hintText,
              controller: controller,
              showIcon: false,
              keyboardType: TextInputType.url),
        ),
      ],
    );
  }
}
