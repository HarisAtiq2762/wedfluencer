import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/user/user_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/otp_screen.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../config/globals.dart';
import '../../config/helper.dart';
import '../../templates/buttons.dart';
import '../../templates/checkbox.dart';
import '../../templates/decorations.dart';
import '../../templates/dividers.dart';
import '../../templates/textfields.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});
  static const routeName = '/profile-details-screen';

  @override
  Widget build(BuildContext context) {
    final firstName = TextEditingController();
    final lastName = TextEditingController();
    final userName = TextEditingController();
    final phoneNumber = TextEditingController();
    return WedfluencerDecorations.mainContainer(
      context: context,
      heading: 'Enter your Details',
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
        WedfluencerDividers.transparentDivider(),
        WedfluencerTextFields.phoneNumberField(controller: phoneNumber),
        WedfluencerDividers.transparentDivider(),
        const WedfluencerCheckboxWidget(
            text: 'I hereby accept the T&C of Wedfluencer'),
        WedfluencerDividers.transparentDividerForHeadings(),
        WedfluencerButtons.fullWidthButton(
          text: 'Submit',
          textColor: Colors.white,
          func: () {
            final state = BlocProvider.of<UserBloc>(context).state;
            BlocProvider.of<UserBloc>(context).add(GetUserProfileDetails(
              firstName: firstName.text,
              lastName: lastName.text,
              userName: userName.text,
              phoneNumber: phoneNumber.text,
              user: state is GotUserChoiceForGettingMarried ? state.user : user,
            ));
            Navigator.of(context).push(WedfluencerHelper.createRoute(
              page: const OtpScreen(isPhoneVerification: true),
            ));
          },
          buttonColor: ScreenConfig.theme.colorScheme.primary,
          hasIcon: false,
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
