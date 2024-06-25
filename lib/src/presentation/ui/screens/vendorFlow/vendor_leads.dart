import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/models/proposal_video.dart';
import 'package:wedfluencer/src/presentation/bloc/chat/chat_bloc.dart';
import 'package:wedfluencer/src/presentation/bloc/userProposals/user_proposals_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/templates/bottomsheets.dart';
import 'package:wedfluencer/src/presentation/ui/templates/cards.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

import '../../../../infrastructure/dependency_injection.dart';
import '../../../../infrastructure/domain/authentication/auth_repository.dart';
import '../../../bloc/makePayment/payment_bloc.dart';
import '../../config/helper.dart';
import '../../templates/buttons.dart';
import '../../templates/headings.dart';
import '../../templates/khairyat_appbar.dart';
import '../../templates/snackbar.dart';
import '../chat/message_screen.dart';

class VendorLeadsScreen extends StatefulWidget {
  const VendorLeadsScreen({super.key});

  @override
  State<VendorLeadsScreen> createState() => _VendorLeadsScreenState();
}

class _VendorLeadsScreenState extends State<VendorLeadsScreen> {
  final googlePlacesTextFiledController = TextEditingController();
  int skip = 0;
  late ScrollController controller;
  List<ProposalVideo> proposalVideos = [];

  void onEndPage() {
    DI.i<UserProposalsBloc>().add(GetUserProposals(
          isMe: false,
          accessToken: DI.i<AuthRepository>().accessToken,
          skip: '${skip += 5}',
          proposalVideos: proposalVideos,
        ));
  }

  void scrollToIndex() async {
    if (proposalVideos.length > 5) {
      await Future.delayed(const Duration(seconds: 3));
      controller.animateTo(
        (skip) *
            ScreenConfig.screenSizeHeight *
            0.74, // Here, assuming each item has a height of 50.0
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 10) {
      onEndPage();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
    DI.i<UserProposalsBloc>().add(GetUserProposals(
        accessToken: DI.i<AuthRepository>().user!.userId,
        isMe: false,
        skip: '0',
        proposalVideos: []));
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    displayLeadVideos() => BlocBuilder<UserProposalsBloc, UserProposalsState>(
          builder: (context, state) {
            if (state is UserProposalsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GotUserProposals) {
              final countsOfProposals = state.proposalVideoApiResponse;
              proposalVideos = countsOfProposals.proposalVideos;
              final listview = SizedBox(
                height: ScreenConfig.screenSizeHeight * 0.72,
                child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: countsOfProposals.proposalVideos.length,
                    shrinkWrap: true,
                    controller: controller,
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
                            button: BlocConsumer<PaymentBloc, PaymentState>(
                              listener: (context, state) {
                                if (state is PaymentSessionCreated) {
                                  BlocProvider.of<PaymentBloc>(context).add(
                                      CreatePaymentIntent(
                                          videoId: state.videoId,
                                          sessionId: state.sessionId,
                                          amount: state.price,
                                          currency: 'USD'));
                                } else if (state is PaymentIntentCreated) {
                                  BlocProvider.of<PaymentBloc>(context)
                                      .add(MakePayment(
                                    paymentIntent: state.paymentIntent,
                                    payment: state.payment,
                                    context: context,
                                    sessionId: state.sessionId,
                                  ));
                                } else if (state is PaymentMade) {
                                  // Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    WedfluencerSnackBar.showSnackBar(
                                        'Payment is Successful!'),
                                  );
                                  DI.i<UserProposalsBloc>().add(
                                      GetUserProposals(
                                          isMe: false,
                                          skip: '0',
                                          proposalVideos:
                                              countsOfProposals.proposalVideos,
                                          accessToken: DI
                                              .i<AuthRepository>()
                                              .accessToken));
                                  DI.i<ChatBloc>().add(GetChatDetails(
                                        id: video.chatRoom.first.id,
                                      ));
                                  Navigator.push(
                                      context,
                                      WedfluencerHelper.createRoute(
                                        page: ChatScreen(
                                          chatMessageDetails: const [],
                                          chatId: video.chatRoom.first.id,
                                          isOnline: false,
                                          userId: video.userId,
                                          imageUrl: '',
                                          proposal: video.title,
                                          person: video.user.username,
                                        ),
                                      ));
                                } else if (state is PaymentError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    WedfluencerSnackBar.showSnackBar(
                                      color: Colors.red,
                                      state.error,
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (!video.hasPaid) {
                                  return WedfluencerButtons.smallButton(
                                    text: 'Pay',
                                    textColor: Colors.white,
                                    func: () {
                                      BlocProvider.of<PaymentBloc>(context).add(
                                          CreatePaymentSession(
                                              amount: video.price.toDouble(),
                                              videoId: video.id));
                                    },
                                    buttonColor:
                                        ScreenConfig.theme.colorScheme.primary,
                                    hasIcon: false,
                                    iconData: Icons.open_in_new,
                                  );
                                } else if (video.hasPaid) {
                                  return WedfluencerButtons.smallButton(
                                    text: 'Chat',
                                    textColor: Colors.white,
                                    func: () async {
                                      DI.i<ChatBloc>().add(GetChatDetails(
                                            id: video.chatRoom.first.id,
                                          ));
                                      Navigator.push(
                                          context,
                                          WedfluencerHelper.createRoute(
                                            page: ChatScreen(
                                              chatMessageDetails: const [],
                                              chatId: video.chatRoom.first.id,
                                              isOnline: false,
                                              userId: video.userId,
                                              imageUrl: '',
                                              proposal: video.title,
                                              person: video.user.username,
                                            ),
                                          ));
                                    },
                                    buttonColor:
                                        ScreenConfig.theme.colorScheme.primary,
                                    hasIcon: false,
                                    iconData: Icons.open_in_new,
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          ),
                        ),
                      );
                    }),
              );
              // scrollToIndex();
              return listview;
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
