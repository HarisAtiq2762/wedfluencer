import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/models/user.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../config/helper.dart';
import '../../templates/buttons.dart';
import '../../templates/decorations.dart';
import '../../templates/dividers.dart';

class QuestionsScreen extends StatelessWidget {
  final String question;
  final Widget yes;
  final Widget no;
  final bool askingAboutBusiness;

  const QuestionsScreen(
      {super.key,
      required this.question,
      required this.yes,
      required this.no,
      required this.askingAboutBusiness});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        User user = User(
          email: 'email',
          password: 'password',
          isInWeddingBusiness: false,
          isGettingMarried: false,
          firstName: 'firstName',
          lastName: 'lastName',
          userName: 'userName',
          phoneNumber: 'phoneNumber',
        );
        if (state is GotEmailPassword) {
          user = state.user;
        } else if (state is GotUserChoiceForWeddingBusiness) {
          user = state.user;
        } else if (state is GotUserChoiceForGettingMarried) {
          user = state.user;
        }
        return WedfluencerDecorations.mainContainer(
          showBackButton: false,
          context: context,
          heading: question,
          showHeading: false,
          children: [
            SizedBox(height: ScreenConfig.screenSizeHeight * 0.1),
            WedfluencerDividers.transparentDividerForHeadings(),
            Text(question, style: ScreenConfig.theme.textTheme.bodyMedium),
            WedfluencerDividers.transparentDividerForHeadings(),
            WedfluencerDividers.transparentDividerForHeadings(),
            WedfluencerDividers.transparentDividerForHeadings(),
            WedfluencerButtons.fullWidthButton(
              text: 'Yes',
              textColor: Colors.white,
              func: () {
                if (askingAboutBusiness) {
                  BlocProvider.of<UserBloc>(context).add(
                    GetUserChoiceForWeddingBusiness(
                      isInWeddingBusiness: true,
                      user: user,
                    ),
                  );
                } else {
                  BlocProvider.of<UserBloc>(context).add(
                    GetUserChoiceForGettingMarried(
                      isGettingMarried: true,
                      user: user,
                    ),
                  );
                }
                Navigator.of(context).push(
                  WedfluencerHelper.createRoute(
                    page: yes,
                  ),
                );
              },
              buttonColor: ScreenConfig.theme.colorScheme.primary,
              hasIcon: false,
            ),
            WedfluencerDividers.transparentDivider(),
            WedfluencerButtons.fullWidthButton(
              text: 'No',
              textColor: Colors.black,
              buttonColor: Colors.white,
              borderColor: ScreenConfig.theme.primaryColor,
              func: () {
                if (askingAboutBusiness) {
                  BlocProvider.of<UserBloc>(context).add(
                    GetUserChoiceForWeddingBusiness(
                      isInWeddingBusiness: false,
                      user: user,
                    ),
                  );
                } else {
                  BlocProvider.of<UserBloc>(context).add(
                    GetUserChoiceForGettingMarried(
                      isGettingMarried: false,
                      user: user,
                    ),
                  );
                }
                Navigator.of(context).push(
                  WedfluencerHelper.createRoute(page: no),
                );
              },
              hasIcon: false,
            ),
            WedfluencerDividers.transparentDividerForHeadings(),
          ],
        );
      },
    );
  }
}
