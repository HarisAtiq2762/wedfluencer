import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:wedfluencer/src/infrastructure/resources/payment/payment_provider.dart';
import 'package:wedfluencer/src/infrastructure/resources/payment/payment_repository.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/bloc/userProposals/user_proposals_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/templates/bottomsheets.dart';
import 'package:wedfluencer/src/presentation/ui/templates/cards.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

import '../../templates/headings.dart';
import '../../templates/khairyat_appbar.dart';

class VendorLeadsScreen extends StatelessWidget {
  const VendorLeadsScreen({super.key});

  static final googlePlacesTextFiledController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    displayPaymentSheet(String clientSecret) async {
      try {
        await Stripe.instance.presentPaymentSheet().then((value) async {
          await Stripe.instance
              .confirmPayment(paymentIntentClientSecret: clientSecret);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Paid successfully!")));
        }).onError((error, stackTrace) {
          throw Exception(error);
        });
      } on StripeException catch (e) {
        if (kDebugMode) {
          print('Error is:---> $e');
        }
      }
    }

    Future<void> makePayment(
        {required String sessionId, required int payment}) async {
      try {
        final paymentIntent =
            await PaymentProvider().createPaymentIntent(payment * 100, 'USD');

        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent['client_secret'],
            merchantDisplayName: 'Wedfluencer',
            style: ThemeMode.light,
            customFlow: false,
          ),
        );

        displayPaymentSheet(paymentIntent['client_secret']);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }

    displayLeadVideos() => BlocBuilder<UserProposalsBloc, UserProposalsState>(
          builder: (context, state) {
            if (state is UserProposalsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GotUserProposals) {
              final countsOfProposals = state.proposalVideoApiResponse;
              return SizedBox(
                height: ScreenConfig.screenSizeHeight * 0.72,
                child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: countsOfProposals.proposalVideos.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final video = countsOfProposals.proposalVideos[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: WedfluencerCards.leadCard(
                          proposalVideo: video,
                          onTap: () =>
                              WedfluencerBottomSheets.displayBottomSheet(
                                  context: context,
                                  proposalVideo: video,
                                  onTap: () async {
                                    if (video.hasPaid) {
                                      print('yes already paid');
                                    } else {
                                      final sessionId =
                                          await PaymentRepository()
                                              .paymentProvider
                                              .createSessionOnStripe(
                                                  videoId: video.id);
                                      Navigator.pop(context);
                                      print(sessionId);
                                      makePayment(
                                          sessionId: sessionId,
                                          payment: video.price);
                                    }
                                  }),
                        ),
                      );
                    }),
              );
              // return GridView.builder(
              //   gridDelegate:
              //       const SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisSpacing: 12,
              //     mainAxisSpacing: 12,
              //     crossAxisCount: 2,
              //   ),
              //   shrinkWrap: true,
              //   itemCount: 11,
              //   itemBuilder: (context, index) {
              //     return WedfluencerCards.leadCard(
              //       onTap: () => displayBottomSheet(context: context),
              //     );
              //   },
              // );
            }
            return const Center(
              child: Text('No Leads Found'),
            );
          },
        );

    displaySearchBar() => WedfluencerTextFields.iconTextField(
          controller: TextEditingController(),
          iconData: Icons.search,
          hint: 'Search the content',
          showSuffix: true,
          suffixIcon: Icons.filter_list_sharp,
          color: Colors.white,
          onTapSuffix: () {
            WedfluencerBottomSheets.displayFilterBottomSheet(
                context: context,
                googlePlacesTextFiledController:
                    googlePlacesTextFiledController);
          },
        );

    return Scaffold(
      backgroundColor: ScreenConfig.theme.scaffoldBackgroundColor,
      appBar: WedfluencerAppbar.generalAppbar(
        showBackButton: false,
        context: context,
        title: 'Events',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WedfluencerDividers.transparentDivider(),
            displaySearchBar(),
            WedfluencerDividers.transparentDivider(),
            WedfluencerHeadings.generalHeading(
              heading: 'Leads Videos'.toUpperCase(),
              textAlign: TextAlign.center,
            ),
            WedfluencerDividers.transparentDivider(),
            displayLeadVideos(),
          ],
        ),
      ),
    );
  }
}
