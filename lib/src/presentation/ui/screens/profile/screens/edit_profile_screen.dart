import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wedfluencer/src/presentation/ui/screens/profile/widgets/profile_image_widget.dart';
import 'package:wedfluencer/src/presentation/ui/templates/buttons.dart';

import '../../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../../templates/dividers.dart';
import '../../../templates/textfields.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _firstNameController,
      _lastNameController,
      _userNameController,
      _emailController,
      _phoneController,
      _bioController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _userNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _bioController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Column(
              children: [
                const ProfileImageWidget(
                  imageUrl:
                      'https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-600nw-1714666150.jpg',
                  radius: 100,
                ),
                WedfluencerTextFields.iconTextField(
                    hint: 'First Name',
                    controller: _firstNameController,
                    iconData: Icons.perm_identity,
                    keyboardType: TextInputType.name),
                WedfluencerDividers.transparentDivider(),
                WedfluencerTextFields.iconTextField(
                    hint: 'Last Name',
                    controller: _lastNameController,
                    iconData: Icons.perm_identity,
                    keyboardType: TextInputType.name),
                WedfluencerDividers.transparentDivider(),
                WedfluencerTextFields.iconTextField(
                    hint: 'Username',
                    controller: _userNameController,
                    iconData: Icons.perm_identity,
                    keyboardType: TextInputType.name),
                WedfluencerDividers.transparentDivider(),
                WedfluencerTextFields.iconTextField(
                    hint: 'Email ',
                    controller: _emailController,
                    iconData: Icons.email_rounded,
                    keyboardType: TextInputType.emailAddress),
                WedfluencerDividers.transparentDivider(),
                WedfluencerTextFields.iconTextField(
                    hint: 'Phone Number',
                    controller: _phoneController,
                    iconData: Icons.phone_android_rounded,
                    keyboardType: TextInputType.phone),
                WedfluencerDividers.transparentDivider(),
                WedfluencerTextFields.multilineTextField(
                    hint: 'Bio',
                    controller: _bioController,
                    ),
              ],
            ),
            WedfluencerDividers.transparentDivider(),
            WedfluencerButtons.fullWidthButton(
              buttonColor: ScreenConfig.theme.colorScheme.primary,
              hasIcon: false,
              text: 'Save Changes',
              textColor: Colors.white,
              widthMultiplier: 1,
              func: () {},
            ),
            WedfluencerDividers.spacingForScreenEnd(),
          ],
        ),
      ),
    );
  }
}
