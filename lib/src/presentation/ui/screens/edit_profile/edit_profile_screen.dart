import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/auth_repository.dart';
import 'package:wedfluencer/src/infrastructure/resources/user/user_provider.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/ui/templates/buttons.dart';

import '../../templates/dividers.dart';
import '../../templates/khairyat_appbar.dart';
import '../../templates/profile_screen_widget/profile_image_picker.dart';
import '../../templates/textfields.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _fullNameController,
      _userNameController,
      _emailController,
      _phoneController,
      _bioController;

  File? file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fullNameController =
        TextEditingController(text: DI.i<AuthRepository>().user!.getFullName);
    _userNameController =
        TextEditingController(text: DI.i<AuthRepository>().user!.userName);
    _emailController =
        TextEditingController(text: DI.i<AuthRepository>().user!.email);
    _phoneController =
        TextEditingController(text: DI.i<AuthRepository>().user!.phonenumber);
    _bioController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
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
      appBar: WedfluencerAppbar.generalAppbar(
        showBackButton: true,
        context: context,
        title: 'Edit Profile',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Column(
              children: [
                WedfluencerDividers.transparentDivider(),
                ProfileImagePicker(
                  imageUrl: DI.i<AuthRepository>().user!.profileImage != null
                      ? DI.i<AuthRepository>().user!.profileImage!.imageUrl
                      : 'https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-600nw-1714666150.jpg',
                  onChnage: (image) {
                    file = image;
                  },
                ),
                WedfluencerDividers.transparentDivider(),
                WedfluencerTextFields.iconTextField(
                    hint: 'Full Name',
                    controller: _fullNameController,
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
                WedfluencerTextFields.iconTextField(
                    hint: 'Bio',
                    controller: _bioController,
                    maxlines: 4,
                    showIcon: false),
              ],
            ),
            WedfluencerDividers.transparentDivider(),
            WedfluencerButtons.fullWidthButton(
              buttonColor: ScreenConfig.theme.colorScheme.primary,
              hasIcon: false,
              text: 'Save Changes',
              textColor: Colors.white,
              widthMultiplier: 1,
              func: () async {
                await UserProvider().updateProfilePic(file: file!);
              },
            ),
            WedfluencerDividers.spacingForScreenEnd(),
          ],
        ),
      ),
    );
  }
}
