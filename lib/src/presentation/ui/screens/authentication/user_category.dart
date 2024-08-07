import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/models/user_model.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/vendor_registration_details.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/wedding_planner_registration_screen.dart';
import 'package:wedfluencer/src/presentation/ui/screens/authentication/wedding_producer_registration_details.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../config/helper.dart';
import '../../templates/buttons.dart';
import '../../templates/decorations.dart';
import '../../templates/dividers.dart';

class UserCategoryScreen extends StatelessWidget {
  const UserCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WedfluencerDecorations.mainContainer(
      context: context,
      heading: 'Signup As Professionals',
      children: [
        WedfluencerDividers.transparentDividerForHeadings(),
        WedfluencerButtons.fullWidthButton(
          text: 'I am a Vendor',
          textColor: Colors.white,
          func: () {
            final state = BlocProvider.of<UserBloc>(context).state;
            if (state is GotUserChoiceForWeddingBusiness) {
              state.user.role = UserRole.vendor;
              BlocProvider.of<UserBloc>(context).add(
                GetUserChoiceForWeddingBusiness(
                  isInWeddingBusiness: true,
                  user: state.user,
                ),
              );
            }

            Navigator.of(context).push(
              WedfluencerHelper.createRoute(
                page: const VendorRegistrationDetails(),
              ),
            );
          },
          buttonColor: ScreenConfig.theme.colorScheme.primary,
          hasIcon: false,
        ),
        WedfluencerDividers.transparentDivider(),
        WedfluencerButtons.fullWidthButton(
          text: 'I am a Wedding Planner',
          textColor: Colors.white,
          func: () {
            final state = BlocProvider.of<UserBloc>(context).state;
            if (state is GotUserChoiceForWeddingBusiness) {
              state.user.role = UserRole.weddingPlanner;
              BlocProvider.of<UserBloc>(context).add(
                GetUserChoiceForWeddingBusiness(
                  isInWeddingBusiness: true,
                  user: state.user,
                ),
              );
            }
            Navigator.of(context).push(
              WedfluencerHelper.createRoute(
                page: const WeddingPlannerRegistrationDetails(),
              ),
            );
          },
          buttonColor: ScreenConfig.theme.colorScheme.primary,
          hasIcon: false,
        ),
        WedfluencerDividers.transparentDivider(),
        WedfluencerButtons.fullWidthButton(
          text: 'I am a Wedding Producer',
          textColor: Colors.white,
          func: () {
            final state = BlocProvider.of<UserBloc>(context).state;
            if (state is GotUserChoiceForWeddingBusiness) {
              state.user.role = UserRole.weddingProducer;
              BlocProvider.of<UserBloc>(context).add(
                GetUserChoiceForWeddingBusiness(
                  isInWeddingBusiness: true,
                  user: state.user,
                ),
              );
            }
            Navigator.of(context).push(
              WedfluencerHelper.createRoute(
                page: const WeddingProducerRegistrationDetails(),
              ),
            );
          },
          buttonColor: ScreenConfig.theme.colorScheme.primary,
          hasIcon: false,
        ),
        WedfluencerDividers.transparentDividerForHeadings(),
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
