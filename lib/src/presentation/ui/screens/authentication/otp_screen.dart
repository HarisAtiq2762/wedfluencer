import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:wedfluencer/src/infrastructure/domain/create_vendor/vendor_dto.dart';
import 'package:wedfluencer/src/infrastructure/resources/vendor/vendor_repository.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/profile_details_screen.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/questions.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/user_category.dart';
import '../../../../infrastructure/domain/create_vendor/vendor_repository.dart';
import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../config/helper.dart';
import '../../templates/buttons.dart';
import '../../templates/decorations.dart';
import '../../templates/dividers.dart';
import '../../templates/snackbar.dart';
import '../brideGroomFlow/home.dart';

class OtpScreen extends StatelessWidget {
  final bool isPhoneVerification;
  final VendorDTO? vendorDto;

  const OtpScreen(
      {super.key, required this.isPhoneVerification, this.vendorDto});

  static const routeName = '/otp-screen';
  static String otp = '';

  @override
  Widget build(BuildContext context) {
    return WedfluencerDecorations.mainContainer(
      context: context,
      heading:
          isPhoneVerification ? 'Number Verification' : 'E-mail Verification',
      children: [
        OtpTextField(
          numberOfFields: 6,
          showFieldAsBox: false,
          borderWidth: 4.0,
          focusedBorderColor: ScreenConfig.theme.primaryColor,
          borderColor: ScreenConfig.theme.primaryColor,
          onCodeChanged: (String code) {},
          onSubmit: (String verificationCode) {
            print(verificationCode);
            otp = verificationCode;
          },
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
        BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            print('state on otp screen');
            print(state);
            if (state is UserLoggedIn) {
              Navigator.of(context).push(
                WedfluencerHelper.createRoute(
                  page: const HomeScreen(),
                ),
              );
            } else if (state is GotError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(WedfluencerSnackBar.showSnackBar(state.error));
            } else if (state is OtpVerified) {
              Navigator.of(context).push(
                WedfluencerHelper.createRoute(
                  page: const QuestionsScreen(
                    question: 'Are You In The Wedding Business ?',
                    askingAboutBusiness: true,
                    yes: UserCategoryScreen(),
                    no: QuestionsScreen(
                      question: 'Are You Getting Married ?',
                      askingAboutBusiness: false,
                      yes: ProfileDetailsScreen(),
                      no: ProfileDetailsScreen(),
                    ),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is Loading) {
              return const CircularProgressIndicator();
            }
            return WedfluencerButtons.fullWidthButton(
              text: 'Submit',
              textColor: Colors.white,
              func: () {
                if (vendorDto != null) {
                  final vendorRepo = VendorCreationRepository()
                      .createVendor(vendorDto!, otp, context);
                } else {
                  final state = BlocProvider.of<UserBloc>(context).state;
                  print(state);
                  if (state is PhoneOtpSent) {
                    BlocProvider.of<UserBloc>(context)
                        .add(VerifyPhoneOtpAndRegister(
                      otp: otp,
                      guests: state.guests,
                      user: state.user,
                      phoneNumber: state.phoneNumber,
                      weddingType: state.weddingType,
                      phone: state.phone,
                      countryCode: state.countryCode,
                      city: state.city,
                      weddingDate: state.weddingDate,
                    ));
                  } else if (state is GotEmailPassword) {
                    BlocProvider.of<UserBloc>(context).add(
                      VerifyOtp(
                        otp: otp,
                        isPhone: false,
                        user: state.user,
                      ),
                    );
                  }
                }
              },
              buttonColor: ScreenConfig.theme.colorScheme.primary,
              hasIcon: false,
            );
          },
        ),
        WedfluencerDividers.transparentDivider(),
        WedfluencerButtons.fullWidthButton(
          text: 'Back',
          textColor: Colors.black,
          buttonColor: Colors.white,
          borderColor: ScreenConfig.theme.primaryColor,
          func: () {
            Navigator.pop(context);
          },
          hasIcon: false,
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
      ],
    );
  }
}
