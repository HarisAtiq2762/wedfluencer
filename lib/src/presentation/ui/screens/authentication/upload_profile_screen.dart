import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../config/helper.dart';
import '../../templates/buttons.dart';
import '../../templates/decorations.dart';
import '../../templates/dividers.dart';
import 'otp_screen.dart';

class UploadProfileScreen extends StatefulWidget {
  const UploadProfileScreen({super.key});

  static const routeName = '/upload-profile-screen';

  @override
  State<UploadProfileScreen> createState() => _UploadProfileScreenState();
}

class _UploadProfileScreenState extends State<UploadProfileScreen> {
  late File? imageFile;

  void getImage({required ImageSource src}) async {
    imageFile = await WedfluencerHelper.pickProfileImage(source: src);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WedfluencerDecorations.mainContainer(
      context: context,
      heading: 'Upload Your Profile Picture !',
      children: [
        Container(
          width: ScreenConfig.screenSizeWidth * 0.6,
          height: ScreenConfig.screenSizeHeight * 0.24,
          decoration: ShapeDecoration(
            color: ScreenConfig.theme.colorScheme.secondary.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: imageFile != null
              ? CircleAvatar(backgroundImage: FileImage(imageFile!))
              : Image.asset('assets/images/Background.png'),
        ),
        SizedBox(height: ScreenConfig.screenSizeHeight * 0.04),
        WedfluencerButtons.transparentButton(
          text: 'Choose on gallery',
          iconData: Icons.photo_library_outlined,
          func: () {
            getImage(src: ImageSource.gallery);
          },
        ),
        WedfluencerDividers.transparentDivider(),
        WedfluencerButtons.transparentButton(
          text: 'Take a picture',
          iconData: Icons.camera_alt_outlined,
          func: () {
            getImage(src: ImageSource.camera);
          },
        ),
        WedfluencerDividers.transparentDivider(),
        BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is PhoneOtpSent) {
              Navigator.of(context).push(WedfluencerHelper.createRoute(
                page: const OtpScreen(isPhoneVerification: true),
              ));
            }
          },
          builder: (context, state) {
            if (state is Loading) {
              return const CircularProgressIndicator();
            }
            return WedfluencerButtons.fullWidthButton(
              text: 'Continue',
              textColor: Colors.white,
              func: () {
                final state = BlocProvider.of<UserBloc>(context).state;
                if (state is GotUserWeddingDetails) {
                  BlocProvider.of<UserBloc>(context).add(GetUserPhoneOtp(
                    user: state.user,
                    phoneNumber: state.user.phoneNumber,
                    weddingType: state.weddingType,
                    phone: state.user.phoneNumber,
                    guests: state.guestCount,
                    countryCode:
                        state.user.phoneNumber[0] + state.user.phoneNumber[1],
                    city: state.weddingLocation,
                    weddingDate: state.weddingDate,
                  ));
                }
                // else if (state is GotEmailPassword) {
                //   BlocProvider.of<UserBloc>(context).add(
                //     VerifyOtp(
                //       otp: otp,
                //       isPhone: false,
                //       user: state.user,
                //     ),
                //   );
                // }
              },
              buttonColor: ScreenConfig.theme.colorScheme.primary,
              hasIcon: false,
            );
          },
        ),
        // WedfluencerButtons.fullWidthButton(
        //   text: 'Continue',
        //   textColor: Colors.white,
        //   func: () {
        //     Navigator.of(context).push(
        //       WedfluencerHelper.createRoute(
        //         page: const OtpScreen(isPhoneVerification: true),
        //       ),
        //     );
        //   },
        //   buttonColor: ScreenConfig.theme.colorScheme.primary,
        //   hasIcon: false,
        // ),
        WedfluencerDividers.transparentDivider(),
        WedfluencerButtons.fullWidthButton(
          text: 'Skip',
          textColor: Colors.black,
          buttonColor: Colors.white,
          borderColor: ScreenConfig.theme.primaryColor,
          func: () {
            Navigator.of(context).push(
              WedfluencerHelper.createRoute(
                page: const OtpScreen(isPhoneVerification: true),
              ),
            );
          },
          hasIcon: false,
        ),
      ],
    );
  }
}
