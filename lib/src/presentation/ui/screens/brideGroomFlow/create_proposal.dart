import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:wedfluencer/src/presentation/bloc/createProposal/create_proposal_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/screens/brideGroomFlow/upload_video.dart';
import 'package:wedfluencer/src/presentation/ui/templates/buttons.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';
import 'package:wedfluencer/src/presentation/ui/templates/headings.dart';
import 'package:wedfluencer/src/presentation/ui/templates/khairyat_appbar.dart';
import 'package:wedfluencer/src/presentation/ui/templates/multiDropdown.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

import '../../../../infrastructure/screen_size_config/screen_size_config.dart';
import '../../config/helper.dart';

class CreateProposalScreen extends StatefulWidget {
  const CreateProposalScreen({super.key});

  @override
  State<CreateProposalScreen> createState() => _CreateProposalScreenState();
}

class _CreateProposalScreenState extends State<CreateProposalScreen> {
  String isInWeddingShow = 'No';
  final titleController = TextEditingController();
  final referralCodeController = TextEditingController();
  final weddingShowName = TextEditingController();
  final weddingShowLocation = TextEditingController();
  final weddingShowDate = TextEditingController();
  List<ValueItem> selectedVendorCategory = [];

  Widget displayRichText() => RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text:
                  'Tired of explaining your wedding vision to multiple vendors repeatedly? Use our ',
              style: ScreenConfig.theme.textTheme.labelSmall?.copyWith(
                color: ScreenConfig.theme.hintColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: 'AI-powered feature! ',
              style: ScreenConfig.theme.textTheme.labelSmall?.copyWith(
                color: ScreenConfig.theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text:
                  'Share your vision in a video once, and we will match you with relevant vendors. They can then review your video and start a conversation. For the best results, ensure your ',
              style: ScreenConfig.theme.textTheme.labelSmall?.copyWith(
                color: ScreenConfig.theme.hintColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: 'face is clear, and your voice is audible ',
              style: ScreenConfig.theme.textTheme.labelSmall?.copyWith(
                color: ScreenConfig.theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text:
                  'in the video. Follow these rules to increase your chances of success without sharing personal information. Get the attention you need from vendors ',
              style: ScreenConfig.theme.textTheme.labelSmall?.copyWith(
                color: ScreenConfig.theme.hintColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: 'without the hassle! ',
              style: ScreenConfig.theme.textTheme.labelSmall?.copyWith(
                color: ScreenConfig.theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  Widget displayRadioButtons() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.scale(
                    scale: 0.8,
                    child: Radio<String>(
                      toggleable: true,
                      value: 'No',
                      groupValue: isInWeddingShow,
                      onChanged: (value) {
                        setState(() {
                          isInWeddingShow = value!;
                        });
                      },
                    ),
                  ),
                  Text('No', style: ScreenConfig.theme.textTheme.bodySmall),
                ],
              ),
              const SizedBox(width: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.scale(
                    scale: 0.8,
                    child: Radio<String>(
                      toggleable: true,
                      value: 'Yes',
                      groupValue: isInWeddingShow,
                      onChanged: (value) {
                        setState(() {
                          isInWeddingShow = value!;
                        });
                      },
                    ),
                  ),
                  Text('Yes', style: ScreenConfig.theme.textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ],
      );

  Widget displayWeddingShowForm() =>
      BlocBuilder<CreateProposalBloc, CreateProposalState>(
        builder: (context, state) {
          if (state is ReferralCodeVerified) {
            weddingShowName.text = state.referralCode.title;
            weddingShowLocation.text = state.referralCode.location;
            weddingShowDate.text = state.referralCode.startDate.toString();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WedfluencerTextFields.iconTextField(
                    width: ScreenConfig.screenSizeWidth * 0.72,
                    controller: referralCodeController,
                    showIcon: false,
                    hint: 'Referral Code',
                  ),
                  WedfluencerButtons.smallButton(
                    text: ' Verify',
                    textColor: Colors.white,
                    func: () {
                      BlocProvider.of<CreateProposalBloc>(context).add(
                          VerifyReferralCode(
                              referralCode: referralCodeController.text));
                    },
                    buttonColor: ScreenConfig.theme.colorScheme.primary,
                    hasIcon: false,
                    iconData: Icons.open_in_new,
                  ),
                ],
              ),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.iconTextField(
                controller: weddingShowName,
                enabled: false,
                showIcon: false,
                hint: 'Wedding Show Name',
              ),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.iconTextField(
                controller: weddingShowLocation,
                isGooglePlaces: true,
                showIcon: false,
                enabled: false,
                showSuffix: false,
              ),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.iconTextField(
                controller: weddingShowDate,
                showIcon: false,
                hint: 'Wedding Show Date',
              ),
              WedfluencerDividers.transparentDividerForHeadings(),
            ],
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WedfluencerAppbar.generalAppbar(
        showBackButton: true,
        context: context,
        title: 'Create Proposal',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WedfluencerDividers.transparentDividerForHeadings(),
              Center(
                child: WedfluencerHeadings.generalHeading(
                  heading:
                      'Start your request for vendor proposal'.toUpperCase(),
                  textAlign: TextAlign.center,
                ),
              ),
              WedfluencerDividers.transparentDivider(),
              displayRichText(),
              WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerHeadings.generalHeading(
                  heading: 'Are you at a Wedding Show?'),
              displayRadioButtons(),
              WedfluencerDividers.transparentDivider(),
              WedfluencerTextFields.iconTextField(
                controller: titleController,
                showIcon: false,
                hint: 'Enter Title',
              ),
              WedfluencerDividers.transparentDivider(),
              isInWeddingShow == 'Yes'
                  ? displayWeddingShowForm()
                  : const SizedBox(),
              isInWeddingShow == 'Yes'
                  ? const SizedBox()
                  : WedfluencerDividers.transparentDividerForHeadings(),
              WedfluencerHeadings.generalHeading(
                  heading: 'Select Vendor Category'),
              WedfluencerDividers.transparentDivider(),
              WedfluencerMultiDropdown.vendorServiceDropdown(
                onOptionSelected: (List<ValueItem> selectedOptions) {
                  selectedVendorCategory = selectedOptions;
                },
              ),
              WedfluencerDividers.transparentDividerForHeadings(),
              Center(
                child: BlocConsumer<CreateProposalBloc, CreateProposalState>(
                  listener: (context, state) {
                    print('state in create proposal');
                    print(state);
                    if (state is CreateProposalDetailsProvided) {
                      Navigator.of(context).push(
                        WedfluencerHelper.createRoute(
                          page: const UploadVideoScreen(),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return WedfluencerButtons.fullWidthButton(
                      text: 'Next',
                      func: () {
                        BlocProvider.of<CreateProposalBloc>(context)
                            .add(GetCreateProposalDetails(
                          title: titleController.text,
                          vendorCategories: selectedVendorCategory,
                          isInWeddingShow:
                              isInWeddingShow == 'Yes' ? true : false,
                          referralCode: '',
                          weddingShowName: '',
                          weddingShowDate: '',
                          weddingLocation: '',
                          eventId: '',
                        ));
                      },
                      hasIcon: false,
                      buttonColor: ScreenConfig.theme.primaryColor,
                      textColor: Colors.white,
                    );
                  },
                ),
              ),
              WedfluencerDividers.spacingForScreenEnd()
            ],
          ),
        ),
      ),
    );
  }
}
