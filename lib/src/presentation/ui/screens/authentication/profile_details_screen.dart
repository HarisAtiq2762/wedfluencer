import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:wedfluencer/src/presentation/bloc/user/user_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/wedding_details.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../config/helper.dart';
import '../../templates/buttons.dart';
import '../../templates/checkbox.dart';
import '../../templates/decorations.dart';
import '../../templates/dividers.dart';
import '../../templates/textfields.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  static const routeName = '/profile-details-screen';
  static final firstName = TextEditingController();
  static final lastName = TextEditingController();
  static final userName = TextEditingController();
  static final phoneNumberController = TextEditingController();
  static String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return WedfluencerDecorations.mainContainer(
      context: context,
      heading: 'Enter your Details',
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              WedfluencerTextFields.iconTextField(
                controller: firstName,
                iconData: Icons.person_2_outlined,
                hint: 'First Name',
              ),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.iconTextField(
                controller: lastName,
                iconData: Icons.person_2_outlined,
                hint: 'Last Name',
              ),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.iconTextField(
                controller: userName,
                iconData: Icons.person_2_outlined,
                hint: 'User Name',
              ),
            ],
          ),
        ),
        WedfluencerDividers.transparentDivider(),
        WedfluencerTextFields.phoneNumberField(
          controller: phoneNumberController,
          onInputChanged: (PhoneNumber number) {
            print(number.dialCode);
            print(number.isoCode);
            print(number.phoneNumber);
            phoneNumber = number.phoneNumber!;
          },
        ),
        WedfluencerDividers.transparentDivider(),
        const WedfluencerCheckboxWidget(
            text: 'I hereby accept the T&C of Wedfluencer'),
        WedfluencerDividers.transparentDividerForHeadings(),
        BlocConsumer<UserBloc, UserState>(
          builder: (context, state) {
            return WedfluencerButtons.fullWidthButton(
              text: 'Submit',
              textColor: Colors.white,
              func: () {
                final state = BlocProvider.of<UserBloc>(context).state;
                print('state on profile details');
                print(state);
                // User tempUser;
                // if (state is GotEmailPassword) {
                //   tempUser = state.user;
                // }
                // else if (state is GotUserChoiceForWeddingBusiness) {
                //   tempUser = state.user;
                // } else if (state is GotUserChoiceForGettingMarried) {
                //   tempUser = state.user;
                // } else if (state is OtpVerified) {
                //   tempUser = state.user;
                // } else if (state is GotUserProfileDetails) {
                //   tempUser = state.user;
                // } else if (state is GotUserWeddingDetails) {
                //   tempUser = state.user;
                // } else {
                //   tempUser = user;
                // }
                if (state is GotUserChoiceForGettingMarried) {
                  print(state.user.email);
                  print(state.user.phoneNumber);
                  BlocProvider.of<UserBloc>(context).add(GetUserProfileDetails(
                    firstName: firstName.text,
                    lastName: lastName.text,
                    userName: userName.text,
                    phoneNumber: phoneNumber,
                    user: state.user,
                  ));
                }

                // Navigator.of(context).push(WedfluencerHelper.createRoute(
                //   page: const OtpScreen(isPhoneVerification: true),
                // ));
              },
              buttonColor: ScreenConfig.theme.colorScheme.primary,
              hasIcon: false,
            );
          },
          listener: (context, state) {
            if (state is GotUserProfileDetails) {
              Navigator.of(context).push(WedfluencerHelper.createRoute(
                page: const WeddingDetailsScreen(),
              ));
            }
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
